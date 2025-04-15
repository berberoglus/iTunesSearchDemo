//
//  SearchResultItemView.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import SwiftUI
import Kingfisher
import SwiftData

struct SearchResultsView: View {
    @Environment(\.modelContext) private var context
    @Query private var searchResults: [SearchResultItemModel]

    var body: some View {
        Group {
            if searchResults.isEmpty {
                contentUnavailableView
            } else {
                List {
                    ForEach(searchResults) { item in
                        NavigationLink {
                            SearchResultItemDetailView(item: item)
                        } label: {
                            createItemView(for: item)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Subviews

private extension SearchResultsView {
    @ViewBuilder
    var contentUnavailableView: some View {
        ContentUnavailableView(
            "No results found",
            systemImage: "x.circle.fill",
            description: Text("Try searching for something else.")
        )
    }

    @ViewBuilder
    func createItemView(for item: SearchResultItemModel) -> some View {
        HStack {
            KFImage(item.artworkUrl100)
                .onSuccess { result in
                    item.imageData = result.image.pngData()
                }
                .resizable()
                .frame(width: 100, height: 100)
            createLabeledContentViews(for: item)
        }
    }

    @ViewBuilder
    private func createLabeledContentViews(for item: SearchResultItemModel) -> some View {
        let contents: [LocalizedKeyValue] = [
            .init(key: "Track Name", value: item.trackName),
            .init(key: "Artist Name", value: item.artistName),
            .init(key: "Price", value: item.formattedPrice),
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
        }
    }
}

#Preview {
    SearchResultsView()
}
