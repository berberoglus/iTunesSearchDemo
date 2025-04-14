//
//  HTTPClient.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import Foundation

final class HTTPClient {

    private let environment: HTTPClientEnvironment

    init(environment: HTTPClientEnvironment) {
        self.environment = environment
    }

    @discardableResult
    func sendRequest<T: Endpoint>(endpoint: T) async throws -> T.ResponseType? {
        let request = try createDefaultRequest(for: endpoint)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            return try validateResponse(
                response,
                request: request,
                data: data,
                responseType: T.ResponseType.self
            )
        } catch let error {
            if let urlError = error as? URLError {
                if urlError.code == URLError.Code.notConnectedToInternet {
                    throw HTTPError.notConnectedToInternet
                } else if urlError.code == URLError.Code.networkConnectionLost {
                    throw HTTPError.networkConnectionLost
                } else {
                    throw error
                }
            } else {
                throw error
            }
        }
    }

    private func createDefaultRequest<T: Endpoint>(for endpoint: T) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = environment.configuration.scheme
        components.host = environment.configuration.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            throw HTTPError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headerFields

        if let body = endpoint.payload {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        return request
    }

    private func validateResponse<T: Decodable>(
        _ response: URLResponse,
        request: URLRequest,
        data: Data,
        responseType: T.Type
    ) throws -> T? {
        var error = HTTPError.invalidResponse

        guard let response = response as? HTTPURLResponse else {
            throw error
        }

        switch response.statusCode {
        case 200...299, 304:
            return try decodeResponse(
                request: request,
                response: response,
                data: data,
                responseType: T.self
            )
        case 401:
            error = HTTPError.unauthorized
        case 404:
            error = HTTPError.notFound
        case 400, 402, 403, 405...499:
            error = HTTPError.clientError(statusCode: response.statusCode)
        case 500...599:
            error = HTTPError.serverError(statusCode: response.statusCode, data: data)
        default:
            error = HTTPError.unexpectedStatusCode
        }

        throw error
    }

    private func decodeResponse<T: Decodable>(
        request: URLRequest,
        response: HTTPURLResponse,
        data: Data,
        responseType: T.Type
    ) throws -> T? {
        if response.statusCode == 204 {
            return nil
        }

        do {
            let decodedResponse = try JSONDecoder().decode(responseType.self, from: data)
            return decodedResponse
        } catch let error {
            throw HTTPError.noDecodable
        }
    }
}
