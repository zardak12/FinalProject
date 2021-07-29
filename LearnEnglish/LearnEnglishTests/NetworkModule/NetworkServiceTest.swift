//
//  NetworkServiceTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
@testable import LearnEnglish

class MockNetwork: NetworkServiceProtocol {
    var responce: [LessonDTO]?
    var image: UIImage?

    init() {}

    convenience init (with responce: [LessonDTO], with image: UIImage) {
        self.init()
        self.responce = responce
        self.image = image
    }

    func getLessons(completion: @escaping (LessonsResponce) -> Void) {
        if responce == nil {
            let error = NetworkError.unknown
            completion(.failure(error))
        } else {
            guard let responce = responce else { return }
            completion(.success(responce))
        }
    }
    func loadImage(completion: @escaping (UIImage) -> Void) {
        guard let image = image else { return }
        completion(image)
    }
}

class NetworkServiceTest: XCTestCase {
    var sut: NetworkServiceProtocol!
    let testError = NetworkError.unknown
    var responce = [LessonDTO]()
    var image: UIImage!

    override func setUp() {
        super.setUp()
        image = UIImage(systemName: "pencil")
        sut = MockNetwork(with: responce, with: image)
    }

    override func tearDown() {
        super.tearDown()
        image = nil
        sut = nil
    }

    func testNetworkServiceGetLessons() {

        var networkResponce: [LessonDTO]?

        let expectation = expectation(description: "getLessons")
        sut.getLessons { result in
            switch result {
            case .success(let responce):
                networkResponce = responce
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        XCTAssertEqual(responce, networkResponce)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testNetworkServiceLoadImage() {
        var catchImage: UIImage?

        let expectation = expectation(description: "getLessons")
        sut.loadImage { imageResponce in
            catchImage = imageResponce
            expectation.fulfill()
        }
        XCTAssertEqual(catchImage, image)
        waitForExpectations(timeout: 10, handler: nil)
    }
}
