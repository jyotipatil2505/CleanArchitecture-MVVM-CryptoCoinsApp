//
//  CryptoTableViewCell.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 04/12/24.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let rightImageView = UIImageView()
    private let newTagLabel = UILabel()  // New Tag Label
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Configure titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: LayoutConstants.defaultFontSize, weight: .bold)
        titleLabel.textColor = .black
        
        // Configure subtitleLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: LayoutConstants.mediumFontSize, weight: .regular)
        subtitleLabel.textColor = .darkGray
        
        // Configure rightImageView
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.clipsToBounds = true
        
        // Configure newTagLabel (for "New" tag)
        newTagLabel.font = UIFont.systemFont(ofSize: LayoutConstants.samllFontSize, weight: .bold)
        newTagLabel.textColor = .white
        newTagLabel.backgroundColor = .systemGreen
        newTagLabel.textAlignment = .center
        newTagLabel.text = "New"
        newTagLabel.layer.masksToBounds = true
        newTagLabel.isHidden = true // Initially hidden
        
//        newTagLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4) // Rotate by -45 degrees

        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(newTagLabel) // Add the "New" tag
        
        // Set constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        newTagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.defaultMargin),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.smallMargin),
            titleLabel.trailingAnchor.constraint(equalTo: newTagLabel.leadingAnchor, constant: -LayoutConstants.smallMargin),
            
            // Subtitle Label Constraints
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.defaultMargin),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -LayoutConstants.smallMargin),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -LayoutConstants.smallMargin),
            
            // Right ImageView Constraints
            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.defaultMargin),
            rightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightImageView.widthAnchor.constraint(equalToConstant: 24),
            rightImageView.heightAnchor.constraint(equalToConstant: 24),
            
            // New Tag Label Constraints
            newTagLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -LayoutConstants.smallMargin),
            newTagLabel.centerYAnchor.constraint(equalTo: rightImageView.centerYAnchor), // This centers the label vertically
            newTagLabel.widthAnchor.constraint(equalToConstant: 40),
            newTagLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(title: String, subtitle: String, image: UIImage?, isNew: Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        rightImageView.image = image
        newTagLabel.isHidden = !isNew
    }
}
