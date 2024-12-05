//
//  MockCryptoRepository.swift
//  CryptoCoinTests
//
//  Created by Jyoti Patil on 06/12/24.
//
import Foundation
@testable import CryptoCoin
// Mock repository class
class MockCryptoRepository: CryptoRepositoryProtocol {
    
    var networkCoins: [CryptoCoinModel] = []
    var localCoins: [CryptoCoinModel] = []
    var errorToThrow: Error?
    
    // Mock fetching coins from network
    func getCryptoCoinsFromNetwork() async throws -> [CryptoCoinModel] {
        if let error = errorToThrow {
            throw error
        }
        return networkCoins
    }
    
    // Mock saving coins into local storage
    func saveCryptoCoinsIntoLocal(_ coins: [CryptoCoinModel]) async throws {
        // Simulate saving coins (no-op in mock)
        localCoins = coins
    }
    
    // Mock fetching coins from local storage
    func getCryptoCoinsFromLocal() async throws -> [CryptoCoinModel] {
        if let error = errorToThrow {
            throw error
        }
        return localCoins
    }
}
