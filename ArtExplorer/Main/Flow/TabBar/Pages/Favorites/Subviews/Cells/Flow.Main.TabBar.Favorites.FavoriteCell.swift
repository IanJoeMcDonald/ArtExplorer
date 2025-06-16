//
//  Flow.Main.TabBar.Favorites.FavoriteCell.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.Favorites {

    class FavoriteCell: UICollectionViewCell, CodeView {

        // MARK: Initializers
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        static let reuseID = "FavoriteCell"

        // MARK: Components
        private let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()
        private let titleLabel = Label(font: .body(.lg), alignment: .center)

        private let contentStackView: UIStackView = {
            let view = UIStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.spacing = Spacing.xxxs.rawValue

            return view
        }()


        // MARK: CodeView
        func setupSubviews() {
            contentStackView.addArrangedSubview(imageView)
            contentStackView.addArrangedSubview(titleLabel)

            contentView.addSubview(contentStackView)
        }

        func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ]
            )
        }

        func setupAdditionalConfiguration() {
            titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        // MARK: Custom Methods
        func setup(with model: Model.Main.Object) {
            imageView.load(url: URL(string: model.image))
            titleLabel.text = model.title
        }
    }
}
