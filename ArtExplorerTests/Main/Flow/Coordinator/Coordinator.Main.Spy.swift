//
//  Coordinator.Main.Spy.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 13/06/25.
//

@testable import ArtExplorer

extension Coordinator.Main {

    final class Spy: Coordinator.Main {

        init() {
            super.init(navigationController: .init())
        }

        var lastTriggeredRoute: Coordinator.Main.Route?

        override func trigger(_ route: Coordinator.Main.Route) {
            self.lastTriggeredRoute = route
        }

        func lastTriggeredRouteIsEqual(to route: Coordinator.Main.Route) -> Bool {
            lastTriggeredRoute == route
        }
    }
}
