//
//  MockNetworkService.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 30.07.2021.
//

import Foundation
import UIKit

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
