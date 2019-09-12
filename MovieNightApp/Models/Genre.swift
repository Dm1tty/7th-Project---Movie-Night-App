//
//  Genre.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/8/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//
//   let genre = try? newJSONDecoder().decode(Genre.self, from: jsonData)

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}


