//
//  NetworkError.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int) // Include HTTP status codes
    case decodingError
    case noData
    case timeout
    case noInternet // New case for internet connectivity issues
    case unknown(Error) // Catch-all for unexpected errors

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .requestFailed(let statusCode):
            return "Network request failed with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .noData:
            return "The response returned no data."
        case .timeout:
            return "The request timed out. Please try again."
        case .noInternet:
            return "No internet connection. Please check your network settings and try again."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}


