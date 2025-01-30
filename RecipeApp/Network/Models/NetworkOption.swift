//
//  NetworkOption.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

enum NetworkOption: String, CaseIterable {
    case valid
    case malformed
    case empty
        
    init(int: Int) {
        self = NetworkOption.allCases[int]
    }
}

extension NetworkOption {
    var description: String {
        rawValue.capitalized
    }
    
    var endpointURL: URL? {
        switch self {
        case .valid:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        case .malformed:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        case .empty:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        }
    }
}
