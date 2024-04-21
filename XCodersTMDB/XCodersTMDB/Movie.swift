//
//  Movie.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import Foundation

struct Movie: Identifiable, Hashable {
    let id: Int
    let originalTitle: String
    let title: String
    let overview: String
    let releaseDate: Date
    let voteAverage: Double
    let posterPath: String
    
    var rank: String {
        voteAverage.formatted(.number.precision(.integerAndFractionLength(integer: 1, fraction: 1)))
    }
    
    var releaseYear: String {
        releaseDate.formatted(.dateTime.year(.defaultDigits))
    }
}

struct MovieVideos {
    let key: String
    let type: VideoType
    let official: Bool
}
