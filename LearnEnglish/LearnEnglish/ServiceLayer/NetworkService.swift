//
//  NetworkService.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 25.06.2021.
//

import UIKit

protocol NetworkServiceProtocol {
    func getLessons(completion: @escaping (GetResponce) -> Void)
    func loadImage(completion: @escaping (UIImage) -> Void )
}

final class NetworkService: NetworkServiceProtocol {
  private let session: URLSession = .shared
  private let decoder = JSONDecoder()

    // MARK: - Upload Lessons

  func getLessons(completion: @escaping (GetResponce) -> Void) {
    guard  let lessonUrl = URL(string: NetworkConstant.lessonUrl) else { return }
    var request = URLRequest(url: lessonUrl)
    request.httpMethod = "GET"
    session.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        fatalError("No Lessons data found")
      }
      guard let response = try? self.decoder.decode(GetResponce.self, from: data) else { return }
      completion(response)
    }.resume()
  }

    // MARK: - Upload Image

  func loadImage(completion: @escaping (UIImage) -> Void ) {
    guard let imageUrl = URL(string: NetworkConstant.imageUrl) else { return }
    let imageRequest = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad)
    session.dataTask(with: imageRequest) { data, _, error in
      guard let data = data, error == nil else {
        fatalError("No Image data found")
      }
      guard let image = UIImage(data: data) else { return }
      completion(image)
    }.resume()
  }
}
