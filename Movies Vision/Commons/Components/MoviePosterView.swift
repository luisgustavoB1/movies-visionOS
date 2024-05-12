//
//  MoviePosterView.swift
//  Movies
//
//  Created by Luis Gustavo on 10/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviePosterView: View {
    let movie: MovieModel
    
    var body: some View {
        WebImage(url: movie.posterURL) { image in
            image.resizable()
            } placeholder: {
                Image("default-image")
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
}
