//
//  ContentView.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import SwiftUI

struct SearchSceneView: View {
    @Environment(\.modelContext) private var context
    @State private var searchText = ""
    @State private var isSearchEnabled: Bool = false

    private let repository = SearchRepository()

    var body: some View {
        NavigationStack {
            Button {
                Task {
                    guard let result = try? await repository.search(for: searchText) else {
                        return
                    }
                    try? context.transaction {
                        try context.delete(model: SearchResultItemModel.self)
                        result.results.forEach { item in
                            context.insert(item.toModel())
                        }
                        try context.save()
                    }
                    isSearchEnabled = false
                    searchText = ""
                }
            } label: {
                Text("Search")
            }
            .buttonStyle(.borderedProminent)
            .disabled(searchText.isEmpty)

            SearchResultsView()
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
