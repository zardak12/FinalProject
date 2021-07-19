//
//   XCUIApplication+Extension.swift
//  LearnEnglishUITests
//
//  Created by Марк Шнейдерман on 19.07.2021.
//

import XCTest

extension XCUIApplication {
    func profileButton() -> XCUIElement {
        return self.tabBars["Tab Bar"].buttons["Профиль"]
    }
    func nameInput() -> XCUIElement {
        return self.textFields["Как вас зовут?"]
    }
    func returnButton() -> XCUIElement {
        return self.keyboards.buttons["Return"]
    }
}
