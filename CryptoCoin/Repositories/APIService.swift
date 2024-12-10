//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//
import Foundation

/* APIService Handled the logic for fetching crypto coins list from the API */
class APIService: APIServiceProtocol {
    func fetchCryptoCoins() async throws -> [CryptoCoinModel] {
        let endpoint = Endpoint.createGETEndpoint(path: "", queryItems: [])
        do {
            let cryptoCoins: [CryptoCoinModel] = try await APIManager.shared.request(endpoint: endpoint)
            return cryptoCoins
        } catch let error as NetworkError {
            // Handle specific network error
            print("Network error: \(error)")
            throw error
        } catch {
            // Handle other types of errors
            print("Unknown error: \(error)")
            throw NetworkError.unknown(error)
        }
    }
}

