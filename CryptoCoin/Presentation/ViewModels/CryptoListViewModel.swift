//
//  CoinListViewModel.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 04/12/24.
//

import Foundation

class CryptoListViewModel {
    var allCoins: [CryptoCoinModel] = []
    var filteredCoins: [CryptoCoinModel] = []
    var reloadTableView: (() -> Void)?
    var showLoader: (() -> Void)?
    var hideLoader: (() -> Void)?
    var handleError: ((_ titleString: String, _ message: String) -> Void)?
    
    var isFilteredCoinsEmpty: Bool {
        return filteredCoins.isEmpty
    }
    
    private let getCryptoCoinsUseCase: GetCryptoCoinsUseCase
    
    init(getCryptoCoinsUseCase: GetCryptoCoinsUseCase) {
        self.getCryptoCoinsUseCase = getCryptoCoinsUseCase
        fetchCoins()
    }
    
    func fetchCoins() {
        showLoader?()
        Task {
            do {
                // Decide whether to fetch from network or local storage based on connectivity
                let coins = try await fetchCoinsBasedOnNetworkStatus()
                
                // Update UI with the fetched coins
                self.allCoins = coins
                self.filteredCoins = coins
                self.reloadTableView?()
            } catch {
                // Handle any error that occurs during fetching
                self.handleError?("Error", error.localizedDescription)
            }
            
            // Hide the loader after the operation is complete (whether it succeeded or failed)
            self.hideLoader?()
        }
    }
    
    private func fetchCoinsBasedOnNetworkStatus() async throws -> [CryptoCoinModel] {
        if Reachability.isConnectedToNetwork() {
            // Fetch from the network if connected
            return try await getCryptoCoinsUseCase.execute(fromNetwork: true)
        } else {
            // Fetch from local storage if no internet connection
            return try await getCryptoCoinsUseCase.execute(fromNetwork: false)
        }
    }
    
    func filterCoins(isActive: Bool?, isInactive: Bool?, onlyCoins: String?, isNew: Bool?, onlyTokens: String?) {
        filteredCoins = allCoins.filter { coin in
            var matches = true
            if let isActive = isActive {
                matches = matches && coin.isActive == isActive
            }
            if let isInactive = isInactive {
                matches = matches && coin.isActive == !isInactive
            }
            if let onlyCoins = onlyCoins {
                matches = matches && coin.type == onlyCoins
            }
            if let onlyTokens = onlyTokens {
                matches = matches && coin.type == onlyTokens
            }
            if let isNew = isNew {
                matches = matches && coin.isNew == isNew
            }
            return matches
        }
        reloadTableView?()
    }
    
    func searchCoins(query: String) {
        if query.isEmpty {
            // If the search text is empty, show the original data (allCoins)
            filteredCoins = allCoins
        } else {
            // Filter the coins based on the search query
            filteredCoins = allCoins.filter {
                $0.name.lowercased().contains(query.lowercased()) ||
                $0.symbol.lowercased().contains(query.lowercased())
            }

        }
        
        reloadTableView?()  // Trigger table reload
    }
}

