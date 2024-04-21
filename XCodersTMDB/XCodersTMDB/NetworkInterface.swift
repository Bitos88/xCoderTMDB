//
//  NetworkInterface.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import Foundation

let mainURL = URL(string: "https://api.themoviedb.org/3")!
let imageURLBase = URL(string: "https://image.tmdb.org/t/p/w500")!
let movieLink = URL(string: "https://www.themoviedb.org/movie/")!
let castCrewImageBaseURL = URL(string: "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/")!

let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MzFlNWZiNmYyZmI4OWIwN2ZjNTdkMGQ3MTIwYWJhOCIsInN1YiI6IjYyNjk3MDJiZjkyNTMyMTYyMzM3NDYxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IEOKxtUqgYzqhsOL8ZW2Hf_Cw_pQN_aIto8bn4l8Trs"

extension URL {
    static let getPopularMovies = mainURL.appending(path: "movie/popular")
    static let getNowPlayingMovies = mainURL.appending(path: "movie/now_playing")
    static let getTopRatedMovies = mainURL.appending(path: "movie/top_rated")
    static let getUpcomingMovies = mainURL.appending(path: "movie/upcoming")
    
    static func getMovieLink(id: Int, movie: String) -> URL {
        movieLink.appending(path: "\(id)-\(movie)")
    }
    
    static func getPosterPath(poster: String) -> URL {
        imageURLBase.appending(path: poster)
    }
    
    static func getMovieCast(id: Int) -> URL {
        mainURL.appending(path: "movie/\(id)/credits")
    }
        
    static func getMovieTrailer(id: Int) -> URL {
        mainURL.appending(path: "movie/\(id)/videos")
    }
    
    static func getCastCrewImage(actor: CastCrew) -> URL? {
        guard let actor = actor.profilePath else { return nil }
        return castCrewImageBaseURL.appending(path: actor)
    }
    
    static func getWikiLink(actor: CastCrew) -> URL? {
        guard let url = URL(string: "https://en.wikipedia.org/wiki") else { return nil }
        
        return url.appending(path: actor.name)
    }
    
    static func movieTrailerURL(trailerKey: String) -> URL? {
        guard let movieTrailerURL = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)") else { return nil }
        
        return movieTrailerURL
    }
    
    static func movieWatchProviders(id: Int) -> URL {
        mainURL.appending(path: "movie/\(id)/watch/providers")
    }
}

extension URLRequest {
    static func getMovies(url: URL, page: Int = 1) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.url?.append(queryItems: [URLQueryItem(name: "page", value: String(page))])
        
        request.httpMethod = HTTPMethods.get.rawValue
        request.addValue(token, forHTTPHeaderField: "Authorization")
                
        return request
    }
    
    //TODO: REFACTOR
    static func getMovieCast(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func getMovieTrailer(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func getMovieWatchProviders(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}
