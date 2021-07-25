//
//  CoreDataService.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 23.07.2021.
//

import Foundation
import CoreData

typealias CoreDataWord = Result<Word, CoreDataError>

  // MARK: - CoreDataServiceProtocol
protocol CoreDataServiceProtocol {
    var stack: CoreDataStackProtocol { get set }
    func createLesson(with name: String) -> Bool
    func createWord(value: String, translate: String, lesson: Lesson, completion: @escaping (CoreDataWord) -> Void)
    func deleteLesson(with lesson: Lesson)
    func deleteWord(with word: Word)
}

  // MARK: - CoreDataService
final class CoreDataService: CoreDataServiceProtocol {
    var stack: CoreDataStackProtocol

      // MARK: - Init
    init(stack: CoreDataStackProtocol) {
        self.stack = stack
    }

      // MARK: - Create Entity
    func createLesson(with name: String) -> Bool {
        var result = false
        let context = stack.writeContext
        context.performAndWait {
            if (try? fetchRequestAddLesson(with: name).execute().first) == nil {
                let lesson = Lesson(context: context)
                lesson.name = name
                result = true
            }
        }
        try? context.save()
        return result
    }

    func createWord(value: String, translate: String, lesson: Lesson, completion: @escaping (CoreDataWord) -> Void) {
        let context = stack.writeContext
        context.performAndWait {
            if (try? fetchRequestAddWord(with: value).execute().first) == nil {
                let word = Word(context: context)
                word.value = value
                word.translate = translate
                guard let name = lesson.name else { return }
                if let lesson = try? fetchRequestAddLesson(with: name).execute().first {
                    lesson.addToWords(word)
                }
                completion(.success(word))
            } else {
                completion(.failure(.exist))
            }
        }
        try? context.save()
    }

      // MARK: - Delete Entity
    func deleteLesson(with lesson: Lesson) {
        let context = stack.writeContext
        context.performAndWait {
            if let lesson = try? fetchRequestDeleteLesson(with: lesson).execute().first {
                context.delete(lesson)
            }
        }
        try? context.save()

    }

    func deleteWord(with word: Word) {
        let context = stack.writeContext
        context.performAndWait {
            if let word = try? fetchRequestDeleteWord(with: word).execute().first {
                context.delete(word)
            }
        }
        try? context.save()
    }
}

private extension CoreDataService {

      // MARK: - Lesson FetchRequest
    private func fetchRequestAddLesson(with name: String) -> NSFetchRequest<Lesson> {
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        return request
    }

    private func fetchRequestDeleteLesson(with lesson: Lesson) -> NSFetchRequest<Lesson> {
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        guard let name = lesson.name else {
            fatalError("CoreData Error")
        }
        request.predicate = NSPredicate(format: "name == %@", name)
        return request
    }

      // MARK: - Word FetchRequest
    private func fetchRequestAddWord(with value: String) -> NSFetchRequest<Word> {
        let request = NSFetchRequest<Word>(entityName: "Word")
        request.predicate = NSPredicate(format: "value == %@", value)
        return request
    }

    private func fetchRequestDeleteWord(with word: Word) -> NSFetchRequest<Word> {
        let request = NSFetchRequest<Word>(entityName: "Word")
        guard let value = word.value else {
            fatalError("CoreData Error")
        }
        request.predicate = NSPredicate(format: "value == %@", value)
        return request
    }
}
