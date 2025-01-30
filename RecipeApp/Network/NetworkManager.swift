//
//  NetworkManager.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

protocol NetworkManagerInterface {
    func fetchRequest<T: Decodable>(url: URL) async throws -> T
}

protocol ResponseHandlerInterface {
    func fetchModel<T: Decodable>(data: Data) async throws -> T
}

protocol APIHandlerInterface {
    func fetchData(url: URL) async throws -> Data
}

final class NetworkManager: NetworkManagerInterface {
    private let apiHandler: APIHandlerInterface
    private let responseHandler: ResponseHandlerInterface
    
    init(
        apiHandler: APIHandlerInterface = APIHandler(),
        responseHandler: ResponseHandlerInterface = ResponseHandler()
    ) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T>(url: URL) async throws -> T where T : Decodable {
        let data = try await apiHandler.fetchData(url: url)
        return try await responseHandler.fetchModel(data: data)
    }
}
