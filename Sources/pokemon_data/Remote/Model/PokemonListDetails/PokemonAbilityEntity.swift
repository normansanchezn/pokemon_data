//
//  PokemonAbilityEntity.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 26/03/26.
//

import Foundation

public struct PokemonAbilityEntity: Codable, Sendable {
    public let ability: AbilityEntity
    public let isHidden: Bool
    public let slot: Int
}
