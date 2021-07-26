//
//  MenuRouterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
import CoreData
@testable import LearnEnglish

class MenuRouterTest: XCTestCase {
    var sut: MenuRouterProtocol!
    var navigationController = MockNavigationController()
    let coreDataService = CoreDataService(stack: MockCoreDataStack())
    var lesson: Lesson?
    var word: Word?
    var words = [Word]()

    override func setUp() {
        super.setUp()
        let lesson = Lesson(context: coreDataService.stack.readContext)
        let word = Word(context: coreDataService.stack.readContext)
        word.value = "hello"
        word.translate = "Привет"
        lesson.words?.adding(word)
        words.append(word)
        let assembly = AssemblyBuilder()
        sut = MenuRouter(navigationContoller: navigationController, assemblyBuilder: assembly)

    }

    override func tearDown() {
        lesson = nil
        word = nil
        sut = nil
        super.tearDown()
    }

    func testMenuRouterTraining() throws {
        sut.showTrainingVC(with: words)
        let trainingVC = navigationController.presentedVC
        XCTAssertTrue(trainingVC is TrainingViewController)
    }

    func testMenuRouterSlider() throws {
        guard let lesson = lesson else { return }
        sut.showSliderController(lesson: lesson)
        let sliderVC = navigationController.presentedVC
        XCTAssertTrue(sliderVC is SliderViewController)
    }

}
