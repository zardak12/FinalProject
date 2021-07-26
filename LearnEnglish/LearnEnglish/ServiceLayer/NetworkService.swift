//
//  NetworkService.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 25.06.2021.
//

import UIKit

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Properties
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()

    // MARK: - Upload Lessons
    func getLessons(completion: @escaping (LessonsResponce) -> Void) {
        guard  let lessonUrl = URL(string: NetworkConstant.lessonURL) else { return }
        var request = URLRequest(url: lessonUrl)
        request.httpMethod = "GET"
        let dataTask = session.dataTask(with: request) { data, responce, error in
            do {
                let data = try self.httpResponse(data: data, response: responce)
                let responce = try self.decoder.decode([LessonDTO].self, from: data)
                completion(.success(responce))
            } catch let error as NetworkError {
                completion(.failure(error))
            } catch {
                completion(.failure(.unknown))
            }
        }
        dataTask.resume()
    }

    // MARK: - Upload Image
    func loadImage(completion: @escaping (UIImage) -> Void ) {
        guard let imageUrl = URL(string: NetworkConstant.imageUrl) else { return }
        let imageRequest = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad)
        let dataTask = session.dataTask(with: imageRequest) { data, _, error in
            guard let data = data, error == nil else {
                fatalError("No Image data found")
            }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
        dataTask.resume()
    }

    // MARK: - httpResponse
    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw NetworkError.network
        }
        return data
    }
}
