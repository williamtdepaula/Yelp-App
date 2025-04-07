//
//  Client.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

final class YelpAPIClient {
    
    private let apiKey = "I2apss9INt7iSTTKNO06vvbe7rG6VeIPXkm4GAtlnkxt9ugYF3EvRrqA--yoU1dhl2u3XFTk9FmsS79aQs2zjoHfY4xCfB20TqG6Rsa9gFHsjnqAlVXSywB6gZnyZ3Yx"
    
    func request<T: Decodable>(_ endpoint: YelpEndpoint, responseType: T.Type) async throws -> T {
        var components = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: true)!
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw YelpError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw YelpError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error:", error)
            throw YelpError.invalidData
        }
    }
}
