//
//  CacheError.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

enum CacheError: Error {

    case invalidMethod(methodType: URLMethod)
    case forceUpdateRequested
    case cachedValueNotFound
}
