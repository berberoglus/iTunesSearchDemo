//
//  ContentView.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import SwiftUI

struct SearchSceneView: View {
    @State private var items: [SearchResultItem] = []
    @State private var searchText = ""
    @State private var isSearchEnabled: Bool = false

    private let repository = SearchRepository()

    var body: some View {
        NavigationStack {
            Button {
                Task {
                    let result = try? await repository.search(for: searchText)
                    items = result?.results ?? []
                    isSearchEnabled = false
                    searchText = ""
                }
            } label: {
                Text("Search")
            }
            .buttonStyle(.borderedProminent)

            SearchResultItemView(items: items)
                .searchable(text: $searchText, isPresented: $isSearchEnabled, prompt: "Search Term")
                .navigationTitle("Search Results")
        }
    }
}

#Preview {
    NavigationStack {
        SearchSceneView()
    }
}
