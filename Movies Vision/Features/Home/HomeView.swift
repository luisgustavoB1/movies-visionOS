//
//  HomeView.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation
import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {

    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if viewModel.isLoading {
                    loader
                } else {
                    VStack(alignment: .center) {
                        title
                        section(geometry: geometry)
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) { alertError }
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
    
    private var title: some View {
        Text("home.title")
            .font(.system(size: 70))
            .bold()
            .padding()
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
    
    private func section(geometry: GeometryProxy) -> some View {
        ForEach(viewModel.sectionHome.sorted(by: { $0.key < $1.key }), id: \.key) { section, movies in
            VStack(alignment: .leading) {
                Text(section.sectionName)
                    .font(.system(size: 50))
                    .bold()
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(movies.results) { movie in
                            switch section {
                            case .nowPlaying:
                                VStack {
                                    MovieCardView(movie: movie)
                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.25)
                                        .cornerRadius(10)
                                }
                            default:
                                VStack {
                                    MoviePosterView(movie: movie)
                                        .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.22)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
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
                viewModel.fetchMovies()
                }
            ),secondaryButton: .cancel()
        )
    }
}

#Preview {
    HomeBuilder.build()
}
