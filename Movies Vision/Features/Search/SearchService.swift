//
//  SearchService.swift
//  Movies
//
//  Created by Luis Gustavo on 11/05/24.
//

import Foundation
import Combine

protocol SearchServiceProtocol {
    func fetchSearch(endpointType: SearchEndpoint) -> AnyPublisher<ListMoviesResponse, Error>
}

class SearchService: SearchServiceProtocol {
    let apiClient = URLSessionAPIClient<SearchEndpoint>()

    func fetchSearch(endpointType: SearchEndpoint) -> AnyPublisher<ListMoviesResponse, Error> {
        apiClient.request(endpointType)
    }
}
