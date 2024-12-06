//
//  NoDataView.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 06/12/24.
//

import UIKit

class NoDataView: UIView {
    
    private let iconImageView: UIImageView
    private let messageLabel: UILabel
    
    override init(frame: CGRect) {
        // Initialize components
        iconImageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
        messageLabel = UILabel()
        
        super.init(frame: frame)
        
        // Configure the view
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Setup the label
        messageLabel.text = "No data available"
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        // Setup the icon
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit
        
        // Stack the icon and label vertically
        let stackView = UIStackView(arrangedSubviews: [iconImageView, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the stack view to the custom view
        addSubview(stackView)
        
        // Set constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}
