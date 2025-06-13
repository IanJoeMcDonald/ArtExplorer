//
//  Repository.Collection.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Repository {

    class Collection {

        // MARK: Initializers
        init (networkManager: NetworkManager = .init()) {
            self.networkManager = networkManager
        }

        // MARK: Properties
        let networkManager: NetworkManager

        // MARK: Custom Methods
        func fetchObject(
            _ endpoint: Request.Collection.Objects
        ) async throws -> DataTransfer.Collection.Receive.Object {
            try await networkManager.request(endpoint)
        }

        func fetchSearchResults(
            _ endpoint: Request.Collection.Search
        ) async throws -> DataTransfer.Collection.Receive.Search {
            try await networkManager.request(endpoint)
        }
    }
}
