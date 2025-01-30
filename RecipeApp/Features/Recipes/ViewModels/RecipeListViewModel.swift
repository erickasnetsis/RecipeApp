//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import SwiftUI

class RecipeListViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published private(set) var state: NetworkState = .notStarted
    @Published private(set) var recipes = [Recipe]()
    @Published var networkError: NetworkError?

    // MARK: - Private Properties
    
    private let recipeService: RecipeServiceInterface
    private var fetchTask: (Task<[Recipe], Never>)?
    private var selectedNetworkOption: NetworkOption? {
        didSet {
            if oldValue != selectedNetworkOption {
                Task { await fetch() }
            }
        }
    }
    
    // MARK: - Life Cycle
    
    init(recipeService: RecipeServiceInterface = RecipeService()) {
        self.recipeService = recipeService
    }
    
    // MARK: - Internal Methods
    
    func set(networkOption: NetworkOption) {
        selectedNetworkOption = networkOption
    }
    
    func refresh() async {
        await fetch()
    }
    
    // MARK: - Private Methods
    
    private func fetch() async {
        print("Fetching data")
        defer {
            Task { @MainActor in
                print("Done with task")
                state = .done
            }
        }

        fetchTask?.cancel()

        await MainActor.run {
            recipes = []
            state = .loading
        }
        
        fetchTask = Task {
            do {
                return try await getRecipes()
            } catch NetworkError.invalidData {
                await MainActor.run {
                    networkError = .invalidData
                }
            } catch {
                print("error: \(error.localizedDescription)")
            }
            return []
        }
        guard let results = await fetchTask?.value else {
            return
        }
        await MainActor.run {
            recipes = results
        }
    }
    
    private func getRecipes() async throws -> [Recipe] {
        guard let url = selectedNetworkOption?.endpointURL else {
            throw NetworkError.invalidUrl
        }
        
        let results = try await recipeService.getRecipes(url: url)
        return results.recipes
    }
}

#if DEBUG

extension RecipeListViewModel {
    struct TestHooks {
        let target: RecipeListViewModel
        
        public var selectedNetworkOption: NetworkOption? {
            target.selectedNetworkOption
        }
        
        public var recipes: [Recipe] {
            target.recipes
        }
                
        public func getRecipes() async throws -> [Recipe] {
            try await target.getRecipes()
        }
    }
}

#endif
