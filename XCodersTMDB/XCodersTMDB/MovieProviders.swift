//
//  MovieProviders.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 28/8/23.
//

import Foundation

struct WatchProvidersResponse: Identifiable {
    let id: Int
    let results: [String: WatchProvider]
}

struct WatchProvider: Codable {
  let link: String
  let flatrate: [WatchProviderItem]?
  let rent: [WatchProviderItem]?
  let buy: [WatchProviderItem]?

}

struct WatchProviderItem: Codable, Identifiable {
  let logoPath: String
  let id: Int
  let providerName: String
    
    enum CodingKeys: String, CodingKey {
        case providerName = "provider_name"
        case logoPath = "logo_path"
        case id = "provider_id"
    }
}
