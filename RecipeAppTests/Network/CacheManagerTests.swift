//
//  CacheManagerTests.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation
import Testing
@testable import RecipeApp

struct CachManagerTests {

    @Test("Check Data not cached")  func checkNotCached() async throws {
        let sut = CacheManager()
        let url = URL(string: "http://www.example.org/notCached")!
        await #expect(throws: CacheError.notCached) {
            _ = try await sut.getData(from: url)
        }
    }
    
    @Test("Check data cached successfully")  func checkCachedSuccessfully() async throws {
        let sut = CacheManager()
        let url = URL(string: "http://www.example.org/cached")!
        let expectedResult = "test data"
        let data = expectedResult.data(using: .utf8)!
        try await sut.set(data: data, from: url)
        let cachedData = try await sut.getData(from: url)
        #expect(String(data: cachedData, encoding: .utf8) == expectedResult)
    }

}
