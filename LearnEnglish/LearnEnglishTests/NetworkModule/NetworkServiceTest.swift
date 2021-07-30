//
//  NetworkServiceTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
@testable import LearnEnglish

class NetworkServiceTest: XCTestCase {
    var sut: NetworkServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = NetworkService()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testNetworkServiceGetLessons() {
        let expectationNetwork = expectation(description: "Get Lessons")

        sut.getLessons { responce in
            switch responce {
            case .success(let lessonResult):
                XCTAssertNotNil(lessonResult)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectationNetwork.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testNetworkServiceLoadImage() {
        let expectationImage = expectation(description: "Load Image")
        sut.loadImage { image in
            XCTAssertNotNil(image)
            expectationImage.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
