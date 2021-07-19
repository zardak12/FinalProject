//
//  CardsPresenterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 18.07.2021.
//

import XCTest
@testable import LearnEnglish

class CardsMockView: CardsViewInput { }

class CardsPresenterTest: XCTestCase {

    var view: CardsMockView!
    var assembly: AssemblyBuilder!
    var navigationController: MockNavigationController!
    var router: MenuRouterProtocol!
    var presenter: CardsPresenter!

    override func setUpWithError() throws {
        view = CardsMockView()
        assembly = AssemblyBuilder()
        navigationController = MockNavigationController()
        router = MenuRouter(navigationContoller: navigationController, assemblyBuilder: assembly)
        presenter = CardsPresenter(view: view, router: router)
    }

    override func tearDownWithError() throws {
        view = nil
        assembly = nil
        navigationController = nil
        router = nil
        presenter = nil
    }

    func testViewIsNotNil() throws {
        XCTAssertNotNil(view)
    }

    func testRouterIsNotNil() throws {
        XCTAssertNotNil(router)
    }

    func testPresenterIsNotNil() throws {
        XCTAssertNotNil(presenter)
    }
}
