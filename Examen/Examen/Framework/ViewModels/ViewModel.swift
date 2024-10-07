//
//  ViewModel.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation
import Combine


class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errorMessage: String?
    
    private let characterRepository: CharacterRequirement

    init(characterRepository: CharacterRequirement = CharacterRepository()) {
        self.characterRepository = characterRepository
    }
    
    func fetchCharacters() {
        Task {
            do {
                let fetchedCharacters = try await characterRepository.getCharacters()
                DispatchQueue.main.async {
                    self.characters = fetchedCharacters
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
