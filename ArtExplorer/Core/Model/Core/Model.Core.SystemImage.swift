//
//  Model.Core.SystemImages.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Model.Core {

    enum SystemImage: String {

        case backButton = "chevron.left"
        case favorite = "heart"
        case favoriteFill = "heart.fill"
        case list = "house"

        var image: UIImage {
            UIImage(systemName: rawValue) ?? UIImage()
        }
    }
}
