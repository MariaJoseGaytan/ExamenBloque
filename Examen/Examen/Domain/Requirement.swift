//
//  Requirement.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation

protocol CharacterRequirement {
    func getCharacters(reset: Bool) async throws -> [Character]
    func canFetchMore() -> Bool
    func getAllCharacters() -> [Character]
}
