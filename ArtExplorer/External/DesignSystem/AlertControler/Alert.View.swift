//
//  Alert.View.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Alert {

    class View: UIView, CodeView {

        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupCodeView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Components
        let actionButton: UIButton = {
            let view = UIButton()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemRed
            view.layer.cornerRadius = 10
            view.titleLabel?.font = FontStyle.body(.lg).font

            return view
        }()
        private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 16
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.white.cgColor

            return view
        }()
        private let titleLabel = Label(font: .heading(.lg))
        private let messageLabel = Label(font: .body(.lg))

        // MARK: Code View
        func setupSubviews() {
            containerView.addSubview(titleLabel)
            containerView.addSubview(messageLabel)
            containerView.addSubview(actionButton)

            addSubview(containerView)

        }

        func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.md.rawValue),
                    titleLabel.leadingAnchor.constraint(
                        equalTo: containerView.leadingAnchor,
                        constant: Spacing.md.rawValue
                    ),
                    titleLabel.trailingAnchor.constraint(
                        equalTo: containerView.trailingAnchor,
                        constant: -Spacing.md.rawValue
                    ),

                    messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.xxs.rawValue),
                    messageLabel.leadingAnchor.constraint(
                        equalTo: containerView.leadingAnchor,
                        constant: Spacing.md.rawValue
                    ),
                    messageLabel.trailingAnchor.constraint(
                        equalTo: containerView.trailingAnchor,
                        constant: -Spacing.md.rawValue
                    ),

                    actionButton.topAnchor.constraint(
                        equalTo: messageLabel.bottomAnchor,
                        constant: Spacing.xxs.rawValue
                    ),
                    actionButton.leadingAnchor.constraint(
                        equalTo: containerView.leadingAnchor,
                        constant: Spacing.md.rawValue
                    ),
                    actionButton.trailingAnchor.constraint(
                        equalTo: containerView.trailingAnchor,
                        constant: -Spacing.md.rawValue
                    ),
                    actionButton.bottomAnchor.constraint(
                        equalTo: containerView.bottomAnchor,
                        constant: -Spacing.md.rawValue
                    ),

                    containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    containerView.widthAnchor.constraint(equalToConstant: 280),
                    containerView.heightAnchor.constraint(equalToConstant: 220)
                ]
            )
        }

        func setupAdditionalConfiguration() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
        }

        // MARK: Custom Methods
        func setup(for title: String?, message: String, buttonTitle: String?) {
            titleLabel.text = title ?? Localization.DesignSystem.alertControllerTitle
            messageLabel.text = message
            actionButton.setTitle(buttonTitle ?? Localization.DesignSystem.alertControllerActionButton, for: .normal)
        }
    }
}
