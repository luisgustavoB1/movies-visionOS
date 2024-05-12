//
//  Util.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData

    var apiErrorDescription: String? {
        switch self {
        case .invalidData:
            return ""
        case .invalidResponse:
            return ""
        }
    }
}
