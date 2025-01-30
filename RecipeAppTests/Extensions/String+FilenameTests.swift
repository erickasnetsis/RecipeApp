//
//  String+FilenameTests.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Testing
@testable import RecipeApp

struct StringFilenameTests {
    
    @Test func checkSafeString() {
        #expect("" == "")
        #expect("https://www.example.org".alphanumeric == "httpswwwexampleorg")
        #expect("filename!@#$%^&".alphanumeric == "filename")
        #expect("6trtfi6r09<>?:|{}".alphanumeric == "6trtfi6r09")
    }
    
}
