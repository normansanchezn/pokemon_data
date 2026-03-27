//
//  PokemonSpeciesEntity.swift
//  pokemon_data
//
//  Created by Codex on 26/03/26.
//

import Foundation

public struct PokemonSpeciesEntity: Codable, Sendable {
    public let genera: [PokemonGenusEntity]
    public let flavorTextEntries: [PokemonFlavorTextEntryEntity]
}
