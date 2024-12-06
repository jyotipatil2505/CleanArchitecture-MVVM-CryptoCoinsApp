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
    
    //MARK: - Initialization Methods
    override init(frame: CGRect) {
        iconImageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
        messageLabel = UILabel()
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private Methods
    private func setupUI() {
        // Setup the label
        messageLabel.text = Localization.localizedString(for: "no_crypto_coins_available",defaultValue: "No crypto coins available at the moment.")
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: LayoutConstants.largeFontSize, weight: .medium)
        
        // Setup the icon
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.iconHeight).isActive = true // Adjust size
        iconImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.iconHeight).isActive = true

        // Stack the icon and label vertically
        let stackView = UIStackView(arrangedSubviews: [iconImageView, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.smallVerticalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the stack view to the custom view
        addSubview(stackView)
        
        // Set constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.defaultMargin),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.defaultMargin)
        ])
    }
}
