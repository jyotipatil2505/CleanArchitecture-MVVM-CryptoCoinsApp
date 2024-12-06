//
//  Endpoints.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation
import Foundation

// Struct to define an Endpoint for various API calls
struct Endpoint {
    
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    let headers: [String: String]?
    let body: Data?
    
    // Constructing full URL from the base URL, path, and query items
    var fullUrl: String {
        var components = URLComponents(string: APIConfig.baseUrl)!
        components.path = path
        components.queryItems = queryItems
        return components.url?.absoluteString ?? ""
    }
    
    // Generic initializer to support any endpoint
    init(
        path: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
    
    // Method to create GET request endpoint
    static func createGETEndpoint(
        path: String,
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String]? = nil
    ) -> Endpoint {
        return Endpoint(path: path, method: .GET, queryItems: queryItems, headers: headers)
    }
    
    // Method to create POST request endpoint
    static func createPOSTEndpoint(
        path: String,
        body: Data,
        headers: [String: String]? = nil
    ) -> Endpoint {
        return Endpoint(path: path, method: .POST, headers: headers, body: body)
    }
    
    // Method to create PUT request endpoint
    static func createPUTEndpoint(
        path: String,
        body: Data,
        headers: [String: String]? = nil
    ) -> Endpoint {
        return Endpoint(path: path, method: .PUT, headers: headers, body: body)
    }
    
    // Method to create DELETE request endpoint
    static func createDELETEEndpoint(
        path: String,
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String]? = nil
    ) -> Endpoint {
        return Endpoint(path: path, method: .DELETE, queryItems: queryItems, headers: headers)
    }
}
