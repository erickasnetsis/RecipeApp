//
//  APIHandlerInvalidResponse.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation
@testable import RecipeApp

final class APIHandlerInvalidResponse: APIHandlerInterface {
    func fetchData(url: URL) async throws -> Data {
        throw NetworkError.invalidResponse
    }
}

