//
//  NetworkManager.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Foundation

class NetworkManager {

    // MARK: Initializers
    init(urlCache: URLCache = .shared) {
        self.urlCache = urlCache
    }

    // MARK: Properties
    private let urlCache: URLCache

    // MARK: Custom Methods
    func request<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        do {
            // Create Request
            let request = try createURLRequest(for: endpoint)

            // Verify if available in Cache
            if let cachedData: T = try? verifyCache(for: request, endpoint: endpoint) {
                return cachedData
            }

            // Perform Request
            let (data, response) = try await URLSession.shared.data(for: request)

            // Validate Response
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkingError.invalidStatusCode(statusCode: -1)
            }

            guard (200...299).contains(statusCode) else {
                throw NetworkingError.invalidStatusCode(statusCode: statusCode)
            }

            updateCache(for: request, response: response, data: data, endpoint: endpoint)

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw NetworkingError.decodingFailed(innerError: error)
        } catch let error as EncodingError {
            throw NetworkingError.encodingFailed(innerError: error)
        } catch let error as URLError {
            throw NetworkingError.requestFailed(innerError: error)
        } catch {
            throw NetworkingError.otherError(innerError: error)
        }
    }

    // MARK: Private Custom Methods
    private func createURLRequest(for endpoint: Endpoint) throws -> URLRequest {
        let validURL = try endpoint.createURL()

        var request = URLRequest(url: validURL)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        endpoint.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    private func verifyCache<T>(for request: URLRequest, endpoint: Endpoint) throws -> T where T: Decodable {
        guard endpoint.method == .get else {
            throw CacheError.invalidMethod(methodType: endpoint.method)
        }

        guard !endpoint.forceUpdate else {
            throw CacheError.forceUpdateRequested
        }

        guard let cachedResponse = urlCache.cachedResponse(for: request) else {
            throw CacheError.cachedValueNotFound
        }

        return try JSONDecoder().decode(T.self, from: cachedResponse.data)
    }

    private func updateCache(for request: URLRequest, response: URLResponse, data: Data, endpoint: Endpoint) {
        guard endpoint.method == .get else {
            return
        }

        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: request)
    }
}
