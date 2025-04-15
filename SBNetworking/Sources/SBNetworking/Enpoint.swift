//
//  Enpoint.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import Foundation

protocol Endpoint {
    associatedtype ResponseType: Decodable
    var path: String { get }
    var method: HTTPMethod { get }
    var headerFields: [String: String]? { get }
    var payload: Encodable? { get }
    var queryParameters: [String: String]? { get }
}

extension Endpoint {
    var headerFields: [String: String]? { nil }
    var payload: Encodable? { nil }
    var queryParameters: [String: String]? { nil }
}
