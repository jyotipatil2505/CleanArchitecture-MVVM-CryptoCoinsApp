//
//  CryptoNetworkDataSource.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

protocol CryptoNetworkDataSource {
    func fetchCryptoCoins() async throws -> [CryptoCoinModel]
}
