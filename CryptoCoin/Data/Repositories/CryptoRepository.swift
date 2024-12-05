//
//  File.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class CryptoRepository: CryptoRepositoryProtocol {
    
    private let networkDataSource: CryptoNetworkDataSource
    private let localDataSource: CryptoLocalDataSource

    init(networkDataSource: CryptoNetworkDataSource, localDataSource: CryptoLocalDataSource) {
        self.networkDataSource = networkDataSource
        self.localDataSource = localDataSource
    }
    
    func getCryptoCoinsFromNetwork() async throws -> [CryptoCoinModel] {
        print("getCryptoCoinsFromNetwork called")

        // Fallback to network if local data is unavailable
        let networkCoins = try await networkDataSource.fetchCryptoCoins()
        try await localDataSource.saveCryptoCoins(networkCoins) // Cache the data
        return networkCoins
    }
    
    func getCryptoCoinsFromLocal() async throws -> [CryptoCoinModel] {
        print("getCryptoCoinsFromLocal")
        // Try local storage first
        let localCoins = try await localDataSource.fetchCryptoCoins()
        return localCoins
    }
    
    func saveCryptoCoinsIntoLocal(_ coins: [CryptoCoinModel]) async throws {
        try await localDataSource.saveCryptoCoins(coins)
    }
}
