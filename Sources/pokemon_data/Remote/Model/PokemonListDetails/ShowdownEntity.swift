//
//  ShowdownEntity.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 26/03/26.
//

import Foundation

public struct ShowdownEntity: Codable, Sendable {
    public let backDefault: String?
    public let backFemale: String?
    public let backShiny: String?
    public let backShinyFemale: String?
    public let frontDefault: String?
    public let frontFemale: String?
    public let frontShiny: String?
    public let frontShinyFemale: String?
}
