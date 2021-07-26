//
//  SliderRouterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
@testable import LearnEnglish

class MockDelegate: UpdateCollectionViewDelegate {
    func scrollToNext() {
    }

    func addNewWord(_ word: Word) {
    }

    func deleteWord(_ indexPath: Int) {
    }

}

class SliderRouterTest: XCTestCase {

    var sut: SliderRouterProtocol!
    var navigationController = MockNavigationController()
    var delegate = MockDelegate()
    var lesson: Lesson?
    var word: Word?
    var words = [Word]()
    let stack = MockCoreDataStack()
    var coreDataService: CoreDataServiceProtocol!

    override func setUp() {
        super.setUp()
        coreDataService = MockCoreDataService(stack: stack)
        let lesson = Lesson(context: coreDataService.stack.readContext)
        let word = Word(context: coreDataService.stack.readContext)
        word.value = "hello"
        word.translate = "Привет"
        lesson.words?.adding(word)
        words.append(word)
        let assembly = AssemblyBuilder()
        sut = SliderRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
    }

    override func tearDown() {
        lesson = nil
        word = nil
        sut = nil
        super.tearDown()
    }

    func testSliderRouter() {
        guard let lesson = lesson else { return }
        sut.showSettingVC(lesson: lesson, delegate: delegate)
        let settingVc = navigationController.presentedVC
        XCTAssertTrue(settingVc is SettingsViewController)
    }
}
