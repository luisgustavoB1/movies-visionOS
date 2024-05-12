//
//  MoviesModel.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import Foundation

protocol ConvertParametres {
    var posterPath: String? { get }
    var posterURL: URL? { get }
    var backdropPath: String? { get }
    var backdropURL: URL? { get }
    var releaseDate: String { get }
    var releaseYear: String? { get }
}

extension ConvertParametres {
    var posterURL: URL? {
        guard let posterPath = self.posterPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) else { return nil }
        return URL(string: posterPath, relativeTo: URL(string: APIConstants.posterPathURL))
    }

    var backdropURL: URL? {
        guard let backdropPath = self.backdropPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) else { return nil }
        return URL(string: backdropPath, relativeTo: URL(string: APIConstants.backdropPathURL))
    }

    var releaseYear: String? {
        let components = releaseDate.components(separatedBy: "-")
        guard let year = components.first, !year.isEmpty else { return nil }
        return year
    }
}

struct ListMoviesResponse: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieModel: Codable, Hashable, Identifiable, ConvertParametres {
     let backdropPath, posterPath: String?
     let id: Int
     let originalLanguage, overview: String
     let releaseDate, title: String
     let voteAverage: Double

     enum CodingKeys: String, CodingKey {
         case backdropPath = "backdrop_path"
         case id
         case originalLanguage = "original_language"
         case overview
         case posterPath = "poster_path"
         case releaseDate = "release_date"
         case title
         case voteAverage = "vote_average"
     }
}
