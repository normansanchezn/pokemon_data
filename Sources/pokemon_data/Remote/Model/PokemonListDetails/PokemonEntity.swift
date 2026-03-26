//
//  PokemonEntity.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 25/03/26.
//

import Foundation

public struct PokemonEntity: Codable, Sendable {
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
