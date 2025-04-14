//
//  SearchResultItemDetailView.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import SwiftUI
import Kingfisher

struct SearchResultItemDetailView: View {
    let item: SearchResultItemModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    KFImage(item.artworkUrl100)
                        .resizable()
                        .frame(width: 200, height: 200)

                    if let trackViewUrl = item.trackViewUrl {
                        Link("Store Page", destination: trackViewUrl)
                    }

                    createLabeledContentViews(for: item)
                }
                .padding()
            }
        }
        .navigationTitle(item.trackName)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func createLabeledContentViews(for item: SearchResultItemModel) -> some View {
        let contentDict = [
            "Track Name": item.trackName,
            "Artist Name": item.artistName,
            "Price": item.formattedPrice,
            "Relaease Date": item.releaseDate.toFormattedDateString(),
            "Genres": item.genres.joined(separator: ", ").nilWhenEmpty,
            "Description": item.desc?.nilWhenEmpty,
        ]
            .compactMapValues { $0 }
            .sorted(by: { $0.key < $1.key })

        VStack {
            ForEach(contentDict, id: \.key) { key, value in
                LabeledContent {
                    Text(value)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } label: {
                    Text(key)
                        .foregroundStyle(.primary)
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        }
    }
}

#Preview {
    SearchResultItemDetailView(item: SearchResultItem.mockItems[0].toModel())
}
