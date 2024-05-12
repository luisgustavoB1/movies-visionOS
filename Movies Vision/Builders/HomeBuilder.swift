//
//  HomeBuilder.swift
//  Movies Vision
//
//  Created by Luis Gustavo on 11/05/24.
//

import SwiftUI

struct HomeBuilder {
    static func build() -> some View {
        HomeView(viewModel: HomeViewModel())
    }
}
