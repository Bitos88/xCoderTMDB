//
//  MoviePosterView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 8/8/23.
//

import SwiftUI

enum PosterSize: CGFloat {
    case poster = 120
    case cover = 400
    case grid = 160
}

struct MoviePosterView: View {
    let movie: Movie
    var size: PosterSize = .poster
    
    var body: some View {
        AsyncImage(url: .getPosterPath(poster: movie.posterPath)) { img in
            img
                .resizable()
                .scaledToFit()
                .frame(width: size.rawValue)
                .cornerRadius(10)
        } placeholder: {
            Image(systemName: "popcorn")
                .resizable()
                .scaledToFit()
                .frame(width: size.rawValue)
                .cornerRadius(10)
        }
        .ignoresSafeArea()
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(movie: .testMovie)
    }
}
