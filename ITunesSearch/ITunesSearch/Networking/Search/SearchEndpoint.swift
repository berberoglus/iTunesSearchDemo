//
//  SearchEndpoint.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import Foundation

struct SearchEndpoints {

    private enum Path {
        case search

        fileprivate var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
    }

    static func search(for term: String) -> SearchEndpoint {
        SearchEndpoint(
            path: Path.search.path,
            method: .get,
            queryParameters: ["term": term, "limit": "20", "entity": "ebook"]
        )
    }
}

struct SearchEndpoint: Endpoint {
    typealias ResponseType = SearchResponse
    let path: String
    let method: HTTPMethod
    let queryParameters: [String: String]?
}
