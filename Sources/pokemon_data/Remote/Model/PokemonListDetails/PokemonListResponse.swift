//
//  PokemonListResponse.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation
import pokemon_shared

struct PokemonListResponse: Codable, Sendable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntity]
}
