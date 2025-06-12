//
//  Model.Core.SystemImages.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Model.Core {

    enum SystemImage: String {

        case favorite = "star"
        case list = "house"
        case search = "magnifyingglass"

        var image: UIImage {
            UIImage(systemName: rawValue) ?? UIImage()
        }
    }
}
