//
//  CoreDataServiceTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 25.07.2021.
//

import XCTest

class CoreDataServiceTest: XCTestCase {

    var stack = MockCoreDataStack()
    var coreDataService: CoreDataServiceProtocol!
    var lesson: Lesson!
    var testWord: Word!
    var word: Word!

    override func setUpWithError() throws {
        lesson = Lesson(context: stack.writeContext)
        testWord = Word(context: stack.writeContext)
        testWord.value = "Test"
        testWord.translate = "Тест"
        coreDataService = CoreDataService(stack: stack)
    }

    override func tearDownWithError() throws {
        coreDataService = nil
    }

//    func testCreateWord() throws {
//        coreDataService.createWord(value: "Test", translate: "Тест", lesson: lesson) { result in
//            switch result {
//            case .success(let word):
//                self.word = word
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        print(word.value)
//        XCTAssertEqual(testWord.value, word.value)
//    }
}
