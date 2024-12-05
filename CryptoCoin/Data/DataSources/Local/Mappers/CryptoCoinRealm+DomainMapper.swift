//
//  CryptoCoinRealm+DomainMapper.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

// Map Realm Object to Domain Model
extension CryptoCoinRealm {
    func toDomain() -> CryptoCoinModel {
        return CryptoCoinModel(
            name: self.name,
            symbol: self.name,
            type: self.symbol,
            isActive: self.isActive,
            isNew: self.isNew,
            id: self.id
        )
    }
}
