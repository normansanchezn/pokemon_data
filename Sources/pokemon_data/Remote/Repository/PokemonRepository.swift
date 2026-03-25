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
                url: item.frontDefaultImageURL
            )
        }
    }
}

private extension PokemonDetailEntity {
    var frontDefaultImageURL: String {
        sprites?.other?.showdown?.frontDefault ?? ""
    }
}

extension PokemonTypeEntity {
    func transform() -> PokemonType? {
        switch type.name.lowercased() {
        case "normal":
            return .normal
        case "fighting":
            return .fighting
        case "flying":
            return .flying
        case "poison":
            return .poison
        case "ground":
            return .ground
        case "rock":
            return .rock
        case "grass":
            return .grass
        case "fire":
            return .fire
        case "water":
            return .water
        case "electric":
            return .electric
        case "psychic":
            return .psychic
        case "ice":
            return .ice
        case "dragon":
            return .dragon
        case "dark":
            return .dark
        case "bug":
            return .bug
        case "ghost":
            return .ghost
        case "steel":
            return .steel
        case "fairy":
            return .fairy
        default:
            return nil
        }
    }
}
