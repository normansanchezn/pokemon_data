//
//  PokemonAPIFetcher.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation

public protocol PokemonAPIFetcher: Sendable {
    func execute() async throws -> [PokemonDetailEntity]
}
