//
//  Model.Main.Object.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Model.Main {

    struct Object: Codable, Equatable {

        let id: Int
        let title: String
        let artist: String
        let date: String
        let medium: String
        let department: String
        let image: String
    }
}

extension Model.Main.Object  {

    init?(from dto: DataTransfer.Collection.Receive.Object) {
        guard
            let id = dto.objectID,
            let image = dto.primaryImageSmall,
            !image.isEmpty
        else { return nil }
        let date = if let objectDate = dto.objectEndDate { "\(objectDate)" } else { "-" }

        self.id = id
        self.title = dto.title ?? "-"
        self.artist = dto.artistDisplayName ?? "-"
        self.date = date
        self.medium = dto.medium ?? "-"
        self.department = dto.department ?? "-"
        self.image = image
    }
}
