//
//  PokemonGenusEntity.swift
//  pokemon_data
//
//  Created by Codex on 26/03/26.
//

import Foundation

public struct PokemonGenusEntity: Codable, Sendable {
    public let genus: String
    public let language: PokemonLanguageEntity
}
