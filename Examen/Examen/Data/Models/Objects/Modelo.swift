//
//  Modelo.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    let deletedAt: String?
}

struct CharacterResponse: Codable {
    let items: [Character]
    let meta: Meta
    let links: Links
}

struct Meta: Codable {
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}

struct Links: Codable {
    let first: String
    let previous: String?
    let next: String?
    let last: String
}
