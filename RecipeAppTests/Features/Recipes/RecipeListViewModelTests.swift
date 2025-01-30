//
//  RecipeListViewModelTests.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Testing
@testable import RecipeApp

struct RecipeListViewModelTests {
    let mockRecipeService = RecipeService(
        networkManager: NetworkManager(
            apiHandler: APIHandlerValidResponse(),
            responseHandler: ResponseHandler()
        )
    )
    
    @Test("Check the initial state") func checkInitialization() async throws {
        let sut = RecipeListViewModel()
        #expect(sut.state == .notStarted)
        #expect(sut.recipes.isEmpty)
        #expect(sut.networkError == nil)
    }
    
    @Test("Check updating network option", arguments: NetworkOption.allCases)
    func checkSetNetworkOption(networkOption: NetworkOption) async throws {
        let sut = RecipeListViewModel.TestHooks(target: RecipeListViewModel(recipeService: mockRecipeService))
        sut.target.set(networkOption: networkOption)
        #expect(sut.selectedNetworkOption == networkOption)
    }
    
    @Test("Check get recipes if no network option is set") func checkGetRecipes() async throws {
        let sut = RecipeListViewModel.TestHooks(target: RecipeListViewModel(recipeService: mockRecipeService))
        #expect(sut.selectedNetworkOption == nil)
        await #expect(throws: NetworkError.invalidUrl) {
            _ = try await sut.getRecipes()
        }
    }
    
    @Test("Check get recipes invalid response") func checkGetRecipesInvalidResponse() async throws {
        let sut = RecipeListViewModel.TestHooks(
            target: RecipeListViewModel(
                recipeService: RecipeService(
                    networkManager: NetworkManager(
                        apiHandler: APIHandlerInvalidResponse()
                    )
                )
            )
        )
        sut.target.set(networkOption: .valid)
        #expect(sut.selectedNetworkOption == NetworkOption.valid)
        await #expect(throws: NetworkError.invalidResponse) {
            _ = try await sut.getRecipes()
        }
    }
    
    @Test("Check get recipes bad response data") func checkGetRecipesBadResponseData() async throws {
        let sut = RecipeListViewModel.TestHooks(
            target: RecipeListViewModel(
                recipeService: RecipeService(
                    networkManager: NetworkManager(
                        apiHandler: APIHandlerMalformedResponse()
                    )
                )
            )
        )
        sut.target.set(networkOption: .malformed)
        #expect(sut.selectedNetworkOption == NetworkOption.malformed)
        await #expect(throws: NetworkError.invalidData) {
            _ = try await sut.getRecipes()
        }
    }
    
    @Test("Check get recipes valid response") func checkGetRecipesValidResponse() async throws {
        let sut = RecipeListViewModel.TestHooks(
            target: RecipeListViewModel(
                recipeService: RecipeService(
                    networkManager: NetworkManager(
                        apiHandler: APIHandlerValidResponse()
                    )
                )
            )
        )
        sut.target.set(networkOption: .valid)
        #expect(sut.selectedNetworkOption == NetworkOption.valid)
        let recipes = try await sut.getRecipes()
        #expect(!recipes.isEmpty)
    }

    @Test("Check refresh recipes") func checkGetRefreshRecipes() async throws {
        let sut = RecipeListViewModel.TestHooks(
            target: RecipeListViewModel(
                recipeService: RecipeService(
                    networkManager: NetworkManager(
                        apiHandler: APIHandlerValidResponse()
                    )
                )
            )
        )
        sut.target.set(networkOption: .valid)
        #expect(sut.selectedNetworkOption == NetworkOption.valid)
        await sut.target.refresh()
        #expect(!sut.target.recipes.isEmpty)
    }
    
}
