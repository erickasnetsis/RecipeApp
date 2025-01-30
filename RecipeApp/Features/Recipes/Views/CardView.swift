//
//  CardView.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/28/25.
//

import SwiftUI

struct CardView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            CachedImageToDiskView(
                viewModel: CachedImageToDiskViewModel(imageURL: recipe.photoUrlSmall)
            )
            .frame(width: 100, height: 100)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .bold()
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(recipe.cuisine)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
        .background(Color(.tertiarySystemFill))
        .frame(height: 100)
        .cornerRadius(12)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(recipe: recipe1)
            .previewLayout(.sizeThatFits)
    }
}
