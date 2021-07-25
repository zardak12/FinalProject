//
//  MockCoreDataService.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 25.07.2021.
//

import Foundation

class MockCoreDataService: CoreDataServiceProtocol {

    var stack: CoreDataStackProtocol

    init(stack: CoreDataStackProtocol) {
        self.stack = stack
    }

    func createLesson(with name: String) -> Bool {
        return true
    }

    func createWord(value: String, translate: String, lesson: Lesson, completion: @escaping (CoreDataWord) -> Void) {
    }

    func deleteLesson(with lesson: Lesson) {
    }

    func deleteWord(with word: Word) {
    }
}
