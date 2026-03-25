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

public struct PokemonSpritesEntity: Codable, Sendable {
    public let frontDefault: String?
}

public struct PokemonTypeEntity: Codable, Sendable {
    public let slot: Int
    public let type: PokemonTypeData
}

public struct PokemonTypeData: Codable, Sendable {
    public let name: String
    public let url: String
}

public struct PokemonAbilityEntity: Codable, Sendable {
    public let ability: AbilityEntity
    public let isHidden: Bool
    public let slot: Int
}

public struct AbilityEntity: Codable, Sendable {
    public let name: String
    public let url: String
}
