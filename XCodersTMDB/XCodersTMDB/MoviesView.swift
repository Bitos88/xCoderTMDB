//
//  ContentView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var vm: MoviesVM
    
    var body: some View {
        NavigationStack() {
            switch vm.moviesListState {
            case .loaded:
                switch vm.viewType {
                case .list:
                    MoviesListView(vm: vm)
                case .grid:
                    MoviesGridView(vm: vm)
                }
            case .error:
                CustomAlertView(title: "Something went wrong",
                                message: "Service temporarily unavailable, please try again later...",
                                buttonText: "Try again") {
                    Task {
                        await vm.loadMovies()
                    }
                }
            }
        }
        .overlay {
            if vm.isLoading {
                ZStack {
                    Color.gray
                    ProgressView()
                        .controlSize(.large)
                }
                .ignoresSafeArea()
            }
        }
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(vm: .preview)
    }
}
