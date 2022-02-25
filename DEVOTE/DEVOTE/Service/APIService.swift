//
//  APIService.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 18/02/2022.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private let baseURL: String = "https://jsonplaceholder.typicode.com/"
    
    @available(iOS 15.0.0, *)
    private func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        let fullURL = baseURL + endpoint
        guard let url = URL(string: fullURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}
