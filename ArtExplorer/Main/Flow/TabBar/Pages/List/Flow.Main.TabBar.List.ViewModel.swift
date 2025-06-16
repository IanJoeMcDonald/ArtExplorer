//
//  Flow.Main.TabBar.List.ViewModel.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.List {

    class ViewModel {

        // MARK: Initializers
        init(coordinator: Coordinator.Main, worker: Worker.Main) {
            self.coordinator = coordinator
            self.worker = worker
        }

        // MARK: Properties
        @Published private(set) var state: State = .initial

        weak private var coordinator: Coordinator.Main?
        private var worker: Worker.Main
        private var objectList: Model.Main.SearchResults?
        private var loadedListIds = [Int]()
        private var page = 0
        private var isLoadingMoreObjects = false

        // MARK: Custom Methods
        func fetchInformation() {
            state = .isLoading(true)
            Task {
                do {
                    objectList = try await worker.fetchSearchResults(for: .init(query: "painting", hasImages: true))
                    fetchMoreObjects()
                } catch let error {
                    await MainActor.run {
                        state = .isLoading(false)
                        coordinator?.trigger(.error(message: error.localizedDescription))
                    }
                }
            }
        }

        func fetchMoreObjects() {
            guard !isLoadingMoreObjects else { return }
            Task {
                await MainActor.run {
                    state = .isLoading(true)
                }
                isLoadingMoreObjects = true
                let startIndex = page * 15
                let endIndex = (page + 1) * 15
                let newIds = objectList?.itemIds[safeIndexes: startIndex ..< endIndex] ?? []
                guard !newIds.isEmpty else { return }
                loadedListIds.append(contentsOf: newIds)
                var objects = [Model.Main.Object]()
                for id in newIds {
                    if let object = try? await worker.fetchObject(for: String(id)) {
                        objects.append(object)
                    }
                }
                let viewObjects: [Model.Main.TabBar.List.ViewInformation.Object] = objects.map { .init(from: $0) }
                page += 1
                isLoadingMoreObjects = false
                await MainActor.run {
                    state = .isLoading(false)
                    state = .updateObjects(with: viewObjects)
                }
            }
        }

        func showObject(_ object: Model.Main.TabBar.List.ViewInformation.Object) {
            coordinator?.trigger(.detail(objectId: object.id))
        }
    }
}

extension Flow.Main.TabBar.List {

    enum State {

        case initial
        case isLoading(Bool)
        case updateObjects(with: [Model.Main.TabBar.List.ViewInformation.Object])
    }
}

extension Collection {

    private subscript (safeIndex index: Index) -> Element? {
        if indices.contains(index) { self[index] } else { nil }
    }
    subscript(safeIndexes indexArray: CountableRange<Int>) -> [Element] {
        indexArray.compactMap { $0 as? Index }.compactMap { self[safeIndex: $0] }
    }
}
