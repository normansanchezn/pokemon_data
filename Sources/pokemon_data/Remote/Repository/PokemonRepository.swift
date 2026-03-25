import Foundation
import pokemon_domain
import pokemon_shared

public struct PokemonRepositoryImpl: PokemonRepository {
    private let api: PokemonAPIFetcher

    public init(api: PokemonAPIFetcher) {
        self.api = api
    }

    public func fetchPokemonList() async throws -> [Pokemon] {
        try await api.execute().transform()
    }
}

private extension [PokemonDetailEntity] {
    func transform() -> [Pokemon] {
        map { item in
            Pokemon(
                id: item.id,
                name: item.name,
                types: item.types.compactMap { $0.transform() },
                url: item.sprites?.frontDefault ?? ""
            )
        }
    }
}

extension PokemonTypeEntity {
    func transform() -> PokemonType? {
        switch type.name.lowercased() {
        case "grass":
            return .weed
        case "fire":
            return .fire
        case "water":
            return .water
        case "ground":
            return .earth
        case "bug":
            return .bug
        case "psychic":
            return .psychic
        case "flying":
            return .flying
        case "ice":
            return .ice
        case "dragon":
            return .dragon
        case "ghost":
            return .ghost
        case "dark":
            return .dark
        case "steel":
            return .steel
        case "fairy":
            return .fairy
        case "poison":
            return .poison
        default:
            return nil
        }
    }
}
