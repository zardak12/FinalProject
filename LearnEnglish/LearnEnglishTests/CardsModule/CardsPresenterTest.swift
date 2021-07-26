//
//  CardsPresenterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 18.07.2021.
//

import XCTest
@testable import LearnEnglish

class CardsMockView: CardsViewInput {
    func showErrorAlert() {
    }
}

class CardsPresenterTest: XCTestCase {

    var sut: CardsPresenter!
    var view: CardsMockView!
    var assembly: AssemblyBuilder!
    var navigationController: MockNavigationController!
    var router: MenuRouterProtocol!
    var stack = MockCoreDataStack()
    var coreDataService: CoreDataServiceProtocol!

    override func setUp() {
        super.setUp()
        view = CardsMockView()
        assembly = AssemblyBuilder()
        navigationController = MockNavigationController()
        router = MenuRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
        coreDataService = MockCoreDataService(stack: stack)
        sut = CardsPresenter(view: view, router: router, coreDataService: coreDataService)
    }

    override func tearDown() {
        view = nil
        assembly = nil
        navigationController = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    func testViewIsNotNil() {
        XCTAssertNotNil(view)
    }

    func testRouterIsNotNil() {
        XCTAssertNotNil(router)
    }

    func testPresenterIsNotNil() {
        XCTAssertNotNil(sut)
    }
}
