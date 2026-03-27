import Foundation
import pokemon_shared

public final class PokemonAPIStoreImpl: PokemonAPIStore, @unchecked Sendable {
    
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    public func execute(limit: Int, offset: Int) async throws -> [Pokemon] {
        guard let url = makeListURL(limit: limit, offset: offset) else {
            throw PokemonAPIError.invalidURL
        }

        let data = try await performRequest(URLRequest(url: url))
        let result = try decoder.decode(PokemonListResponse.self, from: data)

        var pokemonList: [Pokemon] = []
        pokemonList.reserveCapacity(result.results.count)

        let orderedDetails = await withTaskGroup(of: (Int, Pokemon?).self) { group in
            for (index, pokemon) in result.results.enumerated() {
                group.addTask { [weak self] in
                    guard
                        let self,
                        let pokemonURL = URL(string: pokemon.url)
                    else {
                        return (index, nil)
                    }

                    do {
                        let detailData = try await self.performRequest(URLRequest(url: pokemonURL))
                        let pokemonDetailsEntity = try self.decoder.decode(PokemonDetailEntity.self, from: detailData)
                        return (index, pokemonDetailsEntity.toPokemon())
                    } catch {
                        return (index, nil)
                    }
                }
            }

            var items: [(Int, Pokemon)] = []
            for await item in group {
                if let pokemon = item.1 {
                    items.append((item.0, pokemon))
                }
            }

            return items.sorted { $0.0 < $1.0 }.map { $0.1 }
        }

        pokemonList.append(contentsOf: orderedDetails)

        return pokemonList
    }

    private func makeListURL(limit: Int, offset: Int) -> URL? {
        var components = URLComponents(string: PokemonAPI.POKE_API)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        return components?.url
    }
    
    public func getPokemonDetails(pokemonID: Int) async throws -> DetailsPokemon {
        async let detailEntity = fetchDetailEntity(pokemonID: pokemonID)
        async let speciesEntity = fetchSpeciesEntity(pokemonID: pokemonID)

        let detail = try await detailEntity
        let species = try await speciesEntity
        return detail.toDetailsPokemon(species: species)
    }

    private func performRequest(_ request: URLRequest) async throws -> Data {
        pokemon_shared.PokemonNetworkLogger.logRequest(request)

        let (data, _) = try await session.data(for: request)
        pokemon_shared.PokemonNetworkLogger.logResponse(request, data: data)

        return data
    }
}

private extension PokemonDetailEntity {
    func toPokemon() -> Pokemon {
        Pokemon(
            id: id,
            name: name,
            types: types.sorted { $0.slot < $1.slot }.compactMap { $0.transform() },
            url: sprites?.other?.showdown?.frontDefault ?? ""
        )
    }

    func toDetailsPokemon(species: PokemonSpeciesEntity) -> DetailsPokemon {
        let types = types.sorted { $0.slot < $1.slot }.compactMap { $0.transform() }
        let description = species.flavorTextEntries
            .first(where: { $0.language.name.lowercased() == "en" })?
            .flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000c}", with: " ")
            .replacingOccurrences(of: "  ", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let category = species.genera
            .first(where: { $0.language.name.lowercased() == "en" })?
            .genus ?? ""
        let mainAbility = abilities
            .sorted { $0.slot < $1.slot }
            .first?
            .ability
            .name
            .capitalized ?? ""
        let moves = moves
            .map { $0.move.name.capitalized }
            .sorted()

        return DetailsPokemon(
            id: id,
            name: name,
            types: types,
            url: sprites?.other?.showdown?.frontDefault ?? "",
            description: description,
            category: category,
            weight: Self.formatWeight(weight),
            height: Self.formatHeight(height),
            mainAbility: mainAbility,
            moves: moves
        )
    }

    static func formatWeight(_ weight: Int) -> String {
        String(format: "%.1f kg", Double(weight) / 10.0)
    }

    static func formatHeight(_ height: Int) -> String {
        String(format: "%.1f m", Double(height) / 10.0)
    }
}

private extension PokemonAPIStoreImpl {
    func fetchDetailEntity(pokemonID: Int) async throws -> PokemonDetailEntity {
        guard let url = URL(string: "\(PokemonAPI.POKE_API)/\(pokemonID)") else {
            throw PokemonAPIError.invalidURL
        }

        let data = try await performRequest(URLRequest(url: url))
        return try decoder.decode(PokemonDetailEntity.self, from: data)
    }

    func fetchSpeciesEntity(pokemonID: Int) async throws -> PokemonSpeciesEntity {
        guard let url = URL(string: "\(PokemonAPI.POKE_API_SPECIES)/\(pokemonID)") else {
            throw PokemonAPIError.invalidURL
        }

        let data = try await performRequest(URLRequest(url: url))
        return try decoder.decode(PokemonSpeciesEntity.self, from: data)
    }
}

private extension PokemonTypeEntity {
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
