//
//  GetCryptoCoinsUseCaseTests.swift
//  CryptoCoinTests
//
//  Created by Jyoti Patil on 05/12/24.
//

import XCTest
@testable import CryptoCoin

class GetCryptoCoinsUseCaseTests: XCTestCase {

    var useCase: GetCryptoCoinsUseCase!
    var mockRepository: MockCryptoRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCryptoRepository()
        useCase = GetCryptoCoinsUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Network Tests
    func testExecuteNetworkSuccess() async throws {
        // Given
        let mockCoins = [CryptoCoinModel(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: true, id: UUID().uuidString)]
        mockRepository.networkCoins = mockCoins
        
        // When
        let coins = try await useCase.execute(fromNetwork: true)
                
        // Then
        XCTAssertEqual(coins.count, 1, "Should return one coin from the network")
        XCTAssertEqual(coins.first?.name, "Bitcoin", "The coin name should be Bitcoin")
    }
    
    func testExecuteNetworkFailure() async throws {
        // Given
        mockRepository.errorToThrow = NSError(domain: "MockRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Network data not available"])
        
        // When / Then
        await assertThrowsError({
            _ = try await self.useCase.execute(fromNetwork: true)
        }, errorDescription: "Network data not available")
    }
    
    // MARK: - Local Tests
    func testExecuteLocalSuccess() async throws {
        // Given
        let mockCoins = [CryptoCoinModel(name: "Ethereum", symbol: "ETH", type: "coin", isActive: false, isNew: false, id: UUID().uuidString)]
        mockRepository.localCoins = mockCoins
        
        // When
        let coins = try await useCase.execute(fromNetwork: false)
                
        // Then
        XCTAssertEqual(coins.count, 1, "Should return one coin from local storage")
        XCTAssertEqual(coins.first?.name, "Ethereum", "The coin name should be Ethereum")
    }
    
    func testExecuteLocalFailure() async throws {
        // Given
        mockRepository.errorToThrow = NSError(domain: "MockRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Local data not available"])
        
        await assertThrowsError({
            _ = try await self.useCase.execute(fromNetwork: false)
        }, errorDescription: "Local data not available")
    }
    
    // MARK: - Network to Local Save Tests
    func testExecuteNetworkSaveToLocal() async throws {
        // Given
        let mockCoins = [CryptoCoinModel(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: true, id: UUID().uuidString)]
        mockRepository.networkCoins = mockCoins
        
        // When
        let coins = try await useCase.execute(fromNetwork: true)
        
        // Then
        XCTAssertEqual(coins.count, 1, "Should return one coin from the network")
        XCTAssertEqual(coins.first?.name, "Bitcoin", "The coin name should be Bitcoin")
        
        // Ensure coins were saved to local storage
        XCTAssertTrue(mockRepository.localCoins.count > 0, "Local coins should be saved after fetching from network")
        XCTAssertEqual(mockRepository.localCoins.first?.name, "Bitcoin", "Local storage should have the same coin")
    }
    
    // MARK: - Helper Methods
    // Custom helper method to assert error throwing
    private func assertThrowsError(_ expression: @escaping () async throws -> Void, errorDescription: String) async {
        do {
            try await expression()
            XCTFail("Expected error but none was thrown.")
        } catch let error as NSError {
            XCTAssertEqual(error.localizedDescription, errorDescription, "Expected error to have description: \(errorDescription)")
        }
    }
}
