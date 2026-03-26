//
//  PokemonDetailEntity.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation

public struct PokemonDetailEntity: Codable, Sendable {
    public let id: Int
    public let abilities: [PokemonAbilityEntity]
    public let baseExperience: Int
    public let height: Int
    public let name: String
    public let types: [PokemonTypeEntity]
    public let sprites: PokemonSpritesEntity?
    public let weight: Int
}
