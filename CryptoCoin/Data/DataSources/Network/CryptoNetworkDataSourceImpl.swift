//
//  CryptoNetworkDataSourceImpl.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class CryptoNetworkDataSourceImpl: CryptoNetworkDataSource {
    private let apiService: APIServiceManager

    init(apiService: APIServiceManager) {
        self.apiService = apiService
    }

    func fetchCryptoCoins() async throws -> [CryptoCoinModel] {
        return try await apiService.fetchCryptoCoins()
    }
}
