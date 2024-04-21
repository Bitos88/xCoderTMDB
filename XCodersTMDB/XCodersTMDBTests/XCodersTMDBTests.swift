//
//  XCodersTMDBTests.swift
//  XCodersTMDBTests
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import XCTest
@testable import XCodersTMDB

final class XCodersTMDBTests: XCTestCase {
    var vm: MoviesVM!
    var repository: MovieRepositoryProtocol!
    
    override func setUp() async throws {
        repository = MovieRepositoryTest()
        vm = MoviesVM(repository: repository)
    }

    func test_given_getPopularMovies_then_first_page_loaded() async throws {
        let movies = try await repository.getPopularMovies(page: 1)
        XCTAssertGreaterThan(movies.count, 0)
    }
    
    func test_given_movieType_then_set_movieTitle() {
        XCTAssertEqual(vm.navigationTitle, "Popular Movies")
        
        vm.moviesType = .nowPlay
        
        XCTAssertEqual(vm.navigationTitle, "Now Playing")
        
        vm.moviesType = .upcoming
        
        XCTAssertEqual(vm.navigationTitle, "Upcoming")

    }
    
    func test_given_next_page_Then_load_more_movies() async throws {
        var movies = try await repository.getPopularMovies(page: 1)
        
        XCTAssertEqual(movies.count, 15)
        
        movies.append(contentsOf: try await repository.getPopularMovies(page: 2))

        XCTAssertEqual(movies.count, 30)
    }
    
    func test_given_lastMovie_then_isLastMovie() async {
        await vm.loadMovies()
        
        XCTAssertGreaterThan(vm.movies.count, 0)
        
        let lastMovie = vm.movies.last!
        
        vm.loadNextPage(movie: lastMovie)
        
        XCTAssertEqual(vm.movies.count, 30)
    }
    
//    func testDecoder() async throws {
//        let testDataURL = try XCTUnwrap(Bundle.main.url(forResource: "TestData", withExtension: "json"))
//
//        let data = try Data(contentsOf: testDataURL)
//
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .formatted(.dateFormat)
//        XCTAssertNoThrow(try decoder.decode(MoviesResult.self, from: data).results)
//    }
}
