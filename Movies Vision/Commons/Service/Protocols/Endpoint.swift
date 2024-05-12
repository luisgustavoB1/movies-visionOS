//
//  Endpoint.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var queryParametersList: [URLQueryItem]? { get }
}

extension APIEndpoint {
    var  queryParametersList: [URLQueryItem]? {
        var queryList: [URLQueryItem] = []
        if let parameters = parameters {
            for (key, value) in parameters {
                queryList.append(URLQueryItem(name: key, value: String(describing: value)))
            }
        }
        return queryList
    }
}
