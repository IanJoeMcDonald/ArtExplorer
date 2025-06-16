//
//  Label.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

class Label: UILabel {

    init(
        text: String? = nil,
        font: FontStyle,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 0
    ) {
        super.init(frame: .zero)
        self.text = text
        self.font = font.font
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
