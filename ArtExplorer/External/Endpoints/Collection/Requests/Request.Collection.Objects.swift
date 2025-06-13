//
//  Request.Collection.Objects.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Request.Collection {

    class Objects: Endpoint {

        // MARK: Initializer
        init(objectID: String) {
            self.objectID = objectID
        }

        // MARK: Variables
        private let objectID: String

        // MARK: Properties
        var path: String { "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectID)" }

        var method: URLMethod { .get }
    }
}
