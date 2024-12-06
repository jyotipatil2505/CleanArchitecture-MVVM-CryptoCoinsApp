//
//  Constants.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 04/12/24.
//

import Foundation

enum FilterOption: String {
    case activeCoins = "Active Coins"
    case inactiveCoins = "Inactive Coins"
    case onlyCoins = "Only Coins"
    case onlyTokens = "Only Tokens"
    case newCoins = "New Coins"
}

// Constants for Layout Constraints
struct LayoutConstants {
    // Spacing constants (for padding or margins)
    static let defaultMargin: CGFloat = 16.0
    static let smallMargin: CGFloat = 8.0
    static let largeMargin: CGFloat = 24.0
    
    // Padding
    static let buttonHeight: CGFloat = 46.0
    
    // Font sizes (if you want to define sizes for labels, buttons, etc.)
    static let largeFontSize: CGFloat = 20.0
    static let defaultFontSize: CGFloat = 16.0
    static let mediumFontSize: CGFloat = 14.0
    static let samllFontSize: CGFloat = 12.0
    
    // Corner radius for UI elements
    static let defaultCornerRadius: CGFloat = 16.0
}

// Example of spacing for UI elements
struct Spacing {
    static let defaultVerticalSpacing: CGFloat = 16.0
    static let smallVerticalSpacing: CGFloat = 10.0
    static let mediumVerticalSpacing: CGFloat = 20.0
    
    static let defaultHorizontalSpacing: CGFloat = 16.0
    static let smallHorizontalSpacing: CGFloat = 10.0
    static let mediumHorizontalSpacing: CGFloat = 20.0
}
