//
//  Extensions.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
