//
//  Strig+Extension.swift
//  Omdb-Api
//
//  Created by kadir on 2.11.2022.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
