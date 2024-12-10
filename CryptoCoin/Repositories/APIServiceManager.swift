//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//
import Foundation

/* APIService Handled the logic for fetching crypto coins list from the API */
class APIServiceManager: APIServiceProtocol {
    func fetchCryptoCoins() async throws -> [CryptoCoinModel] {
        let endpoint = Endpoint.createGETEndpoint(path: "", queryItems: [])
        do {
            let cryptoCoins: [CryptoCoinModel] = try await NetworkManager.shared.request(endpoint: endpoint)
            return cryptoCoins
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}

