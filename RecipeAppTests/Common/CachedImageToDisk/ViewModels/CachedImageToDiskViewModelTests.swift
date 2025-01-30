//
//  CachedImageToDiskViewModelTests.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation
import Testing
@testable import RecipeApp

struct CachedImageToDiskViewModelTests {
    
    @Test func checkView() {
        let sut = CachedImageToDiskViewModel(imageURL: URL(string: "https://www.example.org")!)
        #expect(sut.image == nil)
    }
    
}
