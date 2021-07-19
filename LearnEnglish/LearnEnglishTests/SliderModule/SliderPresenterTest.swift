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
    func updateCollectionView() {
    }
}

class SliderPresenterTest: XCTestCase {
    let coreDataStack = Container.shared.coreDataStack
    var view: SliderMockView!
    var navigationController: MockNavigationController!
    var assembly: AssemblyBuilder!
    var lesson: Lesson!
    var words = [Word]()
    var router: SliderRouterProtocol!
    var presenter: SliderPresenter!

    override func setUpWithError() throws {
        view = SliderMockView()
        navigationController = MockNavigationController()
        assembly = AssemblyBuilder()
        router = SliderRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
        lesson = Lesson(context: coreDataStack.viewContext)
        presenter = SliderPresenter(view: view, words: words, lesson: lesson, router: router)
    }

    override func tearDownWithError() throws {
        view = nil
        navigationController = nil
        assembly = nil
        router = nil
        presenter = nil
        lesson = nil
    }

    func testViewIsNotNil() throws {
        XCTAssertNotNil(view)
    }

    func testRouterIsNotNill() throws {
        XCTAssertNotNil(router)
    }

    func testPresenterIsNotNil() throws {
        XCTAssertNotNil(presenter)
    }

}
