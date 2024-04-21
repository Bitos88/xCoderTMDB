//
//  MoviesTestData.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 4/8/23.
//

import Foundation

final class MovieRepositoryTest: MovieRepositoryProtocol {
    let url = Bundle.main.url(forResource: "TestData", withExtension: "json")!
    let crewURL = Bundle.main.url(forResource: "CastCrewTest", withExtension: "json")!
    
    func getPopularMovies(page: Int = 1) async throws -> [Movie] {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat)
        
        let data = try Data(contentsOf: url)
        
        return try decoder.decode(MoviesResult.self, from: data).results.map { $0.mapToModel() }
    }
    
    func getMoviesCast(id: Int) async throws -> [CastCrew] {
        let decoder = JSONDecoder()
        
        let data = try Data(contentsOf: crewURL)

        let caja = try decoder.decode(CreditsResult.self, from: data).cast.map { $0.mapToModel() }
                
        return caja
    }
    
    func getNowPlayingMovies(page: Int) async throws -> [Movie] {
        []
    }
    
    func getTopRatedMovies(page: Int) async throws -> [Movie] {
        []
    }
    
    func getUpcomingMovies(page: Int) async throws -> [Movie] {
        []
    }
    
    func getMovieVideos(id: Int) async throws -> [MovieVideos] {
        [MovieVideos(key: "", type: .trailer, official: true)]
    }
    
    func getMovieWatchProviders(id: Int) async throws -> WatchProvidersResponse {
        WatchProvidersResponse(id: 0, results: ["Stream": .previewProvider])
    }
}

extension WatchProvider {
    static let previewProvider = WatchProvider(link: "", flatrate: [.previewProviderItemDisney], rent: [.previewProviderItemNetflix], buy: [.previewProviderItemRakuten])
}

extension WatchProviderItem {
    static let previewProviderItemNetflix = WatchProviderItem(logoPath: "", id: 0, providerName: "Netflix")
    static let previewProviderItemPrimeVideo = WatchProviderItem(logoPath: "", id: 1, providerName: "Prime Video")
    static let previewProviderItemDisney = WatchProviderItem(logoPath: "", id: 2, providerName: "Disney")
    static let previewProviderItemRakuten = WatchProviderItem(logoPath: "", id: 3, providerName: "Rakuten")

    
}

extension MoviesVM {
    static let preview = MoviesVM(repository: MovieRepositoryTest())
}

extension MovieDetailVM {
    static let detailPreview = MovieDetailVM(repository: MovieRepositoryTest(), selectedMovie: .testMovie)
}

extension Movie {
    static let testMovie = Movie(id: 29292,
                                 originalTitle: "Transformers: Rise of the Beasts FAKE",
                                 title: "Transformers: Rise of the Beasts FAKE",
                                 overview: "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.",
                                 releaseDate: DateFormatter.dateFormat.date(from: "2014-11-05")!,
                                 voteAverage: 3,
                                 posterPath: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg")
}

extension CastCrew {
    static let testCrew = CastCrew(id: 287,
                                   name: "Jared Leto",
                                   profilePath: "/ca3x0OfIKbJppZh8S1Alx3GfUZO.jpg",
                                   character: "Tyler Durden")
}

extension Page {
    static let samplePage = Page(name: "Explora un Mundo de Películas", description: "This is an example", image: "Marvel", tag: 0)
    
    static let samplePages: [Page] = [
        Page(name: "Welcom to TMDB", description: "This is an example", image: "MovieCartoon", tag: 0),
        Page(name: "Welcom to TMDB", description: "This is an example", image: "MovieCartoon", tag: 1),
        Page(name: "Welcom to TMDB", description: "This is an example", image: "MovieCartoon", tag: 2)
    ]
}

extension CustomAlertView {
    static let testAlert = CustomAlertView(title: "Something Went Wrong", message: "Cannot Load Data", buttonText: "Try again", action: {})
}
