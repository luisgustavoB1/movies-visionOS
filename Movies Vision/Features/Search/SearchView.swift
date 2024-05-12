//
//  SearchView.swift
//  Movies
//
//  Created by Luis Gustavo on 11/05/24.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {

    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    if viewModel.isLoading {
                        loader
                    } else {
                        VStack(alignment: .leading) {
                            gridLayout(geometry: geometry)
                        }
                    }
                }
                .navigationTitle("search-title")
                .font(.system(size: 70))
                .searchable(text: $viewModel.query)
                .onChange(of: viewModel.query) { _ in viewModel.fetchSearchMovies() }
                .alert(isPresented: $viewModel.showAlert) { alertError }
            }
        }
    }

    private func gridLayout(geometry: GeometryProxy) -> some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem(), GridItem()], spacing: 20) {
            ForEach(viewModel.results) { movie in
                MoviePosterView(movie: movie)
                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.22)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }

    private var loader: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .padding()
        }
    }

    private var alertError: Alert {
        Alert(
            title: Text("home-error-title"),
            message: Text(viewModel.error?.apiErrorDescription ?? ""),
            primaryButton: .default(
                Text("home-error-button-title"),
                action: {
                viewModel.resetError()
                viewModel.fetchSearchMovies()
                }
            ),secondaryButton: .cancel()
        )
    }
}

#Preview {
    SearchBuilder.build()
}
