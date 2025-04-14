//
//  ITunesSearchApp.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-13.
//

import SwiftUI
import SwiftData

@main
struct ITunesSearchApp: App {
    var body: some Scene {
        WindowGroup {
            SearchSceneView()
        }
        .modelContainer(for: SearchResultItemModel.self)
    }
}
