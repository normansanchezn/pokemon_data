import Foundation
import pokemon_domain
import pokemon_shared

public struct PokemonRepositoryImpl: PokemonRepository {
    private let api: PokemonAPIStore

    public init(api: PokemonAPIStore) {
        self.api = api
    }

    public func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon] {
        try await api.execute(limit: limit, offset: offset)
    }
    
    public func getPokemonDetails(pokemonID: Int) async throws -> DetailsPokemon {
        try await api.getPokemonDetails(pokemonID: pokemonID)
    }
}
