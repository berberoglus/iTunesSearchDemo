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
        let contents: [LocalizedKeyValue] = [
            .init(key: "Artist Name", value: item.artistName),
            .init(key: "Track Name", value: item.trackName),
            .init(key: "Relaease Date", value: item.releaseDate.toFormattedDateString()),
            .init(key: "Genres", value: item.genres),
            .init(key: "Price", value: item.formattedPrice),
            .init(key: "Description", value: item.desc),
        ].filter { $0.value != nil }

        VStack {
            ForEach(contents) { content in
                LabeledContent {
                    Text(content.value ?? "")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } label: {
                    Text(content.key)
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
