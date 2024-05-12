//
//  NetworkServiceProtocol.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation
import Combine

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

