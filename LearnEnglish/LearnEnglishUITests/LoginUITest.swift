//
//  LoginUITest.swift
//  LearnEnglishUITests
//
//  Created by Марк Шнейдерман on 19.07.2021.
//

import XCTest

class LoginUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }

    func testLogin() throws {
        let loginPage = LoginPage(app: app)
        loginPage.enterUserName(username: "Test")
    }
}
