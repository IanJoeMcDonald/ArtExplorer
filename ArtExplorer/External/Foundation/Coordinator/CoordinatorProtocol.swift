//
//  CoordinatorProtocol.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

protocol CoordinatorProtocol {

    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

protocol CoordinatorRoute { }
