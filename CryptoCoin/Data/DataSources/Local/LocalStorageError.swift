//
//  LocalStorageError.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

enum LocalStorageError: Error {
    case realmInitializationFailed
    case objectNotFound
    case failedToSave
    case invalidData

    var localizedDescription: String {
        switch self {
        case .realmInitializationFailed:
            return "There was an issue initializing the local storage."
        case .objectNotFound:
            return "The requested object was not found in the local storage."
        case .failedToSave:
            return "Failed to save the data to local storage."
        case .invalidData:
            return "The data provided is invalid for storage."
        }
    }
}
