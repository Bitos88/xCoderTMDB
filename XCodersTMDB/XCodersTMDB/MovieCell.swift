//
//  MovieCell.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 8/8/23.
//

import SwiftUI

enum CellType {
    case list
    case grid
}

struct MovieCell: View {
    let movie: Movie
    @State var listType: CellType

    var body: some View {
        switch listType {
        case .list:
            HStack {
                MoviePosterView(movie: movie)
                    .overlay(alignment: .bottomTrailing) {
                        MovieRankView(movie: movie)
                    }
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .font(.title2)
                    Text("Year: \(movie.releaseYear)")
                }
            }
        
        case .grid:
            MoviePosterView(movie: movie, size: .grid)
                .overlay(alignment: .topLeading) {
                    MovieRankView(movie: movie)
                }
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MovieCell(movie: .testMovie, listType: .list)
                .padding(.bottom, 40)
            MovieCell(movie: .testMovie, listType: .grid)
        }
    }
}

struct RMModelResult: Codable {
    let results: [RMModel]
}

struct RMModel: Codable {
    let id: Int
    let name: String
}
