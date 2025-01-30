//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/27/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel = RecipeListViewModel()
        
    var body: some View {
        NavigationStack {
            VStack {
                SelectorView(
                    label: "Network options",
                    options: NetworkOption.allCases.map { $0.description }
                ) { selectedOption in
                    viewModel.set(networkOption: .init(int: selectedOption))
                }
                if viewModel.state == .loading {
                    LoadingView()
                } else if viewModel.recipes.isEmpty {
                    NoResultsView(label: "No recipes are available")
                } else {
                    List(viewModel.recipes, id: \.id) { recipe in
                        CardView(recipe: recipe)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.networkError) { error in
                Alert(
                    title: Text("Network Error"),
                    message: Text(error.userFriendlyDescription),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
