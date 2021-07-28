//
//  CoreDataServiceProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 26.07.2021.
//

import Foundation

typealias CoreDataWord = Result<Word, CoreDataError>

// MARK: - CoreDataServiceProtocol
protocol CoreDataServiceProtocol {

    var stack: CoreDataStackProtocol { get set }

    /// Create Lesson
    /// - Parameter name: name of the Lesson
    func createLesson(with name: String) -> Bool

    /// Create Word
    /// - Parameters:
    ///   - value: Value of the word
    ///   - translate: Translate of the word
    ///   - lesson: The theme of the words
    ///   - completion: Handler with result of the resoonce CoreDataWord

    func createWord(value: String, translate: String, lesson: Lesson, completion: @escaping (CoreDataWord) -> Void)
    /// Delete Lesson
    /// - Parameter lesson: Lesson Entity

    func deleteLesson(with lesson: Lesson)

    /// Delete Word
    /// - Parameter word: Word Entity
    func deleteWord(with word: Word)
}
