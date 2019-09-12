//
//  MovieResults.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/11/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResults = try? newJSONDecoder().decode(MovieResults.self, from: jsonData)

import Foundation

// MARK: - MovieResults
struct MovieResults: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
