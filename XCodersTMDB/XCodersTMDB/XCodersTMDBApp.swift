//
//  XCodersTMDBApp.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import SwiftUI

@main
struct XCodersTMDBApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                PagerView(isFirstLaunch: $isFirstLaunch)
            } else {
                MoviesHomeView()
            }
        }
    }
}
