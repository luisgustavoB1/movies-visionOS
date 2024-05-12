//
//  HomeService.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation
import Combine

protocol HomeServiceProtocol {
    func fetchMovies(endpointType: HomeEndpoint) -> AnyPublisher<(ListMoviesResponse, HomeEndpoint), Error>
}

class HomeService: HomeServiceProtocol {
    let apiClient = URLSessionAPIClient<HomeEndpoint>()

    func fetchMovies(endpointType: HomeEndpoint) -> AnyPublisher<(ListMoviesResponse, HomeEndpoint), Error> {
        return apiClient.request(endpointType)
            .map { response -> (ListMoviesResponse, HomeEndpoint) in
                return (response, endpointType)
            }
            .eraseToAnyPublisher()
    }
}
