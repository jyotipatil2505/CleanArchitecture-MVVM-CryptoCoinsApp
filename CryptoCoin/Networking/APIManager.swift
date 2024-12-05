//
//  APIManager.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    // Optimized request method using async/await
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        // Validate the URL
        guard let url = URL(string: endpoint.fullUrl) else {
            throw NetworkError.invalidURL
        }
        
        // Check if there's an internet connection
        guard Reachability.isConnectedToNetwork() else {
            throw NetworkError.noInternet
        }
        
        // Setup the request
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the network request and handle the response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Handle the response
        try handleResponse(response, data: data)
        
        // Decode and return the result
        return try decodeResponse(T.self, data: data)
    }
    
    // Handle HTTP response status codes
    private func handleResponse(_ response: URLResponse?, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed(statusCode: 0)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            if data == nil {
                throw NetworkError.noData
            }
        case 400...499, 500...599:
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        default:
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    // Decode the data into the appropriate model
    private func decodeResponse<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}

