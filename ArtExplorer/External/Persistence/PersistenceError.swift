//
//  PersistenceError.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Foundation

enum PersistenceError: Error {

    case decodingFailed(innerError: DecodingError)
    case encodingFailed(innerError: EncodingError)
    case otherError(innerError: Error)
    case valueNotFound
}
