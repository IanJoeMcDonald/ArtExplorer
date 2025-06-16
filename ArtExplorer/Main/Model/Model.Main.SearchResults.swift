//
//  Model.Main.SearchResults.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Model.Main {

    struct SearchResults {

        let itemCount: Int
        let itemIds: [Int]
    }
}

extension Model.Main.SearchResults {

    init(from dto: DataTransfer.Collection.Receive.Search) {

        self.itemCount = dto.total ?? 0
        self.itemIds = dto.objectIDs ?? []
    }
}
