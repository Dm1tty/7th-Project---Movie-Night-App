//
//  Genres.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/11/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let genres = try? newJSONDecoder().decode(Genres.self, from: jsonData)

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}
