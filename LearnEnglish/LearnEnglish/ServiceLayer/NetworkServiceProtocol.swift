//
//  NetworkServiceProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 26.07.2021.
//

import UIKit

  // MARK: - Typealias
typealias LessonsResponce = Result<[LessonDTO], NetworkError>
typealias GetImageResponce = Result<UIImage, NetworkError>

  // MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {

    /// Get Lessons from network
    /// - Parameter completion: Handler with result of responce
    func getLessons(completion: @escaping (LessonsResponce) -> Void)

    /// Load Image
    /// - Parameter completion: Handler with result of image
    func loadImage(completion: @escaping (UIImage) -> Void )
}
