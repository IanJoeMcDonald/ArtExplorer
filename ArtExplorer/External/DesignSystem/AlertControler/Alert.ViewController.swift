//
//  Alert.ViewController.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Alert {

    class ViewController: UIViewController {

        // MARK: Initializers
        init(title: String? = nil, message: String, buttonTitle: String? = nil) {
            self.alertTitle = title
            self.message = message
            self.buttonTitle = buttonTitle
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        private let customView = Alert.View()
        private let alertTitle: String?
        private let message: String
        private let buttonTitle: String?

        // MARK: View Lifecycle
        override func loadView() {
            view = customView
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            customView.setup(for: alertTitle, message: message, buttonTitle: buttonTitle)
            customView.actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        }

        // MARK: Actions
        @objc
        private func dismissViewController() {
            dismiss(animated: true)
        }
    }
}
