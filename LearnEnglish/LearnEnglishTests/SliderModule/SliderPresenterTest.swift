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
    func showErrorAlert() {
    }

    func updateCollectionView() {
    }
}

class SliderPresenterTest: XCTestCase {
    let stack = MockCoreDataStack()
    var view: SliderMockView!
    var navigationController: MockNavigationController!
    var assembly: AssemblyBuilder!
    var words = [Word]()
    var router: SliderRouterProtocol!
    var presenter: SliderViewOutput!
    var coreDataService: CoreDataServiceProtocol!

    override func setUpWithError() throws {
        let lesson = Lesson(context: stack.readContext)
        lesson.name = "Test"
        view = SliderMockView()
        navigationController = MockNavigationController()
        assembly = AssemblyBuilder()
        router = SliderRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
        coreDataService = MockCoreDataService(stack: stack)
        presenter = SliderPresenter(view: view, lesson: lesson, router: router, coreDataService: coreDataService)
    }

    override func tearDownWithError() throws {
        view = nil
        navigationController = nil
        assembly = nil
        router = nil
        presenter = nil
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
