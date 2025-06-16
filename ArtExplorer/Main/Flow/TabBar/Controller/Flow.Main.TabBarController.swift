//
//  Flow.Main.TabBar.ViewController.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main {

    class TabBarController: UITabBarController {

        // MARK: Initializers
        init(coordinator: Coordinator.Main, worker: Worker.Main) {
            self.coordinator = coordinator
            self.worker = worker
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        unowned private var coordinator: Coordinator.Main
        private var worker: Worker.Main

        // MARK: View Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()

            configureTabAppearance()
            viewControllers = [createListTab(), createFavoritesTab()]
        }

        // MARK: Custom Methods
        private func configureTabAppearance() {
            let tabAppearance = UITabBarAppearance()
            tabAppearance.configureWithOpaqueBackground()
            tabAppearance.backgroundImage = UIImage()
            tabAppearance.backgroundColor = .systemRed

            tabAppearance.stackedLayoutAppearance.selected.iconColor = .systemYellow
            tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow
            ]

            tabAppearance.stackedLayoutAppearance.normal.iconColor = .white
            tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]

            UITabBar.appearance().standardAppearance = tabAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }

        private func createListTab() -> UIViewController {
            let viewModel = Flow.Main.TabBar.List.ViewModel(coordinator: coordinator, worker: worker)
            let viewController = Flow.Main.TabBar.List.ViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(
                title: Localization.Main.TabBar.List.tabTitle,
                image: Model.Core.SystemImage.list.image,
                tag: 0
            )

            return viewController
        }

        private func createFavoritesTab() -> UIViewController {
            let viewModel = Flow.Main.TabBar.Favorites.ViewModel(
                coordinator: coordinator,
                worker: worker,
                persistenceWorker: .init()
            )
            let viewController = Flow.Main.TabBar.Favorites.ViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(
                title: Localization.Main.TabBar.Favorites.tabTitle,
                image: Model.Core.SystemImage.favorite.image,
                tag: 1
            )

            return viewController
        }
    }
}
