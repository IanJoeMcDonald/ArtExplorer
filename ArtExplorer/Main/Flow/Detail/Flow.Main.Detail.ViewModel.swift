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
        init(objectId: Int, coordinator: Coordinator.Main, worker: Worker.Main, persistenceWorker: Worker.Main.Persistence) {
            self.coordinator = coordinator
            self.worker = worker
            self.persistenceWorker = persistenceWorker
            self.objectId = objectId
        }

        // MARK: Properties
        @Published private var state: State = .initial
        var statePublisher: Published<State>.Publisher { $state }

        weak private var coordinator: Coordinator.Main?
        private var worker: Worker.Main
        private let persistenceWorker: Worker.Main.Persistence
        private let objectId: Int
        private var object: Model.Main.Object?

        // MARK: Custom Methods
        func fetchInformation() {
            state = .isLoading(true)
            Task {
                if let object = try? persistenceWorker.isFavorite(objectId) {
                    self.object = object
                    await updateUI(with: object, isFavorite: true)
                    return
                }

                do {
                    let object = try await worker.fetchObject(for: String(objectId))
                    self.object = object
                    await updateUI(with: object, isFavorite: false)
                } catch let error {
                    await MainActor.run {
                        state = .isLoading(false)
                        coordinator?.trigger(.error(message: error.localizedDescription))
                        coordinator?.trigger(.pop)
                    }
                }
            }
        }

        func toggleFavoriteStatus() {
            guard let object else { return }
            let status = persistenceWorker.toggleFavoriteStatus(object)
            state = .isFavorite(status)
        }

        func backButtonPressed() {
            coordinator?.trigger(.pop)
        }

        // MARK: Private Custom Methods
        private func updateUI(with object: Model.Main.Object, isFavorite: Bool) async {
            await MainActor.run {
                state = .setup(with: object)
                state = .isFavorite(isFavorite)
                state = .isLoading(false)
            }
        }
    }
}

extension Flow.Main.Detail {

    enum State: Equatable {
        case initial
        case isFavorite(Bool)
        case isLoading(Bool)
        case setup(with: Model.Main.Object)
    }
}
