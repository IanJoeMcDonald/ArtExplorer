//
//  Flow.Main.Detail.ViewModelSpy.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 13/06/25.
//

import Combine
@testable import ArtExplorer

extension Flow.Main.Detail.ViewModel {

    class Spy: Flow.Main.Detail.ViewModel {

        init(objectId: Int) {
            super.init(
                objectId: objectId,
                coordinator: .init(navigationController: .init()),
                worker: .init(),
                persistenceWorker: .init()
            )
        }

        struct MethodSpy {

            var fetchInformationCalledCount = 0
            var toggleFavoriteStatusCalledCount = 0
            var backButtonPressedCalledCount = 0
        }

        var methodSpy = MethodSpy()

        override var statePublisher: Published<Flow.Main.Detail.State>.Publisher { $state }
        @Published var state: Flow.Main.Detail.State = .initial

        override func fetchInformation() {
            methodSpy.fetchInformationCalledCount += 1
        }

        override func toggleFavoriteStatus() {
            methodSpy.toggleFavoriteStatusCalledCount += 1
        }

        override func backButtonPressed() {
            methodSpy.backButtonPressedCalledCount += 1
        }
    }
}
