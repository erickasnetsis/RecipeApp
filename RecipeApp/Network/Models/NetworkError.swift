//
//  NetworkError.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    
    var userFriendlyDescription: String {
        switch self {
        case .invalidUrl:
            return "The provided url was invalid."
        case .invalidResponse:
            return "We're having trouble connecting with our servers right now. Please try again later."
        case .invalidData:
            return "The server returned bad data. Please try something else."
        }
    }
}

extension NetworkError: Identifiable {
    public typealias ID = Int
    var id: Int {
        self.hashValue
    }
}
