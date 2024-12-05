//
//  CryptoListViewModelTests.swift
//  CryptoCoinTests
//
//  Created by Jyoti Patil on 05/12/24.
//

import XCTest
@testable import CryptoCoin

class CryptoListViewModelTests: XCTestCase {
    
    var viewModel: CryptoListViewModel!
    var mockUseCase: MockGetCryptoCoinsUseCase!
    var mockRepository: MockCryptoRepository!
    
    override func setUp() {
        super.setUp()
        
        // Initialize the mock repository and mock use case
        mockRepository = MockCryptoRepository()
        mockUseCase = MockGetCryptoCoinsUseCase(repository: mockRepository)
        viewModel = CryptoListViewModel(getCryptoCoinsUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Network Tests
    func testFetchCoinsSuccess() async {
        // Given
        mockUseCase.mockedCoins = [
            CryptoCoinModel(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: true, id: UUID().uuidString)
        ]
        
        // Expect that the reloadTableView will be called after fetchCoins
        let expectation = self.expectation(description: "reloadTableView should be called")
        
        // Use a flag to ensure expectation is only fulfilled once
        var expectationFulfilled = false
        // When
        // Set up the reloadTableView to fulfill the expectation
        viewModel.reloadTableView = {
            if !expectationFulfilled {
                expectation.fulfill()  // Fulfill the expectation only once
                expectationFulfilled = true
            }
        }
        
        viewModel.fetchCoins()
        
        // Wait for the expectation to be fulfilled within the timeout
        await fulfillment(of: [expectation], timeout: 1.0)
                
        // Assert the expected outcomes
        XCTAssertEqual(viewModel.allCoins.count, 1)
        XCTAssertEqual(viewModel.filteredCoins.count, 1)
    }
    
    func testFetchCoinsFailure() async {
        // Given
        mockUseCase.errorToThrow = NSError(domain: "Test", code: 1, userInfo: nil)
        
        // Expect that the handleError callback will be called when there's a failure
        let expectation = self.expectation(description: "handleError should be called")
        
        // Use a flag to ensure expectation is only fulfilled once
        var expectationFulfilled = false
        // When
        // Set up the handleError callback to fulfill the expectation
        viewModel.handleError = { _, _ in
            if !expectationFulfilled {
                expectation.fulfill()  // Fulfill the expectation only once
                expectationFulfilled = true
            }
        }
        
        viewModel.fetchCoins()
        
        // Wait for the expectation to be fulfilled within the timeout
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Assert the expected outcomes
        XCTAssertEqual(viewModel.allCoins.count, 0, "Coins should be empty on failure")
        XCTAssertEqual(viewModel.filteredCoins.count, 0, "Filtered coins should be empty on failure")
    }
    
    // MARK: - Filter Tests
    func testFilterCoins() {
        // Given
        let coin1 = CryptoCoinModel(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: true, id: UUID().uuidString)
        let coin2 = CryptoCoinModel(name: "Ethereum", symbol: "ETH", type: "coin", isActive: false, isNew: false, id: UUID().uuidString)
        viewModel.allCoins = [coin1, coin2]
        
        XCTAssertTrue(viewModel.filteredCoins.isEmpty, "filteredCoins should initially be empty")

        viewModel.filterCoins(isActive: true, isInactive: nil, onlyCoins: nil, isNew: nil, onlyTokens: nil)
        
        XCTAssertEqual(viewModel.filteredCoins.count, 1)
    }
    
    // MARK: - Search Tests
    func testSearchCoins() async {
        // Given
        let coin1 = CryptoCoinModel(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: true, id: nil)
        let coin2 = CryptoCoinModel(name: "Ethereum", symbol: "ETH", type: "coin", isActive: false, isNew: false, id: nil)
        viewModel.allCoins = [coin1, coin2]
        
        // Make sure filteredCoins is empty before searching
        XCTAssertTrue(viewModel.filteredCoins.isEmpty, "filteredCoins should initially be empty")
        
        viewModel.searchCoins(query: "Ethereum") // Await the async function
        
        // Make sure filtering is done
        XCTAssertEqual(viewModel.filteredCoins.count, 1)
    }
}
