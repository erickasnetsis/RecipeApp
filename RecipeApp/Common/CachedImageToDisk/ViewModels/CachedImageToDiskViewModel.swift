//
//  CachedImageViewModel.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import SwiftUI

class CachedImageToDiskViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published private(set) var image: UIImage?

    // MARK: - Private Properties

    private let imageURL: URL?
    private let imageDownloader = CachedImageDownloader()
    private var cachesDirectory: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first
    }
    
    // MARK: - Life Cycle

    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    // MARK: - Internal Methods
    
    func loadImage() async {
        guard let url = imageURL else {
            return
        }
        
        do {
            let data = try await imageDownloader.getImageData(url: url)
            let loadedImage = UIImage(data: data)
            await MainActor.run {
                image = loadedImage
            }
        } catch {
            print("Unable to load image")
        }
    }
}
