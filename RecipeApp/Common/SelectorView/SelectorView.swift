//
//  SelectorView.swift
//  RecipeApp
//
//  Created by Eric Kasnetsis on 1/29/25.
//

import SwiftUI
import Combine

struct SelectorView: View {
    @State private var selectedOption = 0

    let label: String
    let options: [String]
    var didSelectOption: (Int) -> Void = { _ in }

    var body: some View {
        VStack {
            Picker(label, selection: $selectedOption) {
                ForEach(Array(options.enumerated()), id: \.element) { index, element in
                    Text(element).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .onReceive(Just(selectedOption)) { value in
                didSelectOption(selectedOption)
            }
        }
    }
}

struct SelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(
            label: "Choose option",
            options: ["Red", "Green", "Blue"]
        )
        .previewLayout(.sizeThatFits)
    }
}
