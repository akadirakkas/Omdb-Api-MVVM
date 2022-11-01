//
//  Movie.swift
//  Omdb-Api
//
//  Created by kadir on 31.10.2022.
//

import Foundation

struct Movie: Codable, Hashable {
    let title, year, imdbID, poster: String?
    let type: ContentType?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
        case type = "Type"
    }
}

enum ContentType: String, Codable {
    case movie
    case series
    case game
}
