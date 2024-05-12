//
//  SearchEndpoint.swift
//  Movies
//
//  Created by Luis Gustavo on 11/05/24.
//

import Foundation

enum SearchEndpoint: Hashable, Comparable {
    case searchMovies(query: String, page: Int)
}

extension SearchEndpoint: APIEndpoint {

    var baseURL: URL {
        guard let url = URL(string: APIConstants.baseURL) else { fatalError("Base URL isn't valid.") }
        return url
    }

    var path: String {
        switch self {
        case .searchMovies:
            "/search/movie"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String]? {
        return ["Authorization": AppConstants.Authorization]
    }

    var parameters: [String: Any]? {
        var parameters: [String: Any] =  ["limit": "20"]

        if let languageCode = Locale.current.language.languageCode?.identifier {
            parameters["language"] = AppLanguage(rawValue: languageCode)?.getTMDBLanguage ?? AppLanguage.en.getTMDBLanguage
        }

        switch self {
        case .searchMovies(let query, let page):
            parameters["offset"] = page
            parameters["query"] = query
        }
        return parameters
    }
}
