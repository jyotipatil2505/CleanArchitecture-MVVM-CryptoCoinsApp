//
//  CryptoCoin+RealmMapper.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

extension CryptoCoinModel {
    func toRealm() -> CryptoCoinRealm {
        let realmModel = CryptoCoinRealm()
        realmModel.id = UUID().uuidString
        realmModel.name = self.name
        realmModel.symbol = self.symbol
        realmModel.isActive = self.isActive
        realmModel.isNew = self.isNew
        realmModel.type = self.type
        return realmModel
    }
}
