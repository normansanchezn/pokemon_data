//
//  PokemonDetailEntity.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation

public struct PokemonDetailEntity: Codable, Sendable {
    public let id: Int
    public let name: String
    public let types: [PokemonTypeEntity]
    public let sprites: PokemonSpritesEntity?
    public let abilities: [PokemonAbilityEntity]
    public let moves: [PokemonMoveEntity]
    public let weight: Int
    public let height: Int
}
