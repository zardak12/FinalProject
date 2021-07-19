//
//  LoginPage.swift
//  LearnEnglishUITests
//
//  Created by Марк Шнейдерман on 19.07.2021.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get set }

    init(app: XCUIApplication)
}

class LoginPage: Page {
    var app: XCUIApplication

    required init(app: XCUIApplication) {
        self.app = app
    }

    func enterUserName(username: String) {
        app.profileButton().tap()
        let nameInput = app.nameInput()
        nameInput.tap()
        nameInput.typeText(username)
        app.returnButton().tap()
        XCTAssertTrue(nameInput.exists)
    }
}
