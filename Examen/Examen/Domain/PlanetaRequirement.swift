//
//  PlanetaRequirement.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import Foundation

protocol PlanetRequirement {
    func getPlanet(id: Int) async throws -> Planet
    func getAllPlanets() async throws -> [Planet]
}
