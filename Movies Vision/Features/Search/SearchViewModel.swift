//
//  SearchViewModel.swift
//  Movies
//
//  Created by Luis Gustavo on 11/05/24.
//

import Foundation
import Combine

protocol SearchViewModelProtocol: ObservableObject {
    var searchService: SearchServiceProtocol { get }
    var query: String { get set }
    var results: [MovieModel] { get }
    var error: APIError? { get set }
    var showAlert: Bool { get set }
    var isLoading: Bool { get }

    func fetchSearchMovies()
    func resetError()
}

class SearchViewModel: SearchViewModelProtocol {
    @Published var query: String = ""
    @Published var results: [MovieModel] = []
    @Published var error: APIError?
    @Published var showAlert: Bool = false
    @Published var isLoading = false

    private var page = 1
    private var totalPages = 1
    private var cancellables = Set<AnyCancellable>()
    private var listOffset = 10
    internal var searchService: SearchServiceProtocol

    init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
    }

    func fetchSearchMovies() {
        self.results.removeAll()
        searchService.fetchSearch(endpointType: .searchMovies(query: query, page: page))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] data in
                if case .failure(let failure) = data {
                    self?.error = failure as? APIError
                    self?.showAlert = true
                }
            }, receiveValue: { [weak self] data in
                self?.results.append(contentsOf: data.results)
                self?.totalPages = data.totalPages
            }).store(in: &cancellables)
    }

    func resetError() {
        error = nil
        showAlert = false
    }
}
