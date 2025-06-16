//
//  Model.Main.TabBar.Favorites.ViewInformation.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Model.Main.TabBar.Favorites {

    enum ViewInformation { }
}

extension Model.Main.TabBar.Favorites.ViewInformation {

    enum CollectionViewState: Equatable {

        case isEmpty
        case isLoading
        case setup(with: [Model.Main.Object])
    }
}
