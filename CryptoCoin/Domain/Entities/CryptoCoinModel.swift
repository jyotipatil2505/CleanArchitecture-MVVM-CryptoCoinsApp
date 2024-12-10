//
//  CryptoCoinModel.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

struct CryptoCoinModel: Decodable {
    let name: String
    let symbol: String
    let type: String
    let isActive: Bool
    let isNew: Bool
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case type
        case isActive = "is_active" // Map "is_active" to "isActive"
        case isNew = "is_new"       // Map "is_new" to "isNew"
    }
}
