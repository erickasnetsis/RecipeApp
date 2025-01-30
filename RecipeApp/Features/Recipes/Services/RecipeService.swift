//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

protocol RecipeServiceInterface {
    func getRecipes(url: URL) async throws -> RecipeResponse
}

final class RecipeService: RecipeServiceInterface {
    private let networkManager: NetworkManagerInterface
    
    init(networkManager: NetworkManagerInterface = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getRecipes(url: URL) async throws -> RecipeResponse {
        try await networkManager.fetchRequest(url: url)
    }
}
