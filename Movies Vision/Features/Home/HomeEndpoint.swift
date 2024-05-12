//
//  HomeEndpoint.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation

enum HomeEndpoint: Hashable, Comparable {
    case nowPlaying(page: Int)
    case upcoming(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
}

extension HomeEndpoint: APIEndpoint {

    var baseURL: URL {
        guard let url = URL(string: APIConstants.baseURL) else { fatalError("Base URL isn't valid.") }
        return url
    }

    var path: String {
        switch self {
        case .popular:
            "/movie/popular"
        case .topRated:
            "/movie/top_rated"
        case .upcoming:
            "/movie/upcoming"
        case .nowPlaying:
            "/movie/now_playing"
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
        case .popular( let page), .topRated(let page), .upcoming(let page), .nowPlaying(let page):
            parameters["offset"] = page
        }
        return parameters
    }
    
    var sectionName: String {
        switch self {
        case .popular:
            NSLocalizedString("popular", comment: "")
        case .topRated:
            NSLocalizedString("top-rated", comment: "")
        case .upcoming:
            NSLocalizedString("upcoming", comment: "")
        case .nowPlaying:
            NSLocalizedString("now-playing", comment: "")
        }
    }
}

