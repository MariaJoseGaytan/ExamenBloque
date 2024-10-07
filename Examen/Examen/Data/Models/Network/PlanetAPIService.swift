//
//  PlanetAPIService.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 07/10/24.
//

import Foundation
import Alamofire

class PlanetAPIService {
    
    static let shared = PlanetAPIService()
    
    private init() {}
    
    func fetchPlanet(from url: URL) async throws -> Planet {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
                .validate()
                .responseDecodable(of: Planet.self) { response in
                    switch response.result {
                    case .success(let planet):
                        continuation.resume(returning: planet)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}

