//
//  ProductionOrigin.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/8/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productionCompany = try? newJSONDecoder().decode(ProductionCompany.self, from: jsonData)

import Foundation

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

//   let productionCountry = try? newJSONDecoder().decode(ProductionCountry.self, from: jsonData)

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
