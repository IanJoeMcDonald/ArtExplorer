//
//  Worker.Main.Persistence.Mock.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 13/06/25.
//

import Foundation
@testable import ArtExplorer

extension Worker.Main.Persistence {

    final class Mock: Worker.Main.Persistence {

        init(favorite: Model.Main.Object? = nil) {
            super.init(defaults: UserDefaults())
            self.favorite = favorite
        }

        var error: Error?
        var favorite: Model.Main.Object?

        override func fetchFavorites() throws -> [Model.Main.Object] {
            if let error {
                throw error
            }

            if let favorite {
                return [favorite]
            } else {
                return []
            }
        }

        override func isFavorite(_ id: Int) throws -> Model.Main.Object {
            if let error {
                throw error
            }

            if let favorite, favorite.id == id {
                return favorite
            } else {
                throw PersistenceWorkerError.objectNotFound
            }
        }

        override func toggleFavoriteStatus(_ object: Model.Main.Object) -> Bool {
            if let favorite, favorite.id == object.id {
                self.favorite = nil
                return false
            } else {
                favorite = object
                return true
            }
        }
    }
}
