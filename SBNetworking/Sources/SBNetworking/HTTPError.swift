//
//  HTTPError.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import Foundation

enum HTTPError: Error, LocalizedError, Equatable {
    case unknown
    case invalidURL
    case invalidResponse
    case noDecodable
    case unauthorized
    case clientError(statusCode: Int)
    case serverError(statusCode: Int, data: Data)
    case unexpectedStatusCode
    case notFound
    case notConnectedToInternet
    case networkConnectionLost

    // Error descriptions can be localized here
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Something went wrong"
        case .invalidURL:
            return "HTTPError: Invalid URL"
        case .invalidResponse:
            return "HTTPError: Invalid response"
        case .noDecodable:
            return "HTTPError: Object can't be decoded"
        case .unauthorized:
            return "HTTPError: Unauthorized"
        case .clientError(let statusCode):
            return "HTTPError: Client error (code: \(statusCode))"
        case .serverError(let statusCode, let data):
            let dataStr = String(describing: String(data: data, encoding: .utf8))
            return "HTTPError: Server error (code: \(statusCode)) /ndata: \(dataStr)"
        case .unexpectedStatusCode:
            return "HTTPError: Unexpected status code"
        case .notFound:
            return "HTTPError: Not Found"
        case .notConnectedToInternet, .networkConnectionLost:
            return "Not connected to the internet"
        }
    }
}
