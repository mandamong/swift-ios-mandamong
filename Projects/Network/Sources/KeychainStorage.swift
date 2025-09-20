//
//  KeychainStorage.swift
//  Network
//
//  Created by Swain Yun on 9/20/25.
//

import Foundation
import Security

enum KeychainStorageError: Error {
    case unknown(OSStatus)
    case itemNotFound
    case unexpectedData
    case duplicateItem
    case decodingError(DecodingError)
    case encodingError(EncodingError)
}

final class KeychainStorage<Item: Codable> {
    private typealias Query = [String: Any]
    
    private let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "Mandamong.KeychainStorage"
    private let key: String = "com.mandamong.keychainStorage"
    
    private let lock: NSLock = .init()
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    private func decode<D: Decodable>(_ type: D.Type, from data: Data) throws(KeychainStorageError) -> D {
        do {
            return try decoder.decode(D.self, from: data)
        } catch let error as DecodingError {
            throw .decodingError(error)
        } catch {
            throw .unknown(-1)
        }
    }
    
    private func encode<E: Encodable>(_ value: E) throws(KeychainStorageError) -> Data {
        do {
            return try encoder.encode(value)
        } catch let error as EncodingError {
            throw .encodingError(error)
        } catch {
            throw .unknown(-1)
        }
    }
    
    private func _create(_ item: Item, in query: Query) throws(KeychainStorageError) {
        let data = try encode(item)
        var query = query
        query[kSecValueData as String] = data
        
        let status = SecItemAdd(query as CFDictionary, nil)
        try checkStatus(status)
    }
    
    private func _read(_ query: Query) throws(KeychainStorageError) -> CFTypeRef? {
        var query = query
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var ref: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &ref)
        try checkStatus(status)
        return ref
    }
    
    private func _update(_ item: Item, in query: Query) throws(KeychainStorageError) {
        let data = try encode(item)
        let toUpdateQuery = [kSecValueData as String: data]
        
        let status = SecItemUpdate(query as CFDictionary, toUpdateQuery as CFDictionary)
        try checkStatus(status)
    }
    
    private func _delete(in query: Query) throws(KeychainStorageError) {
        let status = SecItemDelete(query as CFDictionary)
        try checkStatus(status)
    }
}

// MARK: - Helper Methods
extension KeychainStorage {
    private func makeQuery() -> Query {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: bundleIdentifier,
            kSecAttrAccount as String: key,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]
    }
    
    private func checkStatus(_ status: OSStatus) throws(KeychainStorageError) {
        switch status {
        case noErr:
            return
        case errSecItemNotFound:
            throw .itemNotFound
        case errSecDuplicateItem:
            throw .duplicateItem
        default:
            let errorDescription = SecCopyErrorMessageString(status, nil) as? String ?? "Unknown Error"
            print("[KeychainStorage] - Error Occurred: \(errorDescription) (Code: \(status))")
            throw KeychainStorageError.unknown(status)
        }
    }
    
    private func convert(_ ref: CFTypeRef?) throws(KeychainStorageError) -> Item {
        guard let data = ref as? Data else { throw .unexpectedData }
        let item = try decode(Item.self, from: data)
        return item
    }
}

// MARK: - Interfaces
extension KeychainStorage {
    func store(_ item: Item) throws(KeychainStorageError) {
        lock.lock()
        defer { lock.unlock() }
        
        let query = makeQuery()
        
        do {
            try _update(item, in: query)
        } catch KeychainStorageError.itemNotFound {
            do {
                try _create(item, in: query)
            } catch KeychainStorageError.duplicateItem {
                try _update(item, in: query)
            }
        }
    }
    
    func fetch(completion: @escaping (Result<Item, KeychainStorageError>) -> ()) {
        lock.lock()
        defer { lock.unlock() }
        
        let query = makeQuery()
        
        do {
            let ref = try _read(query)
            let item = try convert(ref)
            completion(.success(item))
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete() throws(KeychainStorageError) {
        lock.lock()
        defer { lock.unlock() }
        
        let query = makeQuery()
        
        do {
            try _delete(in: query)
        } catch KeychainStorageError.itemNotFound {
            return
        } catch {
            throw error
        }
    }
}
