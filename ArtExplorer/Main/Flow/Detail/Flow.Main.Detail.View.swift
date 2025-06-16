//
//  Flow.Main.Detail.View.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.Detail {

    class View: UIView, CodeView {

        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Components
        private let scrollView: UIScrollView = {
            let view = UIScrollView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.showsVerticalScrollIndicator = false

            return view
        }()

        private let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()

        private let titleLabel = Label(font: .heading(.xl), alignment: .center)

        private let artistTitleLabel = Label(font: .heading(.lg))
        private let artistLabel = Label(font: .heading(.xl))
        private let mediumTitleLabel = Label(font: .heading(.lg))
        private let mediumLabel = Label(font: .heading(.xl))
        private let dateTitleLabel = Label(font: .heading(.lg))
        private let dateLabel = Label(font: .heading(.xl))
        private let departmentTitleLabel = Label(font: .heading(.lg))
        private let departmentLabel = Label(font: .heading(.xl))

        let contentStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = Spacing.xxs.rawValue
            view.layoutMargins = .init(
                top: Spacing.sm.rawValue,
                left: Spacing.md.rawValue,
                bottom: Spacing.sm.rawValue,
                right: Spacing.md.rawValue
            )
            view.isLayoutMarginsRelativeArrangement = true
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()

        let imageStackView: UIStackView = {
            let view = UIStackView()
            view.alignment = .center

            return view
        }()

        let labelsStackView: UIStackView = {
            let view = UIStackView()
            view.spacing = Spacing.zero.rawValue
            view.axis = .vertical

            return view
        }()

        // MARK: CodeView
        func setupSubviews() {
            imageStackView.addArrangedSubview(imageView)

            labelsStackView.addArrangedSubview(artistTitleLabel)
            labelsStackView.addArrangedSubview(artistLabel)
            labelsStackView.setCustomSpacing(Spacing.xxs.rawValue, after: artistLabel)
            labelsStackView.addArrangedSubview(mediumTitleLabel)
            labelsStackView.addArrangedSubview(mediumLabel)
            labelsStackView.setCustomSpacing(Spacing.xxs.rawValue, after: mediumLabel)
            labelsStackView.addArrangedSubview(dateTitleLabel)
            labelsStackView.addArrangedSubview(dateLabel)
            labelsStackView.setCustomSpacing(Spacing.xxs.rawValue, after: dateLabel)
            labelsStackView.addArrangedSubview(departmentTitleLabel)
            labelsStackView.addArrangedSubview(departmentLabel)

            contentStackView.addArrangedSubview(titleLabel)
            contentStackView.addArrangedSubview(imageStackView)
            contentStackView.addArrangedSubview(labelsStackView)

            scrollView.addSubview(contentStackView)
            addSubview(scrollView)
        }

        func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    imageView.heightAnchor.constraint(equalTo: widthAnchor),

                    contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

                    scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
                ]
            )
        }

        func setupAdditionalConfiguration() {
            backgroundColor = .systemRed
        }

        // MARK: Custom Methods
        func setup(with model: Model.Main.Object) {
            titleLabel.text = model.title
            imageView.load(url: URL(string: model.image))
            artistLabel.text = model.artist
            mediumLabel.text = model.medium
            dateLabel.text = model.date
            departmentLabel.text = model.department

            artistTitleLabel.text = Localization.Main.Detail.artistTitle
            mediumTitleLabel.text = Localization.Main.Detail.mediumTitle
            dateTitleLabel.text = Localization.Main.Detail.dateTitle
            departmentTitleLabel.text = Localization.Main.Detail.departmentTitle
        }
    }
}

#if DEBUG
extension Flow.Main.Detail.View {

    var testableTitleLabel: Label { titleLabel }
}
#endif
