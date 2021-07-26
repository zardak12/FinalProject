//
//  CoreDataServiceTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 25.07.2021.
//

import XCTest
import CoreData

class CoreDataServiceTest: XCTestCase {

    var sut: CoreDataServiceProtocol!
    var stack = MockCoreDataStack()

    override func setUp() {
        super.setUp()
        sut = CoreDataService(stack: stack)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testAddLesson() {
        let result = sut.createLesson(with: "Test")
        XCTAssertTrue(result)
        let fetchRequest = NSFetchRequest<Lesson>(entityName: "Lesson")
        let objects = try? stack.readContext.fetch(fetchRequest)
        XCTAssertEqual(objects?.count, 1)
        XCTAssertEqual(objects?[0].name, "Test")
        deleteAllLesson()
    }

    func testDeleteLesson() {
        let result = sut.createLesson(with: "Test")
        XCTAssertTrue(result)
        let fetchRequest = NSFetchRequest<Lesson>(entityName: "Lesson")
        let objects = try? stack.readContext.fetch(fetchRequest)
        XCTAssertEqual(objects?.count, 1)
        XCTAssertEqual(objects?[0].name, "Test")
        sut.deleteLesson(with: objects![0])
        let secondFetch = try? stack.writeContext.fetch(fetchRequest)
        XCTAssertEqual(secondFetch?.count, 0)
    }

    func testDeleteWord() {
        let word = Word(context: stack.writeContext)
        let lesson = Lesson(context: stack.writeContext)
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        word.value = "Test"
        word.translate = "Test"
        sut.createWord(value: "Test", translate: "Test", lesson: lesson) { response in
            switch response {
            case .success(let word):
                XCTAssertNotNil(word)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        let firstFetch = try? stack.writeContext.fetch(fetchRequest)
        guard let word = firstFetch?[0]  else { return }
        XCTAssertEqual(word.value, "Test")
        XCTAssertEqual(word.translate, "Test")
        sut.deleteWord(with: word)
        let secondFetch = try? stack.readContext.fetch(fetchRequest)
        XCTAssertEqual(secondFetch?.count, 0)
    }

    func deleteAllLesson() {
        let context = stack.writeContext
        let fetchRequest = NSFetchRequest<Lesson>(entityName: "Lesson")
        context.performAndWait {
            let lesson = try? fetchRequest.execute()
            lesson?.forEach {
                context.delete($0)
            }
            try? context.save()
        }
    }

    func deleteAllWords() {
        let context = stack.writeContext
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        context.performAndWait {
            let words = try? fetchRequest.execute()
            words?.forEach {
                context.delete($0)
            }
            try? context.save()
        }
    }
}
