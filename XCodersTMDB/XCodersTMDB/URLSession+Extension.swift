//
//  URLSession+Extension.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 3/8/23.
//

import Foundation

extension URLSession {
    func dataRequest(urlReq: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await data(for: urlReq)
        } catch {
            throw NetworkError.urlRequestNotValid
        }
    }
}

enum NetworkError: Error {
    case urlRequestNotValid
    case general
    
    var description: String {
        switch self {
        case .urlRequestNotValid:
            return "URL Request Not Valid"
        case .general:
            return "General Error"
        }
    }
}
