//
//  JSONDecoder.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import Foundation

func getJSON<JSON:Codable>(url: URLRequest, type: JSON.Type) async throws -> JSON {
    let (data, response) = try await URLSession.shared.dataRequest(urlReq: url)
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.dateFormat)
    
    guard let response = response as? HTTPURLResponse else {
        throw NetworkError.general
    }
    
    if response.statusCode == 200 {
        do {
            return try decoder.decode(JSON.self, from: data)
        } catch {
            print(error)
            throw NetworkError.general
        }
    } else {
        throw NetworkError.general
    }
}
