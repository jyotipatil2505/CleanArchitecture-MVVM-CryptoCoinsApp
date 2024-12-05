//
//  CryptoNetworkDataSourceImpl.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class CryptoNetworkDataSourceImpl: CryptoNetworkDataSource {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func fetchCryptoCoins() async throws -> [CryptoCoinModel] {
        print("fetchCryptoCoins called")
        return try await apiService.fetchCryptoCoins()
    }
}
