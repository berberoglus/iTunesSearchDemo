//
//  String+Extensions.swift
//  ITunesSearch
//
//  Created by Samet Berberoğlu on 2025-04-14.
//

import Foundation

extension String {

    var nilWhenEmpty: String? {
        return isEmpty ? nil : self
    }

    func toFormattedDateString(
        inputFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ",
        outputFormat: String = "MMM d, yyyy"
    ) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat

        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
