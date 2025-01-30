//
//  NoResultsView.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import SwiftUI

struct NoResultsView: View {
    let label: String

    var body: some View {
        VStack {
            Spacer()
            Text(label)
            Spacer()
        }
    }
}

struct NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView(label: "No results found")
            .previewLayout(.sizeThatFits)
    }
}
