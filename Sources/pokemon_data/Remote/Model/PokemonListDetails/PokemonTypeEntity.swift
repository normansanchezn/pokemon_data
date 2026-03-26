//
//  PokemonTypeEntity.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 26/03/26.
//

import Foundation

public struct PokemonTypeEntity: Codable, Sendable {
    public let slot: Int
    public let type: PokemonTypeData
}
