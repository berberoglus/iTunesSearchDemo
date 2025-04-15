//
//  LocalizedKeyValue.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-15.
//

import SwiftUI

struct LocalizedKeyValue: Identifiable {
    let id = UUID()
    let key: LocalizedStringKey
    let value: String?

    init(key: LocalizedStringKey, value: String?) {
        self.key = key
        self.value = value
    }
}
