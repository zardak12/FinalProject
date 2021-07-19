//
//  MenuRouterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
import CoreData
@testable import LearnEnglish

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class MenuRouterTest: XCTestCase {
    var router: MenuRouterProtocol!
    var navigationController = MockNavigationController()
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
        router.showSliderController(with: words, lesson: lesson)
        let sliderVC = navigationController.presentedVC
        XCTAssertTrue(sliderVC is SliderViewController)
    }

}
