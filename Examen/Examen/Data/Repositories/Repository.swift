//
//  Repository.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation

class CharacterRepository: CharacterRequirement {
    
    private var currentPage = 1
    private let limit = 10
    private var totalPages = 1
    private var isFetching = false
    private var allCharacters: [Character] = []
    
    func getCharacters(reset: Bool = false) async throws -> [Character] {
        if reset {
            currentPage = 1
            totalPages = 1
            allCharacters = []
        }
        
        guard !isFetching else { return [] }
        guard currentPage <= totalPages else { return [] }
        
        isFetching = true
        defer { isFetching = false }
        
        guard let url = constructURL(page: currentPage, limit: limit) else {
            throw URLError(.badURL)
        }
        
        
        let characterResponse = try await CharacterAPIService.shared.fetchCharacters(url: url)
        self.totalPages = characterResponse.meta.totalPages
        let fetchedCharacters = characterResponse.items
        self.allCharacters.append(contentsOf: fetchedCharacters)
        self.currentPage += 1
        return fetchedCharacters
    }
    
    func canFetchMore() -> Bool {
        return currentPage <= totalPages && !isFetching
    }
    
    private func constructURL(page: Int, limit: Int) -> URL? {
        guard var components = URLComponents(string: "\(Api.base)\(Api.Routes.characters)") else {
            return nil
        }
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        return components.url
    }
    
    func getAllCharacters() -> [Character] {
        return allCharacters
    }
}
