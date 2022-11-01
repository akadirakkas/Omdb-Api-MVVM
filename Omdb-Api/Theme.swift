//
//  Theme.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import UIKit
struct Theme {

    static var color = Color.shared

    static var font = UIFont.poppins

    private init() {}

    struct Color {
        fileprivate static let shared = Color()

        let accent = UIColor(named: "AccentColor") ?? .hex("#CCE2FC")
        let background = UIColor(named: "VİewBG") ?? .hex("#FCFCFC")
        let textColor = UIColor(named: "TextColor") ?? .hex("#4C72A1")
        private init() {}
    }

}
