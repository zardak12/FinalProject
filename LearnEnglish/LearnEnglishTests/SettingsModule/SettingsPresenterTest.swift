//
//  SettingsPresenterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 27.07.2021.
//

import XCTest

class MockUpdateCollectionViewDelegate: UpdateCollectionViewDelegate {
    func addNewWord(_ word: Word) {
    }

    func deleteWord(_ indexPath: Int) {
    }

    func scrollToNext() {
    }

}

class MockSettingsView: SettingsViewInput {
    func updateTableView() {
    }

    func showErrorAlert() {
    }
}

class SettingsPresenterTest: XCTestCase {

    var sut: SettingsViewOutput!
    var view: SettingsViewInput!
    let stack = MockCoreDataStack()
    var coreDataService: CoreDataServiceProtocol!
    var delegate: UpdateCollectionViewDelegate!
    var lesson: Lesson!

    override func setUp() {
        super.setUp()
        view = MockSettingsView()
        coreDataService = MockCoreDataService(stack: stack)
        lesson = Lesson(context: stack.writeContext)
        delegate = MockUpdateCollectionViewDelegate()
        sut = SettingsPresenter(view: view, lesson: lesson, delegate: delegate, coreDataService: coreDataService)
    }

    override func tearDown() {
        view = nil
        coreDataService = nil
        delegate = nil
        sut = nil
        super.tearDown()
    }

    func testViewIsNotNil() {
        XCTAssertNotNil(view)
    }

    func testPresenterIsNotNil() {
        XCTAssertNotNil(sut)
    }

    func testDeleteWord() {
        var words = [Word]()
        let wordFirst = Word(context: stack.writeContext)
        wordFirst.value = "Test First"
        wordFirst.translate = "Test First"
        let wordSecond = Word(context: stack.writeContext)
        wordSecond.value = "Test Second"
        wordSecond.translate = "Test Second"
        words.append(wordFirst)
        words.append(wordSecond)
        sut.words = words
        XCTAssertEqual(sut.words?.count, 2)
        sut.deleteWord(wtih: wordFirst, 0)
        XCTAssertEqual(sut.words?.count, 1)
    }
}
