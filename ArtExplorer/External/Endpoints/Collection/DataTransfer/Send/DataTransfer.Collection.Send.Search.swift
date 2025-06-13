//
//  DataTransfer.Collection.Send.Search.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension DataTransfer.Collection.Send {

    struct Search: Encodable {

        init(
            query: String? = nil,
            isHighlight: Bool? = nil,
            title: Bool? = nil,
            tags: Bool? = nil,
            departmentId: Int? = nil,
            isOnView: Bool? = nil,
            artistOrCulture: Bool? = nil,
            medium: String? = nil,
            hasImages: Bool? = nil,
            geoLocation: String? = nil,
            dateBegin: Int? = nil,
            dateEnd: Int? = nil
        ) {
            self.query = query
            self.isHighlight = isHighlight
            self.title = title
            self.tags = tags
            self.departmentId = departmentId
            self.isOnView = isOnView
            self.artistOrCulture = artistOrCulture
            self.medium = medium
            self.hasImages = hasImages
            self.geoLocation = geoLocation
            self.dateBegin = dateBegin
            self.dateEnd = dateEnd
        }

        public let query: String?
        public let isHighlight: Bool?
        public let title: Bool?
        public let tags: Bool?
        public let departmentId: Int?
        public let isOnView: Bool?
        public let artistOrCulture: Bool?
        public let medium: String?
        public let hasImages: Bool?
        public let geoLocation: String?
        public let dateBegin: Int?
        public let dateEnd: Int?

        func createQueryItems() -> [String: String] {
            var queryItems = [String: String]()

            if let query = query {
                queryItems["q"] = query
            }
            
            if let isHighlight = isHighlight {
                queryItems["isHighlight"] = isHighlight ? "true" : "false"
            }
            
            if let title = title {
                queryItems["title"] = title ? "true" : "false"
            }

            if let tags = tags {
                queryItems["tags"] = tags ? "true" : "false"
            }

            if let departmentId = departmentId {
                queryItems["departmentId"] = String(departmentId)
            }

            if let isOnView = isOnView {
                queryItems["isOnView"] = isOnView ? "true" : "false"
            }

            if let artistOrCulture = artistOrCulture {
                queryItems["artistOrCulture"] = artistOrCulture ? "true" : "false"
            }

            if let medium = medium {
                queryItems["medium"] = medium
            }

            if let hasImages = hasImages {
                queryItems["hasImages"] = hasImages ? "true" : "false"
            }
            
            if let geoLocation = geoLocation {
                queryItems["geoLocation"] = geoLocation
            }
            
            if
                let dateBegin = dateBegin,
                let dateEnd = dateEnd
            {
                queryItems["dateBegin"] = String(dateBegin)
                queryItems["dateEnd"] = String(dateEnd)
            }

            return queryItems
        }
    }
}
