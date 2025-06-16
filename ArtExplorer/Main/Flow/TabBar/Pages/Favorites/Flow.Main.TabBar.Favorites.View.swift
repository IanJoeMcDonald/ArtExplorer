//
//  Flow.Main.TabBar.Favorites.View.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.Favorites {

    class View: UIView, CodeView {

        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Components
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        private let emptyView = EmptyView()

        // MARK: CodeView
        func setupSubviews() {
            addSubview(collectionView)
        }

        func setupConstraints() {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                    collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
                ]
            )
        }

        func setupAdditionalConfiguration() {
            backgroundColor = .systemRed
            collectionView.backgroundColor = .systemRed
        }

        // MARK: Custom Methods
        func emptyViewIsHidden(_ isHidden: Bool) {
            if isHidden {
                emptyView.removeFromSuperview()
            } else {
                addSubview(emptyView)

                NSLayoutConstraint.activate(
                    [
                        emptyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                        emptyView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                        emptyView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                        emptyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
                    ]
                )
            }
        }
    }
}
