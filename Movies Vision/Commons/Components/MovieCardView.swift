//
//  MovieCardView.swift
//  Movies Vision
//
//  Created by Luis Gustavo on 11/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {

    var movie: MovieModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            WebImage(url: movie.backdropURL) { image in
                image.resizable()
            } placeholder: {
                Image("default-image")
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.system(size: 50))
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(
                Color.black.opacity(0.3)
            )
        }
        .cornerRadius(10)
        .padding()
        .shadow(radius: 5)
    }
}
