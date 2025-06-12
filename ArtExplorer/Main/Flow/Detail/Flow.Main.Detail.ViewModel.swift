//
//  Flow.Main.Detail.ViewModel.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.Detail {

    class ViewModel {

        // MARK: Initializers
        init(coordinator: Coordinator.Main, worker: Worker.Main) {
            self.coordinator = coordinator
            self.worker = worker
        }

        // MARK: Properties
        weak private var coordinator: Coordinator.Main?
        private var worker: Worker.Main
    }
}
