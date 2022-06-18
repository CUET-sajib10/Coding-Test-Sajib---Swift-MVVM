//
//  SearchResponseModel.swift
//  Coding Test Sajib
//
//  Created by MacBook Pro on 18/6/22.
//

import Foundation

// MARK: - Welcome
struct SearchResponseModel: Codable {
    let status, copyright: String
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let docs: [Doc]
    let meta: Meta
}

// MARK: - Doc
struct Doc: Codable {
    let abstract: String
    let webURL: String
    let snippet, leadParagraph: String
    let printSection, printPage: String?
    let source: Source? = nil
    let multimedia: [Multimedia]
    let headline: Headline
    let keywords: [Keyword]
    let pubDate: String
    let documentType: DocumentType
    let newsDesk: NewsDesk
    let sectionName: SectionName
    let subsectionName: SubsectionName
    let byline: Byline
    let typeOfMaterial: TypeOfMaterial
    let id: String
    let wordCount: Int
    let uri: String

    enum CodingKeys: String, CodingKey {
        case abstract
        case webURL = "web_url"
        case snippet
        case leadParagraph = "lead_paragraph"
        case printSection = "print_section"
        case printPage = "print_page"
        case source, multimedia, headline, keywords
        case pubDate = "pub_date"
        case documentType = "document_type"
        case newsDesk = "news_desk"
        case sectionName = "section_name"
        case subsectionName = "subsection_name"
        case byline
        case typeOfMaterial = "type_of_material"
        case id = "_id"
        case wordCount = "word_count"
        case uri
    }
}

// MARK: - Byline
struct Byline: Codable {
    let original: Original
    let person: [Person]
    let organization: String?
}

enum Original: String, Codable {
    case byJonathanWeisman = "By Jonathan Weisman"
    case byMarkLandler = "By Mark Landler"
    case byVictoriaKim = "By Victoria Kim"
}

// MARK: - Person
struct Person: Codable {
    let firstname: Firstname
    let middlename: String?
    let lastname: Lastname
    let qualifier, title: String?
    let role: Role
    let organization: String
    let rank: Int
}

enum Firstname: String, Codable {
    case jonathan = "Jonathan"
    case mark = "Mark"
    case victoria = "Victoria"
}

enum Lastname: String, Codable {
    case kim = "Kim"
    case landler = "Landler"
    case weisman = "Weisman"
}

enum Role: String, Codable {
    case reported = "reported"
}

enum DocumentType: String, Codable {
    case article = "article"
}

// MARK: - Headline
struct Headline: Codable {
    let main: String
    let kicker: String?
    let contentKicker: String?
    let printHeadline: String?
    let name, seo, sub: String?

    enum CodingKeys: String, CodingKey {
        case main, kicker
        case contentKicker = "content_kicker"
        case printHeadline = "print_headline"
        case name, seo, sub
    }
}

// MARK: - Keyword
struct Keyword: Codable {
    let name: Name
    let value: String
    let rank: Int
    let major: Major
}

enum Major: String, Codable {
    case n = "N"
}

enum Name: String, Codable {
    case glocations = "glocations"
    case organizations = "organizations"
    case persons = "persons"
    case subject = "subject"
}

// MARK: - Multimedia
struct Multimedia: Codable {
    let rank: Int
    let subtype: String
    let caption, credit: String?
    let type: TypeEnum
    let url: String
    let height, width: Int
    let legacy: Legacy
    let subType, cropName: String

    enum CodingKeys: String, CodingKey {
        case rank, subtype, caption, credit, type, url, height, width, legacy, subType
        case cropName = "crop_name"
    }
}

// MARK: - Legacy
struct Legacy: Codable {
    let xlarge: String?
    let xlargewidth, xlargeheight: Int?
    let thumbnail: String?
    let thumbnailwidth, thumbnailheight, widewidth, wideheight: Int?
    let wide: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
}

enum NewsDesk: String, Codable {
    case foreign = "Foreign"
    case politics = "Politics"
    case washington = "Washington"
}

enum SectionName: String, Codable {
    case uS = "U.S."
    case world = "World"
}

//enum Source: String, Codable {
//    case theNewYorkTimes = "The New York Times"
//}

enum SubsectionName: String, Codable {
    case australia = "Australia"
    case europe = "Europe"
    case politics = "Politics"
}

enum TypeOfMaterial: String, Codable {
    case news = "News"
}

// MARK: - Meta
struct Meta: Codable {
    let hits, offset, time: Int
}

// MARK: - Encode/decode helpers
