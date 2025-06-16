//
//  Flow.Main.Detail.ViewController.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Combine
import UIKit

extension Flow.Main.Detail {

    class ViewController: UIViewController {

        // MARK: Initializers
        init(viewModel: ViewModel) {
            self.viewModel = viewModel

            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        private let customView = View()
        private let viewModel: ViewModel
        private var cancellable: AnyCancellable?

        // MARK: View Life Cycle
        override func loadView() {
            view = customView
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            setupCancellable()
            setupBackButton()
            viewModel.fetchInformation()
        }

        // MARK: Private Custom Methods
        private func setupCancellable() {
            cancellable = viewModel.statePublisher.sink { [weak self] state in self?.handleState(state) }
        }

        private func setupBackButton() {
            let button = UIBarButtonItem(
                image: Model.Core.SystemImage.backButton.image,
                style: .plain,
                target: self,
                action: #selector(backButtonPressed)
            )
            button.tintColor = .white

            navigationItem.leftBarButtonItem = button
            navigationItem.hidesBackButton = true
        }

        private func updateFavoriteState(to state: Bool) {
            let image = if state {
                Model.Core.SystemImage.favoriteFill.image
            } else {
                Model.Core.SystemImage.favorite.image
            }

            let button = UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: #selector(favoriteButtonPressed)
            )
            button.tintColor = .white

            navigationItem.rightBarButtonItem = button
        }

        private func handleState(_ state: State) {
            switch state {
            case .initial: break
            case let .isFavorite(state):
                updateFavoriteState(to: state)
            case let .isLoading(state):
                customView.isLoading(state)
            case let .setup(with: model):
                customView.setup(with: model)
            }
        }

        // MARK: Actions
        @objc
        func favoriteButtonPressed() {
            viewModel.toggleFavoriteStatus()
        }

        @objc
        func backButtonPressed() {
            viewModel.backButtonPressed()
        }
    }
}

#if DEBUG
extension Flow.Main.Detail.ViewController {

    var testableView: Flow.Main.Detail.View { customView }
}
#endif
