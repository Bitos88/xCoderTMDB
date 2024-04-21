//
//  PopularMoviesListView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 11/8/23.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var vm: MoviesVM
        
    var body: some View {
        List(vm.movies) { movie in
            NavigationLink(value: movie) {
                MovieCell(movie: movie, listType: .list)
                    .onAppear {
                        vm.loadNextPage(movie: movie)
                    }
            }
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(LinearGradient(colors: [.white, .white.opacity(0.5), .clear], startPoint: .leading, endPoint: .trailing))
                    .shadow(radius: 6, x: 2, y: 4)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .background(LinearGradient(colors: [.mint.opacity(0.5), .mint.opacity(0.7), .cyan.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.viewType = .grid
                } label: {
                    Image(systemName: "square.grid.2x2")
                }
            }
        }
        .navigationDestination(for: Movie.self, destination: { movie in
            MovieDetailView(vm: MovieDetailVM(repository: vm.repository, selectedMovie: movie))
        })
        .navigationTitle(vm.navigationTitle)
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MoviesListView(vm: .preview)
        }
    }
}
