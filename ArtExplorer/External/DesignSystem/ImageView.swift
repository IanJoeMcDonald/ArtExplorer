//
//  ImageView.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension UIImageView {

    func load(url: URL?, placeholder: UIImage = Model.Core.NamedImage.placeholder.image, cache: URLCache? = nil) {
        guard let url = url else {
            self.image = placeholder
            return
        }
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            Task {
                if
                    let (data, response) = try? await URLSession.shared.data(for: request),
                    let image = UIImage(data: data)
                {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    await MainActor.run {
                        self.image = image
                    }
                }
            }
        }
    }
}
