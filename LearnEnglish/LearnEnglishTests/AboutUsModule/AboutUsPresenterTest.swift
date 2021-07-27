//
//  AboutUsPresenterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 27.07.2021.
//

import XCTest

class MockAboutUsView: AboutUsViewInput {
    func showAuthorImage(with image: UIImage) {
    }
}

class AboutUsPresenterTest: XCTestCase {

    var sut: AboutUsViewOutput!
    var networkService: NetworkServiceProtocol!
    var view: AboutUsViewInput!
    var assembly: AssemblyBuilderProtocol!
    var router: ProfileRouterProtocol!

    override func setUp() {
        super.setUp()
        view = MockAboutUsView()
        networkService = MockNetwork()
        assembly = AssemblyBuilder()
        let viewRouter = UIViewController()
        router = ProfileRouter(assemblyBuilder: assembly, view: viewRouter)
        sut = AboutUsPresenter(view: view, networkService: networkService, router: router)
    }

    override func tearDown() {
        super.tearDown()
        networkService = nil
        view = nil
        router = nil
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

    func testMakeImageVisible() {
        sut.makeImageVisible { result in
            XCTAssertFalse(result)
        }
    }
}
