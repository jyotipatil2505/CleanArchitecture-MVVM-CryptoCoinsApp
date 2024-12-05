//
//  CryptoRepositoryProtocol.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

protocol CryptoRepositoryProtocol {
    func getCryptoCoinsFromNetwork() async throws -> [CryptoCoinModel]
    func getCryptoCoinsFromLocal() async throws -> [CryptoCoinModel]
    func saveCryptoCoinsIntoLocal(_ coins: [CryptoCoinModel]) async throws
}

