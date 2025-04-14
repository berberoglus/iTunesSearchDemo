//
//  SearchResultItemModel.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import Foundation
import SwiftData


@Model
final class SearchResultItemModel {
    var artistId: Int = 0
    @Attribute(.unique)
    var trackId: Int = 0
    var artistName: String = ""
    var trackName: String = ""
    var artworkUrl100: URL? = nil
    var releaseDate: String = ""
    var genres: [String]
    var formattedPrice: String?
    var trackViewUrl: URL?
    var desc: String?
    @Attribute(.externalStorage)
    var imageData: Data?

    init(
        artistId: Int,
        trackId: Int,
        artistName: String,
        trackName: String,
        artworkUrl100: URL?,
        releaseDate: String,
        genres: [String],
        formattedPrice: String?,
        trackViewUrl: URL?,
        desc: String?,
        imageData: Data?
    ) {
        self.artistId = artistId
        self.trackId = trackId
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl100 = artworkUrl100
        self.releaseDate = releaseDate
        self.genres = genres
        self.formattedPrice = formattedPrice
        self.trackViewUrl = trackViewUrl
        self.desc = desc
        self.imageData = imageData
    }
}
