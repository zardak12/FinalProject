//
//  LessonDTO.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 22.07.2021.
//

import Foundation

struct LessonDTO: Codable, Equatable {
    let name: String?
    let words: [WordDTO]?
}
