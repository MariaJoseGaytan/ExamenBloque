//
//  Planetas.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import Foundation

struct Planet: Codable, Identifiable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    let deletedAt: String?
    let characters: [Character]
}

struct PlanetResponse: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    let deletedAt: String?
    let characters: [Character]
}
