//
//  ProfileRouterTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
@testable import LearnEnglish

class ProfileRouterTest: XCTestCase {

    var router: ProfileRouterProtocol!
    let view = UIViewController()

    override func setUpWithError() throws {
        let assembly = AssemblyBuilder()
        router = ProfileRouter(assemblyBuilder: assembly, view: view)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testProfileRouter() throws {
        router.showAboutUsVC()
        XCTAssertNotNil(view)
    }
}
