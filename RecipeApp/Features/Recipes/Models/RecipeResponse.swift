//
//  RecipeResponse.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/28/25.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let uuid: String
    let sourceUrl: URL?
    let youtubeUrl: URL?
}

extension Recipe: Identifiable {
    var id: String {
        uuid
    }
}
