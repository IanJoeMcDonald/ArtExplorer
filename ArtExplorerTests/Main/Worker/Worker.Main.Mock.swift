//
//  Worker.Main.Mock.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 13/06/25.
//

@testable import ArtExplorer

extension Worker.Main {

    class Mock: Worker.Main {

        var error: Error?

        override func fetchObject(for objectID: String) async throws -> Model.Main.Object {
            if let error {
                throw error
            }

            return Model.Main.Helper.createObject()
        }

        override func fetchSearchResults(
            for searchParameters: Model.Main.SearchParameters
        ) async throws -> Model.Main.SearchResults {
            if let error {
                throw error
            }

            return .init(itemCount: 2, itemIds: [1,2])
        }
    }
}
