//
//  ResponseHandler.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

final class ResponseHandler: ResponseHandlerInterface {
    func fetchModel<T>(data: Data) async throws -> T where T : Decodable {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
