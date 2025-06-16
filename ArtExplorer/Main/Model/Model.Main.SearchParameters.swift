//
//  Model.Main.SearchParameters.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Model.Main {

    struct SearchParameters {

        let query: String
        let hasImages: Bool

        func toDTO() -> DataTransfer.Collection.Send.Search {
            .init(query: query, hasImages: hasImages)
        }
    }
}
