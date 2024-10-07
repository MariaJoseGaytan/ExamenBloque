//
//  ViewModel.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation
import Combine


@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // Criterios de búsqueda y filtrado
    @Published var searchText: String = ""
    @Published var selectedGenders: Set<String> = []
    
    private let characterRepository: CharacterRequirement
    private var cancellables = Set<AnyCancellable>()
    
    init(characterRepository: CharacterRequirement = CharacterRepository()) {
        self.characterRepository = characterRepository
        
        // Observa cambios en searchText y selectedGenders para aplicar filtros automáticamente
        Publishers.CombineLatest($searchText, $selectedGenders)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] (search, genders) in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }
    
    func fetchCharacters(reset: Bool = false) {
        guard !isLoading else { return }
        if reset {
            characters = []
        }
        isLoading = true
        Task {
            do {
                _ = try await characterRepository.getCharacters(reset: reset)
                applyFilters()
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
    
    func loadMoreIfNeeded(currentItem: Character?) {
        guard let currentItem = currentItem else {
            fetchCharacters()
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if let index = characters.firstIndex(where: { $0.id == currentItem.id }),
           index >= thresholdIndex {
            if characterRepository.canFetchMore() {
                fetchCharacters()
            }
        }
    }
    
    // Aplicar filtros y búsqueda sobre todos los personajes
    func applyFilters() {
        let allCharacters = characterRepository.getAllCharacters()
        
        let filtered = allCharacters.filter { character in
            // Filtrar por nombre (búsqueda)
            let nameMatch = searchText.isEmpty || character.name.lowercased().contains(searchText.lowercased())
            
            // Filtrar por género
            let genderMatch = selectedGenders.isEmpty || selectedGenders.contains(character.gender)
            
            return nameMatch && genderMatch
        }
        
        characters = filtered
    }
    
    // Métodos para actualizar los filtros
    func toggleGender(_ gender: String) {
        if selectedGenders.contains(gender) {
            selectedGenders.remove(gender)
        } else {
            selectedGenders.insert(gender)
        }
    }
}
