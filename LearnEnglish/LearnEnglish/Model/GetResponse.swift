//
//  GetResponse.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 26.06.2021.
//

import Foundation

// MARK: - GetResponce
struct GetResponce: Codable {
    let lessons: [Lessons]

    private enum CodingKeys: String, CodingKey {
        case lessons = "documents"
    }
}

// MARK: - Lessons

struct Lessons: Codable {
    let fields: Fields

    private enum CodingKeys: String, CodingKey {
        case fields
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fields = try container.decode(Fields.self, forKey: .fields)
    }
}

struct Fields: Codable {
    let words: Words
    var name: Name

    enum CodingKeys: String, CodingKey {
        case words
        case name
    }
}

// MARK: - Name

struct Name: Codable {
   var stringValue: String
}

// MARK: - Words

struct Words: Codable {
    let arrayValue: ArrayValue
}

// MARK: - ArrayValue

struct ArrayValue: Codable {
    let values: [Value]
}

// MARK: - Value

struct Value: Codable {
    let mapValue: MapValue
}

// MARK: - MapValue

struct MapValue: Codable {
    let fields: MapValueFields
}

// MARK: - MapValueFields

struct MapValueFields: Codable {
    let translate: Name
    let value: Name

}
