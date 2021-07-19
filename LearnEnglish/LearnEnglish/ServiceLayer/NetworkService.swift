//
//  NetworkService.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 25.06.2021.
//

import UIKit

typealias GetLessonsResponce = Result<GetResponce, NetworkError>
typealias GetImageResponce = Result<UIImage, NetworkError>

protocol NetworkServiceProtocol {
    func getLessons(completion: @escaping (GetLessonsResponce) -> Void)
    func loadImage(completion: @escaping (UIImage) -> Void )
}

final class NetworkService: NetworkServiceProtocol {
  private let session: URLSession = .shared
  private let decoder = JSONDecoder()

    // MARK: - Upload Lessons

  func getLessons(completion: @escaping (GetLessonsResponce) -> Void) {
    guard  let lessonUrl = URL(string: NetworkConstant.lessonUrl) else { return }
    var request = URLRequest(url: lessonUrl)
    request.httpMethod = "GET"
    let dataTask = session.dataTask(with: request) { data, responce, error in
        do {
            let data = try self.httpResponse(data: data, response: responce)
            let responce = try self.decoder.decode(GetResponce.self, from: data)
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

  private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode),
        let data = data else {
        throw NetworkError.network
        }
    return data
    }
}
