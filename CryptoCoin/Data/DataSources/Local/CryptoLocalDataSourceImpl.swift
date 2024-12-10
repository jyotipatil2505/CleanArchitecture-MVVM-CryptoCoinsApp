import Foundation
import RealmSwift

import Foundation
import RealmSwift

class CryptoLocalDataSourceImpl: CryptoLocalDataSource {
    
    let queueName: String = "com.cryptocoin.database.queue"
    lazy var queue = DispatchQueue(label: queueName)
    
    // Helper function to execute Realm operations
    private func performRealmOperation<T>(
        operation: @escaping (Realm) throws -> T,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        queue.async {
            do {
                let realm = try Realm() // Initialize Realm
                let result = try operation(realm) // Perform the operation
                completion(.success(result)) // Return result on the main thread
            } catch {
                completion(.failure(error)) // Return error on the main thread
            }
        }
    }
    
    // Fetch coins from local storage (Realm)
    func fetchCryptoCoins() async throws -> [CryptoCoinModel] {
        return try await withCheckedThrowingContinuation { continuation in
            performRealmOperation(
                operation: { realm in
                    let realmCoins = realm.objects(CryptoCoinRealm.self)
                    if realmCoins.isEmpty {
                        throw LocalStorageError.objectNotFound
                    }
                    return realmCoins.map { $0.toDomain() }
                },
                completion: { result in
                    switch result {
                    case .success(let cryptoCoins):
                        print("cryptoCoins :::: ",cryptoCoins)
                        continuation.resume(returning: Array(cryptoCoins))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    // Save coins to local storage (Realm)
    func saveCryptoCoins(_ coins: [CryptoCoinModel]) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            performRealmOperation(
                operation: { realm in
                    try realm.write {
                        realm.deleteAll() // Clear existing objects
                        let realmCoins = coins.map { $0.toRealm() }
                        realm.add(realmCoins, update: .modified) // Add new objects
                        print("Saved :::: ",realmCoins.count)
                    }
                },
                completion: { result in
                    switch result {
                    case .success:
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
}
