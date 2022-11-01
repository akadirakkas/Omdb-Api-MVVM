//
//  FirebaseManager.swift
//  Omdb-Api
//
//  Created by kadir on 1.11.2022.
//

import Foundation
import FirebaseAnalytics

class FirebaseManager {
    static let shared = FirebaseManager()


    public func logFilmDetails(title: String, year: String) {
        Analytics.logEvent("id_\(title.replacingOccurrences(of: " ", with: "_"))", parameters: [
            "year": year,
        ])
    }
}
