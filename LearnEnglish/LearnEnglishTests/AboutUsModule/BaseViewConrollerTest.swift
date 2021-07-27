//
//  BaseViewConrollerTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 25.07.2021.
//

import XCTest
import UIKit

class MockBaseViewController: UIViewController {

    // MARK: - Child
    private let spinner = SpinnerViewController()

    // MARK: - On/Off Spinner
    var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            let result = showSpinner(isShown: isLoading)
            print(result)
        }
    }

    // MARK: - show Spinner
    func showSpinner(isShown: Bool) -> Bool {
        if isShown {
            addChild(spinner)
            spinner.view.frame = view.frame
            view.addSubview(spinner.view)
            spinner.didMove(toParent: self)
            return true
        } else {
            spinner.willMove(toParent: nil)
            spinner.view.removeFromSuperview()
            spinner.removeFromParent()
            return false
        }
    }
}

class BaseViewControllerTests: XCTestCase {

    let sut = MockBaseViewController()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSpinnerLoadingFalse() {
        sut.isLoading = true
        sut.isLoading = false

        let result = sut.showSpinner(isShown: sut.isLoading)
        XCTAssertFalse(result)
    }

    func testSpinnerLoadingTrue() {
        sut.isLoading = false
        sut.isLoading = true

        let result = sut.showSpinner(isShown: sut.isLoading)

        XCTAssertTrue(result)
    }

    func testThatResultIsEqual() {
        sut.isLoading = true
        let result = sut.showSpinner(isShown: sut.isLoading)
        XCTAssertEqual(result, sut.isLoading)
    }

}
