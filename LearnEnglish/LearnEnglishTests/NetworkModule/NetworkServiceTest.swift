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
    let testError = NetworkError.unknown
    var networkService: NetworkServiceProtocol!
    var responce = [LessonDTO]()
    var image: UIImage!

    override func setUpWithError() throws {
        image = UIImage(systemName: "pencil")
        networkService = MockNetwork(with: responce, with: image)
    }

    override func tearDownWithError() throws {
        image = nil
        networkService = nil
    }

    func testNetworkServiceGetLessons() throws {

        var networkResponce: [LessonDTO]?

        networkService.getLessons { result in
            switch result {
            case .success(let responce):
                networkResponce = responce
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        XCTAssertEqual(responce, networkResponce)
    }

    func testNetworkServiceLoadImage() throws {
        var catchImage: UIImage?

        networkService.loadImage { imageResponce in
            catchImage = imageResponce
        }
        XCTAssertEqual(catchImage, image)
    }
}
