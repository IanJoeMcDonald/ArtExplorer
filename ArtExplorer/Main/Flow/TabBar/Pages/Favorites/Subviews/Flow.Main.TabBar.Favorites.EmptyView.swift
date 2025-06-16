//
//  Flow.Main.TabBar.Favorites.EmptyView.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.Favorites {

    class EmptyView: UIView, CodeView {

        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Components
        let titleLabel = Label(
            text: Localization.Main.TabBar.Favorites.emptyTitle,
            font: .heading(.xl),
            alignment: .center
        )

        // MARK: CodeView
        func setupSubviews() {
            addSubview(titleLabel)
        }

        func setupConstraints() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                    titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                    titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
                ]
            )
        }

        func setupAdditionalConfiguration() {
            backgroundColor = .systemRed
            titleLabel.textColor = .systemYellow
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
