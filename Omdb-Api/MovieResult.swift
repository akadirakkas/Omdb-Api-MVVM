//
//  MoviesResult.swift
//  Omdb-Api
//
//  Created by kadir on 31.10.2022.
//

import Foundation

struct MovieResult: Codable {
    let movies: [Movie]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}
