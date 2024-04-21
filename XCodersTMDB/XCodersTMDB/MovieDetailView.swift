//
//  PopularMoviesDetailView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 9/8/23.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var vm: MovieDetailVM
    @State var showTrailer = false
    @State var showProviders = false
    
    var body: some View {
        ScrollView {
            VStack {
                MoviePosterView(movie: vm.selectedMovie, size: .cover)
                    .padding(.top, 70)
                    
                HStack {
                    Text(vm.selectedMovie.title)
                        .font(.title)
                    Spacer()
                    MovieRankView(movie: vm.selectedMovie, size: .large)
                }
                .padding(.horizontal, 20)
                
                Text("Original Title: \(vm.selectedMovie.originalTitle)")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Link(destination: .getMovieLink(id: vm.selectedMovie.id, movie: vm.selectedMovie.originalTitle)) {
                    HStack {
                        Image(systemName: "link")
                        Text("Go to movie")
                    }
                    .foregroundColor(.black)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.cyan.opacity(0.4))
                }
                .padding(.vertical, 15)
                
                Button {
                    showTrailer.toggle()
                } label: {
                    Image(systemName: "play")
                    Text("Show Trailer")
                }
                .foregroundColor(.black)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color("Turquesa"))
                
                DisclosureGroup {
                    if vm.streamProv.isEmpty, vm.buyProv.isEmpty, vm.rentProv.isEmpty {
                        Text("No available Providers")
                            .padding(.vertical)
                    }
                    
                    if !vm.streamProv.isEmpty {
                        Section("Stream") {
                            WatchProviderSection(providers: vm.streamProv)
                        }
                    }
                    
                    if !vm.rentProv.isEmpty {
                        Section("Rent") {
                            WatchProviderSection(providers: vm.rentProv)
                        }
                    }
                    
                    if !vm.buyProv.isEmpty {
                        Section("Buy") {
                            WatchProviderSection(providers: vm.buyProv)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "play")
                            .rotationEffect(.degrees(showProviders ? 90 : 0))
                            .animation(.default, value: showProviders)
                        Text("Watch Providers")
                    }
                }
                .tint(.blue)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(Color.cyan)
                    .opacity(0.1))
                                
                Text(vm.selectedMovie.overview)
                    .padding()
                
                Text("Crew:")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid (rows: [GridItem()]){
                        ForEach(vm.segmentedCast) { member in
                            CrewPosterView(crew: member)
                                .padding(.horizontal, 5)
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 70)
            }
        }
        .sheet(isPresented: $showTrailer, content: {
            VStack(alignment: .leading) {
                if let trailer = vm.movieTrailer,
                   let url = URL.movieTrailerURL(trailerKey: trailer.key) {
                    YoutubePlayer(url: url)
                        .ignoresSafeArea()
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    CustomAlertView(title: "No Available",
                                    message: "Sorry, this movie have not available trailer",
                                    buttonText: "Back") {
                        showTrailer = false
                    }
                }
                
                }
            .presentationDetents([.large])
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink("Share", item: .getMovieLink(id: vm.selectedMovie.id, movie: vm.selectedMovie.originalTitle))
            }
        }
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.thinMaterial)
                .frame(height: 95)
        }
        .ignoresSafeArea()
    }
}

struct PopularMoviesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MovieDetailView(vm: .detailPreview)
        }
    }
}


struct WatchProviderSection: View {
    let providers: [WatchProviderItem]
    
    var body: some View {
        HStack {
            ForEach(providers) { provider in
                AsyncImage(url: URL(string: "https://www.themoviedb.org/t/p/original/\(provider.logoPath)")) { img in
                    img
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                } placeholder: {
                    Image(systemName: "popcorn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
                .padding(.vertical)
            }
        }
    }
}
