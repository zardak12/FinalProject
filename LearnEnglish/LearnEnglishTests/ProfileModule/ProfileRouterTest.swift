//
//  ProfileRouterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
@testable import LearnEnglish

class ProfileRouterTest: XCTestCase {

    var sut: ProfileRouterProtocol!
    let view = UIViewController()

    override func setUp() {
        super.setUp()
        let assembly = AssemblyBuilder()
        sut = ProfileRouter(assemblyBuilder: assembly, view: view)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testProfileRouter() {
        sut.showAboutUsVC()
        XCTAssertNotNil(view)
    }
}
