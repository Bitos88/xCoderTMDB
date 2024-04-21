//
//  MoviesDTO.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import Foundation

struct MoviesResult: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [MovieDTO]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieDTO: Codable {
    let id: Int
    let originalTitle: String
    let title: String
    let overview: String
    let releaseDate: Date
    let voteAverage: Double
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

struct MovieVideosResultsDTO: Codable {
    let results: [MovieVideosDTO]
}

struct MovieVideosDTO: Codable {
    let key: String
    let type: VideoType
    let official: Bool
}

enum VideoType: String, Codable {
    case trailer = "Trailer"
    case teaser = "Teaser"
    case behindTheScenes = "Behind the Scenes"
    case featurette = "Featurette"
    case clip = "Clip"
}

extension MovieVideosDTO {
    func mapToModel() -> MovieVideos {
        MovieVideos(key: key,
                    type: type,
                    official: official)
    }
}

extension MovieDTO {
    func mapToModel() -> Movie {
        Movie(id: id,
              originalTitle: originalTitle,
              title: title,
              overview: overview,
              releaseDate: releaseDate,
              voteAverage: voteAverage,
              posterPath: posterPath)
    }
}
