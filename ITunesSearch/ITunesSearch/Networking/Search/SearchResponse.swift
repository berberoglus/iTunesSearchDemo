//
//  SearchResponse.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [SearchResultItem]
}

struct SearchResultItem: Decodable {
    let artistId: Int
    let trackId: Int
    let artistName: String
    let trackName: String
    let artworkUrl100: URL?
    let releaseDate: String
    let genres: [String]
    let formattedPrice: String?
    let trackViewUrl: URL?
    let description: String?
}

extension SearchResultItem: Identifiable {
    var id: String {
        return "\(artistId)-\(trackId)"
    }
}

extension SearchResultItem {
    func toModel() -> SearchResultItemModel {
        return SearchResultItemModel.init(
            artistId: artistId,
            trackId: trackId,
            artistName: artistName,
            trackName: trackName,
            artworkUrl100: artworkUrl100,
            releaseDate: releaseDate,
            genres: genres.joined(separator: ", ").nilWhenEmpty,
            formattedPrice: formattedPrice,
            trackViewUrl: trackViewUrl,
            desc: description,
            imageData: nil
        )
    }
}

// swiftlint:disable line_length
extension SearchResultItem {
    static let mockItems = [
        SearchResultItem(
            artistId: 1222,
            trackId: 1232,
            artistName: "Hugh Howey",
            trackName: "Silo",
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Publication/v4/70/0f/70/700f7034-b999-9b85-82b1-7999acf69619/9781101600764.jpg/100x100bb.jpg"),
            releaseDate: "2014-03-17T07:00:00Z",
            genres: ["Sci-Fi & Fantasy", "Books"],
            formattedPrice: "$13.99",
            trackViewUrl: nil,
            description: nil
        ),
        SearchResultItem(
            artistId: 1221,
            trackId: 1231,
            artistName: "Hugh Howey",
            trackName: "Silo 2",
            artworkUrl100: URL(
                string: "https://is1-ssl.mzstatic.com/image/thumb/Publication126/v4/a2/d8/e0/a2d8e022-434d-7a43-d93f-1d5b60acffb5/9780358512912.jpg/100x100bb.jpg"
            ),
            releaseDate: "2014-03-17T07:00:00Z",
            genres: [],
            formattedPrice: "$13.99",
            trackViewUrl: nil,
            description: nil
        ),
        SearchResultItem(
            artistId: 1224,
            trackId: 1234,
            artistName: "Hugh Howey",
            trackName: "Silo 3",
            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Publication126/v4/46/ad/b7/46adb752-65ae-1655-5142-c8cd15aa0c54/9788580574746.jpg/100x100bb.jpg"),
            releaseDate: "2014-03-17T07:00:00Z",
            genres: ["Sci-Fi & Fantasy", "Books"],
            formattedPrice: nil,
            trackViewUrl: nil,
            description: nil
        )
    ]
}
// swiftlint:enable line_length
