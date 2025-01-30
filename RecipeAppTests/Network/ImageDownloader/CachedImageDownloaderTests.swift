//
//  CachedImageDownloaderTests.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation
import Testing
@testable import RecipeApp

struct CachedImageDownloaderTests {

    @Test("Check if can download image and can cache it")  func checkCachedImaged() async throws {
        let sut = ImageDownloader()
        let url = URL(string: "https://picsum.photos/200")!
        let data = try await sut.getImageData(url: url)
        #expect(data != nil)
        let cachedData = try await sut.getImageData(url: url)
        #expect(cachedData != nil)
    }
    
}
