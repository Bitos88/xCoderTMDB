//
//  MoviesRepository.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getPopularMovies(page: Int) async throws -> [Movie]
    func getMoviesCast(id: Int) async throws -> [CastCrew]
    func getNowPlayingMovies(page: Int) async throws -> [Movie]
    func getTopRatedMovies(page: Int) async throws -> [Movie]
    func getUpcomingMovies(page: Int) async throws -> [Movie]
    func getMovieVideos(id: Int) async throws -> [MovieVideos]
    func getMovieWatchProviders(id: Int) async throws -> WatchProvidersResponse
}

final class MoviesRepository: MovieRepositoryProtocol {
    static let shared = MoviesRepository()
    
    private init() {}
    
    func getPopularMovies(page: Int) async throws -> [Movie] {
        print("GetPopularAPI")
        return try await getJSON(url: .getMovies(url: .getPopularMovies, page: page), type: MoviesResult.self).results.map { $0.mapToModel() }
    }
    
    func getMoviesCast(id: Int) async throws -> [CastCrew] {
        print("CAST MEMBER API")
        return try await getJSON(url: .getMovieCast(url: .getMovieCast(id: id)), type: CreditsResult.self).cast.map { $0.mapToModel() }
    }
    
    func getNowPlayingMovies(page: Int) async throws -> [Movie] {
        print("GET NOWPLAY API")
        return try await getJSON(url: .getMovies(url: .getNowPlayingMovies, page: page), type: MoviesResult.self).results.map { $0.mapToModel() }
    }
    
    func getTopRatedMovies(page: Int) async throws -> [Movie] {
        print("GET TOPRATED API")
        return try await getJSON(url: .getMovies(url: .getTopRatedMovies, page: page), type: MoviesResult.self).results.map { $0.mapToModel() }
    }
    
    func getUpcomingMovies(page: Int) async throws -> [Movie] {
        print("GET UPCOMING API")
        return try await getJSON(url: .getMovies(url: .getUpcomingMovies, page: page), type: MoviesResult.self).results.map { $0.mapToModel() }
    }
    
    func getMovieVideos(id: Int) async throws -> [MovieVideos] {
        print("MOVIES VIDEOS API")
        return try await getJSON(url: .getMovieTrailer(url: .getMovieTrailer(id: id)), type: MovieVideosResultsDTO.self).results.map { $0.mapToModel() }
    }
    
    func getMovieWatchProviders(id: Int) async throws -> WatchProvidersResponse {
        print("PROVIDERS API API")
        return try await getJSON(url: .getMovieWatchProviders(url: .movieWatchProviders(id: id)), type: WatchProvidersResponseDTO.self).mapToModel()
    }
}
