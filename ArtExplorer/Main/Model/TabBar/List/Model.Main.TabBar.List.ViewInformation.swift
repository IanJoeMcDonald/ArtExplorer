//
//  Model.Main.TabBar.List.ViewInformation.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Model.Main.TabBar.List {

    enum ViewInformation { }
}

extension Model.Main.TabBar.List.ViewInformation {

    enum Section {

        case main
    }
}

extension Model.Main.TabBar.List.ViewInformation {

    struct Object: Hashable {

        var id: Int
        var image: String
    }
}

extension Model.Main.TabBar.List.ViewInformation.Object {

    init(from model: Model.Main.Object) {
        self.id = model.id
        self.image = model.image
    }
}
