//
//  Flow.Main.TabBar.List.ObjectCell.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.List {

    class Cell: UICollectionViewCell, CodeView {

        // MARK: Initializers
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        static let reuseID = "Cell"

        // MARK: Components
        private let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
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
                    imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                ]
            )
        }

        func setupAdditionalConfiguration() {
            /*contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.white.cgColor
            contentView.layer.cornerRadius = Spacing.xxxs.rawValue
            contentView.clipsToBounds = true*/
        }

        // MARK: Custom Methods
        func setup(with model: Model.Main.TabBar.List.ViewInformation.Object) {
            imageView.load(url: URL(string: model.image))
        }
    }
}
