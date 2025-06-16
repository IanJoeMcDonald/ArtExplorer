//
//  Worker.Main.Persistence.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Foundation

extension Worker.Main {

    class Persistence {

        // MARK: Initializer
        init(defaults: UserDefaults = UserDefaults.standard) {
            self.defaults = defaults
        }

        // MARK: Error
        enum PersistenceWorkerError: Error {

            case objectNotFound
            case persistenceError
            case unknownError
        }

        // MARK: Properties
        let defaults: UserDefaults

        // MARK: Custom Methods
        func fetchFavorites() throws -> [Model.Main.Object] {
            do {
                let objects: [Model.Main.Object] = try PersistenceManager.retrieve(
                    forKey: .favorite,
                    defaults: defaults
                )
                return objects
            } catch let error as PersistenceError {
                switch error {
                case .valueNotFound: return []
                default: throw PersistenceWorkerError.persistenceError
                }
            } catch {
                throw PersistenceWorkerError.unknownError
            }
        }

        func isFavorite(_ id: Int) throws -> Model.Main.Object {
            do {
                let objects: [Model.Main.Object] = try fetchFavorites()
                guard let object = objects.first(where: { $0.id == id }) else {
                    throw PersistenceWorkerError.objectNotFound
                }
                return object
            } catch {
                throw PersistenceWorkerError.objectNotFound
            }
        }

        func toggleFavoriteStatus(_ object: Model.Main.Object) -> Bool {
            let objects: [Model.Main.Object]? = try? fetchFavorites()
            if (objects ?? []).contains(where: { $0.id == object.id }) {
                do {
                    try removeFromFavorites(object.id)
                    return false
                } catch {
                    return true
                }
            } else {
                do {
                    try addToFavorites(object)
                    return true
                } catch {
                    return false
                }
            }
        }

        // MARK: Private Custom Methods
        private func addToFavorites(_ object: Model.Main.Object) throws {
            do {
                var objects: [Model.Main.Object] = try fetchFavorites()
                if objects.contains(where: { $0.id == object.id }) { return }
                objects.append(object)
                try PersistenceManager.save(value: objects, forKey: .favorite, defaults: defaults)
            } catch _ as PersistenceError {
                throw PersistenceWorkerError.persistenceError
            } catch {
                throw PersistenceWorkerError.unknownError
            }
        }

        private func removeFromFavorites(_ id: Int) throws {
            do {
                var objects: [Model.Main.Object] = try fetchFavorites()
                objects.removeAll(where: { $0.id == id })
                try PersistenceManager.save(value: objects, forKey: .favorite, defaults: defaults)
            } catch _ as PersistenceError {
                throw PersistenceWorkerError.persistenceError
            } catch {
                throw PersistenceWorkerError.unknownError
            }
        }
    }
}
