//
//  CastCrew.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 10/8/23.
//

import Foundation

struct CreditsResult: Codable {
    let id: Int
    let cast: [CastMemberDTO]
}

struct CastMemberDTO: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}

extension CastMemberDTO {
    func mapToModel() -> CastCrew {
        CastCrew(id: id,
                 name: name,
                 profilePath: profilePath,
                 character: character)
    }
}
