//
//  MoviesVM.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 4/8/23.
//

import Foundation

enum MoviesListState {
    case loaded
    case error
}

enum MoviesViewType {
    case list
    case grid
}

enum GetMoviesType {
    case popular
    case nowPlay
    case topRated
    case upcoming
}

final class MoviesVM: ObservableObject {
    let repository: MovieRepositoryProtocol
    
    var page = 1
    
    @Published var movies: [Movie] = []

    @Published var errorMessage = ""
    @Published var isLoading = true
    
    @Published var moviesListState: MoviesListState = .loaded
    @Published var viewType: MoviesViewType = .list
    @Published var moviesType: GetMoviesType = .popular
    
    var navigationTitle: String {
        switch moviesType {
        case .popular:
            return "Popular Movies"
        case .nowPlay:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    init(movieType: GetMoviesType = .popular, repository: MovieRepositoryProtocol = MoviesRepository.shared) {
        self.repository = repository
        self.moviesType = movieType
        Task {
            await loadMovies()
        }
    }

    @MainActor func loadMovies() async {
            do {
                switch moviesType {
                case .popular:
                    movies += try await repository.getPopularMovies(page: page)
                    isLoading = false
                case .nowPlay:
                    movies += try await repository.getNowPlayingMovies(page: page)
                    isLoading = false
                case .topRated:
                    movies += try await repository.getTopRatedMovies(page: page)
                    isLoading = false
                case .upcoming:
                    movies += try await repository.getUpcomingMovies(page: page)
                    isLoading = false
                }
            } catch let error as NetworkError {
                print(error)
                moviesListState = .error
                isLoading = false
                errorMessage = error.description
                movies = []
            } catch {
                print(error)
                isLoading = false
                moviesListState = .error
                movies = []
            }
    }
    
    func loadNextPage(movie: Movie) {
        if isLastItem(movie: movie) {
            page += 1
            Task {
                await loadMovies()
            }
        }
    }
    
    func isLastItem(movie: Movie) -> Bool {
        movies.last?.id == movie.id
    }
}

