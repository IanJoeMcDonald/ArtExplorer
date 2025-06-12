//
//  Coordinator.Main.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//
import UIKit

extension Coordinator {

    class Main: CoordinatorProtocol {

        // MARK: Initializers
        init(navigationController: UINavigationController, worker: Worker.Main = .init()) {
            self.navigationController = navigationController
            self.worker = worker
        }

        // MARK: Route
        enum Route: CoordinatorRoute {

            case detail
            case main(animated: Bool = true)
            case pop
        }

        // MARK: Properties
        var childCoordinators = [CoordinatorProtocol]()
        var navigationController: UINavigationController
        let worker: Worker.Main

        // MARK: Functions
        func start() {
            trigger(.main(animated: false))
        }

        func trigger(_ route: Route) {
            switch route {
            case .detail:
                let viewModel = Flow.Main.Detail.ViewModel(coordinator: self, worker: worker)
                let viewController = Flow.Main.Detail.ViewController(viewModel: viewModel)
                navigationController.pushViewController(viewController, animated: true)
            case .main:
                let viewController = Flow.Main.TabBarController(coordinator: self, worker: worker)
                navigationController.pushViewController(viewController, animated: true)
            case .pop:
                navigationController.popViewController(animated: true)
            }
        }
    }
}
