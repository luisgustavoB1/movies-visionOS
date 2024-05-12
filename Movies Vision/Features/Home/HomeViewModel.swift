//
//  HomeViewModel.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation
import SwiftUI
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var homeService: HomeServiceProtocol { get }
    var sectionHome: [HomeEndpoint: ListMoviesResponse] { get set }
    var error: APIError? { get set }
    var showAlert: Bool { get set }
    var isLoading: Bool { get }

    func loadMoreContent(currentItem item: MovieModel)
    func fetchMovies()
    func resetError()
}

class HomeViewModel: HomeViewModelProtocol {

    @Published var sectionHome: [HomeEndpoint: ListMoviesResponse] = [:]
    @Published var error: APIError?
    @Published var showAlert: Bool = false
    @Published var isLoading = false

    private var page = 1
    private var totalPages = 1
    private var cancellables = Set<AnyCancellable>()
    private var listOffset = 10
    internal var homeService: HomeServiceProtocol

    init(homeService: HomeServiceProtocol = HomeService() ) {
        self.homeService = homeService
    }
    
    func fetchMovies() {
        isLoading = true
        let endpoints: [HomeEndpoint]  = [
            .popular(page: page),
            .topRated(page: page),
            .upcoming(page: page),
            .nowPlaying(page: page)
        ]
        
        let publishers = endpoints.map { endpoint in
            homeService.fetchMovies(endpointType: endpoint)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        Publishers.MergeMany(publishers)
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("All requests finished")
                case .failure(let error):
                    self.error = error as? APIError
                    self.showAlert = true
                }
            }, receiveValue: { values in
                for (data, endpoint) in values {
                    self.isLoading = false
                    self.sectionHome[endpoint] = data
                }
            })
            .store(in: &self.cancellables)
    }

    func loadMoreContent(currentItem item: MovieModel) {
//        let itemIndex = popularFilms.firstIndex(of: item) ?? 0
//        let shouldLoad = itemIndex == (popularFilms.count - listOffset)
//        if shouldLoad {
//            page += 1
////            fetchPopularMovies()
//        }
    }

    func resetError() {
        error = nil
        showAlert = false
    }
}
