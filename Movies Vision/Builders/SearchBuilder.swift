//
//  SearchBuilder.swift
//  Movies Vision
//
//  Created by Luis Gustavo on 11/05/24.
//

import SwiftUI

struct SearchBuilder {
    static func build() -> some View {
        SearchView(viewModel: SearchViewModel())
    }
}
