//
//  PokemonFlavorTextEntryEntity.swift
//  pokemon_data
//
//  Created by Codex on 26/03/26.
//

import Foundation

public struct PokemonFlavorTextEntryEntity: Codable, Sendable {
    public let flavorText: String
    public let language: PokemonLanguageEntity
}
