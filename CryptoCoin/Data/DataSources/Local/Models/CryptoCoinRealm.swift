//
//  CryptoCoinRealm.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//


import RealmSwift

class CryptoCoinRealm: Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var isActive: Bool
    @Persisted var isNew: Bool
    @Persisted var type: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
