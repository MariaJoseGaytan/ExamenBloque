//
//  Repository.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation

class CharacterRepository: CharacterRequirement {
    
    func getCharacters() async throws -> [Character] {
        guard let url = URL(string: "\(Api.base)\(Api.Routes.characters)") else {
            throw URLError(.badURL)
        }
        print("URL generada: \(url)")
        
        let characterResponse = try await CharacterAPIService.shared.fetchCharacters(url: url)
        return characterResponse.items
    }
}

