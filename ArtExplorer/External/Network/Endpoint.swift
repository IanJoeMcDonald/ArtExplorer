//
//  Endpoint.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Foundation

protocol Endpoint {

    var path: String { get }
    var queryItems: [String: String] { get }
    var method: URLMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var forceUpdate: Bool { get }

    func createURL() throws -> URL
}

extension Endpoint {

    var queryItems: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Data? { nil }
    var forceUpdate: Bool { false }

    func createURL() throws -> URL {
        var urlComponents = URLComponents(string: self.path)
        urlComponents?.queryItems = self.queryItems.map { key, value in URLQueryItem(name: key, value: value) }
        guard let url = urlComponents?.url else { throw URLError(.badURL) }
        return url
    }
}
