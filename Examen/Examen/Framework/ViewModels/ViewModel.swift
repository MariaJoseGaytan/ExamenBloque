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
    
    private let characterRepository: CharacterRequirement
    
    init(characterRepository: CharacterRequirement = CharacterRepository()) {
        self.characterRepository = characterRepository
    }
    
    func fetchCharacters(reset: Bool = false) {
        guard !isLoading else { return }
        if reset {
            characters = []
        }
        isLoading = true
        Task {
            do {
                let fetchedCharacters = try await characterRepository.getCharacters(reset: reset)
                characters.append(contentsOf: fetchedCharacters)
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
        if characters.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            if characterRepository.canFetchMore() {
                fetchCharacters()
            }
        }
    }
}
