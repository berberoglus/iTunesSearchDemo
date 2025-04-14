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
    @State private var isSearchEnabled = false
    @State private var isRequestInProgress = false
    @State private var shouldPresentErrorPopup = false

    private let repository = SearchRepository()
    
    var body: some View {
        NavigationStack {
            if isRequestInProgress {
                ProgressView("Searching...")
                    .progressViewStyle(.circular)
            } else {
                Button {
                    search()
                } label: {
                    Text("Search")
                }
                .buttonStyle(.borderedProminent)
                .disabled(searchText.isEmpty)
            }

            SearchResultsView()
                .searchable(text: $searchText, isPresented: $isSearchEnabled, prompt: "Search Term")
                .navigationTitle("Search Results")
                .alert(
                    "Error!",
                    isPresented: $shouldPresentErrorPopup,
                    actions: {
                        Button("Retry", role: .cancel) {
                            search()
                        }
                        Button("OK") { }
                    },
                    message: {
                        Text("Something went wrong while searching.")
                    }
                )
        }
    }

    private func search(){
        Task {
            isRequestInProgress = true
            do {
                let result = try await repository.search(for: searchText)
                try context.transaction {
                    try context.delete(model: SearchResultItemModel.self)
                    result?.results.forEach { item in
                        context.insert(item.toModel())
                    }
                    try context.save()
                }
                searchText = ""
            } catch {
                shouldPresentErrorPopup = true
            }
            isSearchEnabled = false
            isRequestInProgress = false
        }
    }
}

#Preview {
    NavigationStack {
        SearchSceneView()
    }
}
