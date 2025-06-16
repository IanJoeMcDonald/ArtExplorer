//
//  Model.Main.Helper.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 13/06/25.
//

@testable import ArtExplorer

extension Model.Main {

    enum Helper {

        static func createObject() -> Model.Main.Object {
            .init(
                id: 1,
                title: "Sunflowers",
                artist: "Vincent Van Gogh",
                date: "1888",
                medium: "Oil on canvis",
                department: "European Art",
                image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Vincent_Willem_van_Gogh_127.jpg/500px-Vincent_Willem_van_Gogh_127.jpg"
            )
        }
    }
}
