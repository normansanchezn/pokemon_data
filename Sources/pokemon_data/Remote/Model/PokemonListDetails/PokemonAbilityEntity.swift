//
//  PokemonAbilityEntity.swift
//  pokemon_data
//
//  Created by Codex on 26/03/26.
//

import Foundation

public struct PokemonAbilityEntity: Codable, Sendable {
    public let ability: AbilityEntity
    public let isHidden: Bool
    public let slot: Int
}
