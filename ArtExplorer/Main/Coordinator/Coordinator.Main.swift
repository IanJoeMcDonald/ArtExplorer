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

            case detail(objectId: Int)
            case error(title: String? = nil, message: String, buttonTitle: String? = nil)
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
            case let .detail(objectId):
                let viewModel = Flow.Main.Detail.ViewModel(
                    objectId: objectId,
                    coordinator: self,
                    worker: worker,
                    persistenceWorker: .init()
                )
                let viewController = Flow.Main.Detail.ViewController(viewModel: viewModel)
                navigationController.pushViewController(viewController, animated: true)
            case let .error(title, message, buttonTitle):
                let viewController = Alert.ViewController(title: title, message: message, buttonTitle: buttonTitle)
                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = .crossDissolve
                navigationController.present(viewController, animated: true)
            case .main:
                let viewController = Flow.Main.TabBarController(coordinator: self, worker: worker)
                navigationController.pushViewController(viewController, animated: true)
            case .pop:
                navigationController.popViewController(animated: true)
            }
        }
    }
}
