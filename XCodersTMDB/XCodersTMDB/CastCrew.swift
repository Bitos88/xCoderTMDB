//
//  CastCrew.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 10/8/23.
//

import Foundation

struct CastCrew: Identifiable, Hashable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String?
}
