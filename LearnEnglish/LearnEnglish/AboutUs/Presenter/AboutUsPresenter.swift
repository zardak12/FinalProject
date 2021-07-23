//
//  AboutUsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

protocol AboutUsViewInput: AnyObject {
    func showAuthorImage(with image: UIImage)
}

protocol AboutUsViewOutput: AnyObject {
    init(view: AboutUsViewInput, networkService: NetworkServiceProtocol, router: ProfileRouterProtocol)
    func makeImageVisible(completion: (Bool) -> Void)
    func tapBack()
}

final class AboutUsPresenter: AboutUsViewOutput {
    weak var view: AboutUsViewInput?
    let networkService: NetworkServiceProtocol
    var router: ProfileRouterProtocol

    required init(view: AboutUsViewInput, networkService: NetworkServiceProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

    func makeImageVisible(completion: (Bool) -> Void) {
        networkService.loadImage { image in
            DispatchQueue.main.async {
                self.view?.showAuthorImage(with: image)
            }
        }
        completion(false)
    }

    func tapBack() {
        router.goBack()
    }
}
