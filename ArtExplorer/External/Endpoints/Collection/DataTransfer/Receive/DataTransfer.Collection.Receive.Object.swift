//
//  DataTransfer.Collection.Receive.Object.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

extension DataTransfer.Collection.Receive {

    struct Object: Decodable {

        let objectID: Int?
        let isHighlight: Bool?
        let accessionNumber: String?
        let accessionYear: String?
        let isPublicDomain: Bool?
        let primaryImage: String?
        let primaryImageSmall: String?
        let additionalImages: [String]?
        let constituents: [Constituent]?
        let department: String?
        let objectName: String?
        let title: String?
        let culture: String?
        let period: String?
        let dynasty: String?
        let reign: String?
        let portfolio: String?
        let artistRole: String?
        let artistPrefix: String?
        let artistDisplayName: String?
        let artistDisplayBio: String?
        let artistSuffix: String?
        let artistAlphaSort: String?
        let artistNationality: String?
        let artistBeginDate: String?
        let artistEndDate: String?
        let artistGender: String?
        let artistWikidata_URL: String?
        let artistULAN_URL: String?
        let objectDate: String?
        let objectBeginDate: Int?
        let objectEndDate: Int?
        let medium: String?
        let dimensions: String?
        let measurements: [Measurement]?
        let creditLine: String?
        let geographyType: String?
        let city: String?
        let state: String?
        let county: String?
        let country: String?
        let region: String?
        let subregion: String?
        let locale: String?
        let locus: String?
        let excavation: String?
        let river: String?
        let classification: String?
        let rightsAndReproduction: String?
        let linkResource: String?
        let metadataDate: String?
        let repository: String?
        let objectURL: String?
        let tags: [Tag]?
        let objectWikidata_URL: String?
        let isTimelineWork: Bool?
        let GalleryNumber: String?
    }
}

extension DataTransfer.Collection.Receive.Object {

    struct Constituent: Decodable {

        let constituentID: Int?
        let role: String?
        let name: String?
        let constituentUlanUrl: String?
        let constituentWikidataUrl: String?
        let gender: String?

        enum CodingKeys: String, CodingKey {

            case constituentID
            case role
            case name
            case constituentUlanUrl = "constituentULAN_URL"
            case constituentWikidataUrl = "constituentWikidata_URL"
            case gender
        }
    }
}

extension DataTransfer.Collection.Receive.Object {

    struct Measurement: Decodable {

        let elementName: String?
        let elementDescription: String?
        let elementMeasurements: ElementMeasurement?
    }

    struct ElementMeasurement: Decodable {

        let height: Double?
        let width: Double?
        let length: Double?
    }
}

extension DataTransfer.Collection.Receive.Object {

    struct Tag: Decodable {

        let term: String?
        let aatUrl: String?
        let wikidataUrl: String?

        enum CodingKeys: String, CodingKey {

            case term
            case aatUrl = "AAT_URL"
            case wikidataUrl = "Wikidata_URL"
        }
    }
}
