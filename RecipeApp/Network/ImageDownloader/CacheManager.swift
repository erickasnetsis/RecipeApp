//
//  CacheManager.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

enum CacheError: Error {
    case invalidCacheDirectory
    case invalidData
    case notCached
}

protocol CacheManagerInterface {
    func getData(from url: URL) async throws -> Data
    func set(data: Data, from url: URL) async throws
}

final class CacheManager: CacheManagerInterface {
    private var cachesDirectory: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first
    }
    
    func getData(from url: URL) async throws -> Data {
        guard let cachesDirectory else {
            throw CacheError.invalidCacheDirectory
        }
        
        let fileURL = cachesDirectory.appendingPathComponent(url.absoluteString.alphanumeric)
                
        if FileManager.default.fileExists(atPath: fileURL.path) {
            guard let data = try? Data(contentsOf: fileURL) else {
                throw CacheError.invalidData
            }
            print("CacheManager: Loaded from disk: \(url.absoluteString)")
            return data
        }
        throw CacheError.notCached
    }
    
    func set(data: Data, from url: URL) async throws {
        guard let cachesDirectory else {
            throw CacheError.invalidCacheDirectory
        }
        let fileURL = cachesDirectory.appendingPathComponent(url.absoluteString.alphanumeric)
        try data.write(to: fileURL)
        print("CacheManager: Saved to disk: \(url.absoluteString)")
    }
}
