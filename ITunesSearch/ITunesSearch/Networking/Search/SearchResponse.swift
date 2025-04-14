//
//  SearchResponse.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [SearchResultITem]
}

struct SearchResultITem: Decodable {
    let artistId: Int
    let trackId: Int
    let artistName: String
    let trackName: String
    let artworkUrl100: URL?
    let releaseDate: String
    let genres: [String]
    let formattedPrice: String?
    let trackViewUrl: URL?
}
