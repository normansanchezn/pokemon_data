import Foundation

public enum PokemonAPIFetcherError: Error {
    case invalidURL
}

public final class PokemonAPIFetcherImpl: PokemonAPIFetcher, @unchecked Sendable {
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

    public func execute() async throws -> [PokemonDetailEntity] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=150&offset=0") else {
            throw PokemonAPIFetcherError.invalidURL
        }

        let (data, _) = try await session.data(from: url)
        let result = try decoder.decode(PokemonListResponse.self, from: data)

        var pokemonDetailList: [PokemonDetailEntity] = []
        pokemonDetailList.reserveCapacity(result.results.count)

        for pokemon in result.results {
            guard let pokemonURL = URL(string: pokemon.url) else {
                continue
            }

            do {
                let (detailData, _) = try await session.data(from: pokemonURL)
                let pokemonDetailsEntity = try decoder.decode(PokemonDetailEntity.self, from: detailData)
                pokemonDetailList.append(pokemonDetailsEntity)
            } catch {
                continue
            }
        }

        return pokemonDetailList
    }
}
