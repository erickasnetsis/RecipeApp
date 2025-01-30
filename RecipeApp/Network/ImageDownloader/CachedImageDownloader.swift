//
//  CachedImageDownloader.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

final class CachedImageDownloader: ImageDownloadInterface {
    private let imageDownloader: ImageDownloadInterface
    private let cacheManager: CacheManagerInterface
    
    init(
        imageDownloader: ImageDownloadInterface = ImageDownloader(),
        cacheManager: CacheManagerInterface = CacheManager()
    ) {
        self.imageDownloader = imageDownloader
        self.cacheManager = cacheManager
    }
    
    func getImageData(url: URL) async throws -> Data {
        do {
            return try await cacheManager.getData(from: url)
        } catch {
            let data = try await imageDownloader.getImageData(url: url)
            try await cacheManager.set(data: data, from: url)
            return data
        }
    }
}
