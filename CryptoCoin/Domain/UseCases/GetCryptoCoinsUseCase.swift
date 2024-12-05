//
//  GetCryptoCoinsUseCase.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class GetCryptoCoinsUseCase {
    private let repository: CryptoRepositoryProtocol

    init(repository: CryptoRepositoryProtocol) {
        self.repository = repository
    }

    // Fetch data either from network or local based on the flag
    func execute(fromNetwork: Bool) async throws -> [CryptoCoinModel] {
        if fromNetwork {
            // Fetch from network and save to local storage
            let networkCoins = try await repository.getCryptoCoinsFromNetwork()
            try await repository.saveCryptoCoinsIntoLocal(networkCoins)
            return networkCoins
        } else {
            // Fetch from local storage
            let localCoins = try await repository.getCryptoCoinsFromLocal()
            return localCoins
        }
    }
}

