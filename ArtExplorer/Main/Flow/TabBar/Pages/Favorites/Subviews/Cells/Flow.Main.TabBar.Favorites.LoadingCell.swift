//
//  Flow.Main.TabBar.Favorites.LoadingCell.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.Favorites {

    class LoadingCell: UICollectionViewCell, CodeView {

        // MARK: Initializers
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        static let reuseID = "LoadingCell"

        // MARK: Components
        private let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = Model.Core.NamedImage.placeholder.image
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()


        // MARK: CodeView
        func setupSubviews() {
            contentView.addSubview(imageView)
        }

        func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

                    imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ]
            )
        }

        func setupAdditionalConfiguration() {
            imageView.isLoading(true, loaderColor: .white)
        }
    }
}
