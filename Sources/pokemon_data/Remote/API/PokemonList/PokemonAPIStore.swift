//
//  PokemonAPIFetcher.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation
import pokemon_shared

public protocol PokemonAPIStore: Sendable {
    func execute(limit: Int, offset: Int) async throws -> [Pokemon]
    func getPokemonDetails(pokemonID: Int) async throws -> DetailsPokemon
}
