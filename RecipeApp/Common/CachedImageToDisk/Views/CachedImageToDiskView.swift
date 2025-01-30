//
//  CachedImageToDiskView.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import SwiftUI

struct CachedImageToDiskView: View {
    @StateObject var viewModel: CachedImageToDiskViewModel
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                LoadingView()
            }
        }.task {
            await viewModel.loadImage()
        }
    }
}

struct CachedImageToDiskView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageToDiskView(
            viewModel: CachedImageToDiskViewModel(
                imageURL: URL(string: "https://picsum.photos/200")
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
