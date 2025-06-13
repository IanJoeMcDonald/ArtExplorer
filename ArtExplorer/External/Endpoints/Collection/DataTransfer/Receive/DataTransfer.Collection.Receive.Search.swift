//
//  DataTransfer.Collection.Receive.Search.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension DataTransfer.Collection.Receive {

    struct Search: Decodable {

        let total: Int?
        let objectIDs: [Int]?
    }
}
