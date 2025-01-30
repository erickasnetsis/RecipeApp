//
//  APIHandlerMalformedResponse.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation
@testable import RecipeApp

final class APIHandlerMalformedResponse: APIHandlerInterface {
    func fetchData(url: URL) async throws -> Data {
        return """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
            ]
        }
        """.data(using: .utf8)!
    }
}
