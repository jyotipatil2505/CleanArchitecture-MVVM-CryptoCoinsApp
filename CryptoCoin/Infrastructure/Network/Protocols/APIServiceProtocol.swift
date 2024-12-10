//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Jyoti Patil on 22/10/24.
//

import Foundation

protocol APIServiceProtocol {
    func fetchCryptoCoins() async throws -> [CryptoCoinModel]
}
