//
//  PersistenceManager.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Foundation

enum PersistenceManager {

    // MARK: Properties
    static private let defaults = UserDefaults.standard

    // MARK: Custom Methods
    static func retrieve<T>(forKey key: Key, defaults: UserDefaults = defaults) throws -> T where T: Decodable {
        guard let valueData = defaults.object(forKey: key.rawValue) as? Data else {
            throw PersistenceError.valueNotFound
        }

        do {
            let value = try JSONDecoder().decode(T.self, from: valueData)
            return value
        } catch let error as DecodingError {
            throw PersistenceError.decodingFailed(innerError: error)
        } catch let error {
            throw PersistenceError.otherError(innerError: error)
        }
    }

    static func save<T>(value: T, forKey key: Key, defaults: UserDefaults = defaults) throws where T: Encodable {
        do {
            let encodedValue = try JSONEncoder().encode(value)
            defaults.set(encodedValue, forKey: key.rawValue)
        } catch let error as EncodingError {
            throw PersistenceError.encodingFailed(innerError: error)
        } catch let error {
            throw PersistenceError.otherError(innerError: error)
        }
    }
}
