//
//  Endpoints.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?

    var fullUrl: String {
        var components = URLComponents(string: APIConfig.baseUrl)!
        var allQueryItems = queryItems ?? []
//        allQueryItems.append(URLQueryItem(name: "apiKey", value: APIConfig.apiKey)) // Add API key
        components.queryItems = allQueryItems // Set the query items
        return components.url?.absoluteString ?? ""
    }
    
    // Function to create a topHeadlines endpoint with an optional category
    static func fetchCryptoCoins() -> Endpoint {
        let queryItems = [
            URLQueryItem(name: "", value: "")
        ]
        return Endpoint(path: "/", method: .GET, queryItems: queryItems)
    }
    
    static func topHeadlines(category: String? = nil) -> Endpoint {
        var queryItems = [
            URLQueryItem(name: "country", value: "us")
        ]
        
        // Add category to the query items if it's provided
        if let category = category, !category.isEmpty {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        
        return Endpoint(path: "/top-headlines", method: .GET, queryItems: queryItems)
    }
}
