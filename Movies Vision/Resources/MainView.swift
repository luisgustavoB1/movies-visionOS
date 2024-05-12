//
//  TabBar.swift
//  Movies
//
//  Created by Luis Gustavo on 11/05/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeBuilder.build()
                .tabItem {
                    Label("tab-home", systemImage: "film")
                }

            SearchBuilder.build()
                .tabItem {
                    Label("tab-search", systemImage: "magnifyingglass")
                }
        }
    }
}
