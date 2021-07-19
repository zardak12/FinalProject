//
//  SliderRouterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
import CoreData
@testable import LearnEnglish

class MockDelegate: UpdateCollectionViewDelegate {
    func addNewWord(_ word: Word) {
    }

    func deleteWord(_ indexPath: Int) {
    }

}

class SliderRouterTest: XCTestCase {

    var router: SliderRouterProtocol!
    var navigationController = MockNavigationController()
    var delegate = MockDelegate()
    var lesson: Lesson?
    var word: Word?
    var words = [Word]()
    let coreDataStack = Container.shared.coreDataStack

    override func setUpWithError() throws {
        let lesson = Lesson(context: coreDataStack.viewContext)
        let word = Word(context: coreDataStack.viewContext)
        word.value = "hello"
        word.translate = "Привет"
        lesson.words?.adding(word)
        words.append(word)
        let assembly = AssemblyBuilder()
        router = SliderRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        lesson = nil
        word = nil
        router = nil
    }

    func testSliderRouter() throws {
        guard let lesson = lesson else { return }
        router.showSettingVC(with: words, lesson: lesson, delegate: delegate)
        let settingVc = navigationController.presentedVC
        XCTAssertTrue(settingVc is SettingsViewController)
    }
}
