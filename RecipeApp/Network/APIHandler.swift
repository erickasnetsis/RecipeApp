//
//  APIHandler.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

final class APIHandler: APIHandlerInterface {
    func fetchData(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
