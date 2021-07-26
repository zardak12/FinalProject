//
//  SliderPresenterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 18.07.2021.
//

import XCTest
import CoreData
@testable import LearnEnglish

class SliderMockView: SliderViewInput {
    func showErrorAlert() {}

    func updateCollectionView() {}
}

class SliderPresenterTest: XCTestCase {
    var sut: SliderViewOutput!
    let stack = MockCoreDataStack()
    var view: SliderMockView!
    var navigationController: MockNavigationController!
    var assembly: AssemblyBuilder!
    var words = [Word]()
    var router: SliderRouterProtocol!
    var coreDataService: CoreDataServiceProtocol!

    override func setUp() {
        super.setUp()
        let lesson = Lesson(context: stack.writeContext)
        let wordFirst = Word(context: stack.writeContext)
        wordFirst.value = "Value"
        wordFirst.translate = "Translate"
        words.append(wordFirst)
        lesson.name = "Test"
        lesson.addToWords(NSSet(array: words))
        view = SliderMockView()
        navigationController = MockNavigationController()
        assembly = AssemblyBuilder()
        router = SliderRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
        coreDataService = MockCoreDataService(stack: stack)
        sut = SliderPresenter(view: view, lesson: lesson, router: router, coreDataService: coreDataService)
    }

    override func tearDown() {
        view = nil
        navigationController = nil
        assembly = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    func testViewIsNotNil() {
        XCTAssertNotNil(view)
    }

    func testRouterIsNotNill() {
        XCTAssertNotNil(router)
    }

    func testPresenterIsNotNil() {
        XCTAssertNotNil(sut)
    }

    func testAddWord() {
        let wordFirst = Word(context: stack.writeContext)
        wordFirst.value = "Value"
        wordFirst.translate = "Translate"
        sut.addWord(wordFirst)
        XCTAssertEqual(sut.words?.count, 2)
    }

    func testDeleteWord() {
        sut.deleteWord(0)
        XCTAssertEqual(sut.words?.count, 0)
    }

}
