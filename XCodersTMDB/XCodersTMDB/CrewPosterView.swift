//
//  CrewPosterView.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 11/8/23.
//

import SwiftUI

struct CrewPosterView: View {
    let crew: CastCrew
    
    var body: some View {
        if let crewPosterURL = URL.getCastCrewImage(actor: crew),
           let character = crew.character,
           let wikiLink = URL.getWikiLink(actor: crew) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    AsyncImage(url: crewPosterURL) { img in
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(width:150, height: 200)
                            .cornerRadius(4)
                    } placeholder: {
                        Image(systemName: "popcorn")
                            .resizable()
                            .scaledToFit()
                            .frame(width:150)
                            .cornerRadius(4)
                    }
                }
                Group {
                    Text(crew.name)
                        .foregroundColor(.black)
                    Text(character)
                        .foregroundColor(.black)
                    Link("More info...", destination: wikiLink)
                        .padding(.bottom)
                }
                .padding(.leading)
            }
            .frame(maxWidth: 150)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 10)
            }
        }
    }
}

struct CrewPosterView_Previews: PreviewProvider {
    static var previews: some View {
        CrewPosterView(crew: .testCrew)
    }
}
