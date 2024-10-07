//
//  Requirement.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation

protocol CharacterRequirement {
    func getCharacters() async throws -> [Character]
}
