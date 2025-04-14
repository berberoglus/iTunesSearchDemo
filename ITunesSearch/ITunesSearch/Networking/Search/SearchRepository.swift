//
//  SearchRepository.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import Foundation

struct SearchRepository {

    let httpClient = HTTPClient(environment: .development)

    func search(for term: String) async throws -> SearchResponse? {
        let endpoint = SearchEndpoints.search(for: term)
        return try await httpClient.sendRequest(endpoint: endpoint)
    }
}
