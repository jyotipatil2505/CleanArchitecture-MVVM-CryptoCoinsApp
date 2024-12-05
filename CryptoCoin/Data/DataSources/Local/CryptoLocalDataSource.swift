//
//  CryptoLocalDataSource.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

protocol CryptoLocalDataSource {
    func fetchCryptoCoins() async throws -> [CryptoCoinModel]
    func saveCryptoCoins(_ coins: [CryptoCoinModel]) async throws
}
