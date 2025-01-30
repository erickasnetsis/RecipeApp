//
//  ImageDownloader.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

protocol ImageDownloadInterface {
    func getImageData(url: URL) async throws -> Data
}

final class ImageDownloader: ImageDownloadInterface {
    func getImageData(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        print("ImageDownloader: Downloaded from url: \(url.absoluteString)")
        return data
    }
}
