//
//  APIService.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation
import Alamofire

class CharacterAPIService {
    
    static let shared = CharacterAPIService()
    
    private init() {}
    
    func fetchCharacters(url: URL) async throws -> CharacterResponse {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
                .validate()
                .responseDecodable(of: CharacterResponse.self) { response in
                    switch response.result {
                    case .success(let characterResponse):
                        continuation.resume(returning: characterResponse)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
