//
//  MoviesHomeView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 13/8/23.
//

import SwiftUI

struct MoviesHomeView: View {
    @ObservedObject var popularVM = MoviesVM(movieType: .popular)
    @ObservedObject var nowPlayingVM = MoviesVM(movieType: .nowPlay)
    @ObservedObject var topRatedVM = MoviesVM(movieType: .topRated)
    @ObservedObject var upcomingVM = MoviesVM(movieType: .upcoming)
    
    var body: some View {
        TabView() {
            MoviesView(vm: popularVM)
                .tabItem {
                    Label("Popular", systemImage: "heart.fill")
                }
            MoviesView(vm: nowPlayingVM)
                .tabItem {
                    Label("Now Playing", systemImage: "play")
                }
            MoviesView(vm: topRatedVM)
                .tabItem {
                    Label("Top Rated", systemImage: "star.fill")
                }
            MoviesView(vm: upcomingVM)
                .tabItem {
                    Label("Upcoming", systemImage: "calendar")
                }
        }
        .tint(.cyan)
    }
}

struct MoviesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomeView(popularVM: .preview, nowPlayingVM: .preview, topRatedVM: .preview, upcomingVM: .preview)
    }
}
