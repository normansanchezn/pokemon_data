//
//  PokemonListResponse.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation
import pokemon_shared

struct PokemonListResponse: Codable, Sendable {
    let results: [PokemonEntity]
}
