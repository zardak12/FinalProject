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
    var router: MenuRouterProtocol!
    var navigationController = MockNavigationController()
    let coreDataService = CoreDataService(stack: MockCoreDataStack())
    var lesson: Lesson?
    var word: Word?
    var words = [Word]()

    override func setUpWithError() throws {
        let lesson = Lesson(context: coreDataService.stack.readContext)
        let word = Word(context: coreDataService.stack.readContext)
        word.value = "hello"
        word.translate = "Привет"
        lesson.words?.adding(word)
        words.append(word)
        let assembly = AssemblyBuilder()
        router = MenuRouter(navigationContoller: navigationController, assemblyBuilder: assembly)

    }

    override func tearDownWithError() throws {
        lesson = nil
        word = nil
        router = nil
    }

    func testMenuRouterTraining() throws {
        router.showTrainingVC(with: words)
        let trainingVC = navigationController.presentedVC
        XCTAssertTrue(trainingVC is TrainingViewController)
    }

    func testMenuRouterSlider() throws {
        guard let lesson = lesson else { return }
        router.showSliderController(lesson: lesson)
        let sliderVC = navigationController.presentedVC
        XCTAssertTrue(sliderVC is SliderViewController)
    }

}
