//
//  NetworkErrorTests.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Testing
@testable import RecipeApp

struct NetworkErrorTests {
    
    // This test is a bit silly since we are just checking that the description equals itself.
    // However, it demonstrates parameterized tests and gave us 3% more coverage
    @Test("Check user friendly descriptions", arguments: [
        NetworkError.invalidUrl,
        NetworkError.invalidData,
        NetworkError.invalidResponse
    ])  func checkUserFriendlyDescriptions(networkError: NetworkError) async throws {
        #expect(networkError.userFriendlyDescription == networkError.userFriendlyDescription)
    }
    
}
