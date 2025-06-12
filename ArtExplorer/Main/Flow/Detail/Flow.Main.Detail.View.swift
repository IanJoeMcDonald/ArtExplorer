//
//  Flow.Main.Detail.View.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.Detail {

    class View: UIView {

        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            backgroundColor = .systemGray
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    }
}
