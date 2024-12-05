//
//  CoinListViewController+Extension.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 04/12/24.
//

import UIKit

extension CryptoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        
        let coin = viewModel.filteredCoins[indexPath.row]
        var image = coin.isActive ? UIImage(named: "activeCoin") : UIImage(named: "inactiveCoin")
        image = coin.type == "token" ? UIImage(named: "token") : image
        cell.configure(title: coin.name, subtitle: "(\(coin.symbol))", image: image, isNew: coin.isNew)
        return cell
    }
}


extension CryptoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCoins(query: searchText)
    }
    
    // Handle Cancel Button Click
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Reset the filtered list to the original data when cancel is clicked
        viewModel.filteredCoins = viewModel.allCoins
        viewModel.reloadTableView?()
        searchBar.text = ""  // Clear the search bar
    }
}
