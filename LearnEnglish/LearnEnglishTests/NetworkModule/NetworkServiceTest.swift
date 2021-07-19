//
//  NetworkServiceTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 17.07.2021.
//

import XCTest
@testable import LearnEnglish

class MockNetwork: NetworkServiceProtocol {
    var responce: GetResponce?
    var image: UIImage?

    init() {}

    convenience init (with responce: GetResponce, with image: UIImage) {
        self.init()
        self.responce = responce
        self.image = image
    }

    func getLessons(completion: @escaping (GetLessonsResponce) -> Void) {
        if responce?.lessons == nil {
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
    var responce: GetResponce!
    var image: UIImage!

    override func setUpWithError() throws {
        responce = GetResponce(lessons: nil)
        image = UIImage(systemName: "pencil")
        networkService = MockNetwork(with: responce, with: image)
    }

    override func tearDownWithError() throws {
        responce = nil
        image = nil
        networkService = nil
    }

    func testNetworkServiceGetLessons() throws {

        var catchError: NetworkError?

        networkService.getLessons { result in
            switch result {
            case .success(let responce):
                print(responce)
            case .failure(let error):
                print("Ошибка")
                catchError = error
            }
        }

        XCTAssertEqual(catchError, testError)
    }

    func testNetworkServiceLoadImage() throws {
        var catchImage: UIImage?

        networkService.loadImage { imageResponce in
            catchImage = imageResponce
        }
        XCTAssertEqual(catchImage, image)
    }
}
