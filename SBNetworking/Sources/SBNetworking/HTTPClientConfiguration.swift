//
//  HTTPClientConfiguration.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import Foundation

// Configuration for HTTPClient, can be added more properties like api key, timeout etc.
struct HTTPClientConfiguration {
    let scheme: String
    let baseURL: String
}

// Environment for HTTPClient can be extended to support multiple environments
enum HTTPClientEnvironment {
    case development
    case production
    case custom(configuration: HTTPClientConfiguration)

    var configuration: HTTPClientConfiguration {
        var baseURL: String
        var scheme: String
        switch self {
        case .development:
            scheme = "https"
            baseURL = "itunes.apple.com"
        case .production:
            scheme = "https"
            baseURL = "itunes.apple.com"
        case .custom(let configuration):
            scheme = "https"
            baseURL = configuration.baseURL
        }
        return HTTPClientConfiguration(
            scheme: scheme,
            baseURL: baseURL
        )
    }
}
