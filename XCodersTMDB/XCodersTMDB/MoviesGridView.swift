//
//  PopularMoviesGridView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 11/8/23.
//

import SwiftUI

struct MoviesGridView: View {
    @ObservedObject var vm: MoviesVM
        
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(vm.movies) { movie in
                    NavigationLink(value: movie) {
                        MovieCell(movie: movie, listType: .grid)
                            .onAppear {
                                vm.loadNextPage(movie: movie)
                            }
                    }
                }
            }
            .padding()
        }
        .background(LinearGradient(colors: [.mint.opacity(0.5), .mint.opacity(0.7), .cyan.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.viewType = .list
                } label: {
                    Image(systemName: "list.bullet")
                }
                
            }
        }
        .navigationDestination(for: Movie.self, destination: { movie in
            MovieDetailView(vm: MovieDetailVM(selectedMovie: movie))
        })
        .navigationTitle("Movies")
    }
}

struct PopularMoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MoviesGridView(vm: .preview)
        }
    }
}
