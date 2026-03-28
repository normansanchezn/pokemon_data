//
//  UserRepositoryImpl.swift
//  pokemon_data
//
//  Created by Norman Sánchez on 27/03/26.
//

import Foundation
import pokemon_shared
import pokemon_domain
import Supabase

public struct UserRepositoryImpl: UserRepository {
    
    private let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func getUser() async throws -> PokemonUser {
        let user = supabaseClient.auth.currentUser
        if user == nil { throw PokeErrorType.UserNotFound }
        return PokemonUser(id: user?.id.uuidString ?? "", email: user?.email ?? "")
    }
}
