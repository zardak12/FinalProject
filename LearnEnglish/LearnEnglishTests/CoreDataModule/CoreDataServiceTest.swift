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
}
