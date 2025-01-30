//
//  String+Filename.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import Foundation

extension String {
    var alphanumeric: String {
        components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
}
