//
//  PokemonDataMock.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 24/03/26.
//

import pokemon_shared

public struct PokemonDataMock {
    
    public init() {
        
    }
    
    public func getPokemonList() -> [Pokemon] {
        return [
            .init(
                id: 1,
                name: "Bulbasaur",
                types: [PokemonType.weed, PokemonType.poison],
                url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif"
            ),
            .init(
                id: 4,
                name: "Charmander",
                types: [PokemonType.fire, PokemonType.dragon],
                url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/4.gif"
            ),
            .init(
                id: 7,
                name: "Squirtle",
                types: [PokemonType.water],
                url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/7.gif"
            )
        ]
    }
}
