//
//  MovieDetailVM.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 10/8/23.
//

import Foundation

enum ProviderType {
    case rent
    case stream
    case buy
}

final class MovieDetailVM: ObservableObject {
    let repository: MovieRepositoryProtocol
    let selectedMovie: Movie

    @Published var castCrew: [CastCrew] = []
    @Published var movieVideos: [MovieVideos] = []
    @Published var movieProviders: WatchProvidersResponse?
    
    var rentProv: [WatchProviderItem] {
        getProviders(provType: .rent)
    }
    var streamProv: [WatchProviderItem] {
        getProviders(provType: .stream)
    }
    var buyProv: [WatchProviderItem] {
        getProviders(provType: .buy)
    }
    
    var providerType: ProviderType = .buy
    
    var movieTrailer: MovieVideos? {
        movieVideos.filter { $0.official == true && $0.type == .trailer }.first
    }
    
    var segmentedCast: ArraySlice<CastCrew> {
        castCrew.prefix(10)
    }
    
    init(repository: MovieRepositoryProtocol = MoviesRepository.shared, selectedMovie: Movie) {
        self.repository = repository
        self.selectedMovie = selectedMovie
        self.loadCrew(id: selectedMovie.id)
        self.loadMovieVideos(id: selectedMovie.id)
        self.loadProviders(id: selectedMovie.id)
    }

    func loadCrew(id: Int) {
        Task { @MainActor in
            do {
                castCrew = try await repository.getMoviesCast(id: id)
            } catch {
                castCrew = []
            }
        }
    }
    
    func loadMovieVideos(id: Int) {
        Task { @MainActor in
            do {
                movieVideos = try await repository.getMovieVideos(id: id)
            } catch {
                movieVideos = []
            }
        }
    }
    
    func loadProviders(id: Int) {
        Task { @MainActor in
            do {
                movieProviders = try await repository.getMovieWatchProviders(id: id)
            } catch {
                movieProviders = nil
            }
        }
    }
    
    private func getProviders(provType: ProviderType) -> [WatchProviderItem] {
        guard let providers = movieProviders,
              let results = providers.results["ES"] else { return [] }
        
        switch provType {
        case .rent:
            if let rent = results.rent {
                return rent
            }
        case .stream:
            if let stream = results.flatrate {
                return stream
            }
        case .buy:
            if let buy = results.buy {
                return buy
            }
        }
        return []
    }
}
