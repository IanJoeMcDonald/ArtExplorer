//
//  Request.Collection.Search.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Request.Collection {

    class Search: Endpoint {

        // MARK: Initializer
        init(searchParameters: DataTransfer.Collection.Send.Search) {
            self.searchParameters = searchParameters
        }

        // MARK: Variables
        private let searchParameters: DataTransfer.Collection.Send.Search

        // MARK: Properties
        var path: String { "https://collectionapi.metmuseum.org/public/collection/v1/search" }

        var method: URLMethod { .get }

        var queryItems: [String : String] { searchParameters.createQueryItems() }
    }
}
