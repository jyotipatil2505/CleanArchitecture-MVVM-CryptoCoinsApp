import Foundation
import RealmSwift

class CryptoLocalDataSourceImpl: CryptoLocalDataSource {
    
    private var realm: Realm?
    
    init() {
        DispatchQueue.main.async {
            do {
                self.realm = try Realm()  // Initialize Realm
            } catch {
                self.realm = nil
            }
        }
    }
    
    // Fetch coins from local storage (Realm)
    func fetchCryptoCoins() async throws -> [CryptoCoinModel] {
            
        return try await withCheckedThrowingContinuation { continuation in
            // Dispatching with a delay of 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                
                // Check if `realm` is initialized after the delay
                if let realm = self.realm {
                    do {
                        // Fetch Realm objects
                        let realmCoins = realm.objects(CryptoCoinRealm.self)
                        print("Realm Coins count :::::: \(realmCoins.count)")
                        
                        // Convert to domain model
                        let cryptoCoins = realmCoins.map { $0.toDomain() }
                        
                        // Check if data is available
                        if cryptoCoins.isEmpty {
                            throw LocalStorageError.objectNotFound
                        }
                        
                        // Return the result on the main thread after processing
                        continuation.resume(returning: Array(cryptoCoins))
                    } catch {
                        print("Realm Fetch Coin error ::::: \(error)")
                        // Resume with error if fetching fails
                        continuation.resume(throwing: error)
                    }
                } else {
                    print("Realm initialization failed in the delayed block")
                    // Resume with the error if `realm` is nil after the delay
                    continuation.resume(throwing: LocalStorageError.realmInitializationFailed)
                }
            }
        }
    }
    
    // Save coins to local storage (Realm)
    func saveCryptoCoins(_ coins: [CryptoCoinModel]) async throws {
        // Use `withCheckedThrowingContinuation` for async error handling
        return try await withCheckedThrowingContinuation { continuation in
            
            // Dispatch the operation with a delay (if needed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                // Check if `realm` is available after the delay
                if let realm = self.realm {
                    do {
                        // Clear all objects in the realm before saving new ones
                        try realm.write {
                            realm.deleteAll() // This will remove all objects in Realm
                        }
                        // Map domain models to Realm objects
                        let realmCoins = coins.map { $0.toRealm() }
                        
                        // Perform Realm write operation
                        try realm.write {
                            realm.add(realmCoins, update: .modified)
                        }
                        
                        print("Saved \(realmCoins.count) coins to Realm")
                        continuation.resume()
                    } catch {
                        print("Realm Error while saving coins ::::: \(error)")
                        continuation.resume(throwing: error)
                    }
                } else {
                    // If `realm` is nil, throw an error
                    print("Realm initialization failed after delay")
                    continuation.resume(throwing: LocalStorageError.realmInitializationFailed)
                }
            }
        }
    }
}

