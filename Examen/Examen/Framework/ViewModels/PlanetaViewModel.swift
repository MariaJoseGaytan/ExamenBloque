//
//  PlanetaViewModel.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import Foundation
import Combine

@MainActor
class PlanetViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let planetRepository: PlanetRequirement
    private var cancellables = Set<AnyCancellable>()
    

    init(planetRepository: PlanetRequirement = PlanetRepository()) {
        self.planetRepository = planetRepository
    }
    

    func fetchPlanets() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let fetchedPlanets = try await planetRepository.getAllPlanets()
                self.planets = fetchedPlanets
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
