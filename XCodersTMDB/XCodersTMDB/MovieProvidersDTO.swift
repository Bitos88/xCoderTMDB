//
//  MovieProvidersDTO.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 28/8/23.
//

import Foundation

struct WatchProvidersResponseDTO: Codable {
  let id: Int
  let results: [String: WatchProviderDTO]
}

struct WatchProviderDTO: Codable {
  let link: String
  let flatrate: [WatchProviderItemDTO]?
  let rent: [WatchProviderItemDTO]?
  let buy: [WatchProviderItemDTO]?

}

struct WatchProviderItemDTO: Codable, Identifiable {
  let logoPath: String
  let id: Int
  let providerName: String
    
    enum CodingKeys: String, CodingKey {
        case providerName = "provider_name"
        case logoPath = "logo_path"
        case id = "provider_id"
    }
}

extension WatchProviderItemDTO {
    func mapToModel() -> WatchProviderItem {
        WatchProviderItem(logoPath: logoPath, id: id, providerName: providerName)
    }
}

extension WatchProviderDTO {
    func mapToModel() -> WatchProvider {
        WatchProvider(link: link,
                      flatrate: flatrate?.map { $0.mapToModel() },
                      rent: rent?.map { $0.mapToModel() },
                      buy: buy?.map { $0.mapToModel() })
    }
}

extension WatchProvidersResponseDTO {
    func mapToModel() -> WatchProvidersResponse {
        WatchProvidersResponse(id: id, results: results.mapValues { $0.mapToModel() } )
    }
}
