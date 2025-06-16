//
//  Worker.Main.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension Worker {

    class Main {

        // MARK: Initializer
        init(collectionRepository: Repository.Collection = Repository.Collection()) {
            self.collectionRepository = collectionRepository
        }

        // MARK: Error
        enum WorkerError: Error {
            case invalidModel
        }

        // MARK: Repositories
        private let collectionRepository: Repository.Collection

        // MARK: Custom Methods
        func fetchObject(for objectID: String) async throws -> Model.Main.Object {
            let request = Request.Collection.Objects(objectID: objectID)

            let data = try await collectionRepository.fetchObject(request)
            guard let model = Model.Main.Object(from: data) else {
                throw WorkerError.invalidModel
            }

            return model
        }

        func fetchSearchResults(
            for searchParameters: Model.Main.SearchParameters
        ) async throws -> Model.Main.SearchResults {
            let request = Request.Collection.Search(searchParameters: searchParameters.toDTO())

            let data = try await collectionRepository.fetchSearchResults(request)
            let model = Model.Main.SearchResults(from: data)

            return model
        }
    }
}
