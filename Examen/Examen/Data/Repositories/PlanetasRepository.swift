//
//  PlanetasRepository.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import Foundation

class PlanetRepository: PlanetRequirement {
    
    private let planetAPIService: PlanetAPIService
    private var cachedPlanets: [Int: Planet] = [:]
    
    init(planetAPIService: PlanetAPIService = .shared) {
        self.planetAPIService = planetAPIService
    }
    
    func getPlanet(id: Int) async throws -> Planet {
        if let cachedPlanet = cachedPlanets[id] {
            return cachedPlanet
        }
        guard let url = constructURL(for: id) else {
            throw URLError(.badURL)
        }
        let planet = try await planetAPIService.fetchPlanet(from: url)
        cachedPlanets[id] = planet
        return planet
    }
    
    func getAllPlanets() async throws -> [Planet] {
        let planetIDs = Array(1...25)
        var planets: [Planet] = []
        
        try await withThrowingTaskGroup(of: Planet?.self) { group in
            for id in planetIDs {
                group.addTask {
                    do {
                        let planet = try await self.getPlanet(id: id)
                        return planet
                    } catch {
                        return nil
                    }
                }
            }
            
            for try await planet in group {
                if let planet = planet {
                    planets.append(planet)
                }
            }
        }
        
        return planets.sorted { $0.id < $1.id }
    }
    
    private func constructURL(for id: Int) -> URL? {
        return URL(string: "\(Api.base)\(Api.Routes.planets)/\(id)")
    }
}
