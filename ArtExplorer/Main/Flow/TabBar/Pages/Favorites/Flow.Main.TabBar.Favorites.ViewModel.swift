//
//  Flow.Main.TabBar.Favorites.ViewModel.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.Favorites {

    class ViewModel {

        // MARK: Initializers
        init(coordinator: Coordinator.Main, worker: Worker.Main, persistenceWorker: Worker.Main.Persistence) {
            self.coordinator = coordinator
            self.worker = worker
            self.persistenceWorker = persistenceWorker
        }

        // MARK: Properties
        @Published private(set) var state: State = .initial

        weak private var coordinator: Coordinator.Main?
        private var worker: Worker.Main
        private var persistenceWorker: Worker.Main.Persistence

        // MARK: Custom Methods
        func fetchInformation() {
            state = .updateCollectionViewState(to: .isLoading)
            Task {
                do {
                    let favorites = try persistenceWorker.fetchFavorites()
                    await MainActor.run {
                        if favorites.isEmpty {
                            state = .updateCollectionViewState(to: .isEmpty)
                        } else {
                            state = .updateCollectionViewState(to: .setup(with: favorites))
                        }
                    }
                } catch {
                    await MainActor.run {
                        state = .updateCollectionViewState(to: .isEmpty)
                    }
                }
            }
        }

        func showObject(_ object: Model.Main.Object) {
            coordinator?.trigger(.detail(objectId: object.id))
        }
    }
}

extension Flow.Main.TabBar.Favorites {

    enum State {

        case initial
        case updateCollectionViewState(to: Model.Main.TabBar.Favorites.ViewInformation.CollectionViewState)
    }
}
