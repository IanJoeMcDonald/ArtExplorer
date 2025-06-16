//
//  Model.Core.NamedImage.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Model.Core {

    enum NamedImage: String {

        case placeholder

        var image: UIImage {
            UIImage(named: rawValue) ?? UIImage()
        }
    }
}
