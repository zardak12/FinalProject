//
//  AboutUsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

// MARK: - AboutUsViewInput
protocol AboutUsViewInput: AnyObject {
    /// Show Author Image
    /// - Parameter image: Image from Network
    func showAuthorImage(with image: UIImage)
}

// MARK: - AboutUsViewOutput
protocol AboutUsViewOutput: AnyObject {
    init(view: AboutUsViewInput, networkService: NetworkServiceProtocol, router: ProfileRouterProtocol)
    func makeImageVisible(completion: (Bool) -> Void)
    func tapBack()
}

final class AboutUsPresenter: AboutUsViewOutput {
    weak var view: AboutUsViewInput?
    let networkService: NetworkServiceProtocol
    var router: ProfileRouterProtocol

    // MARK: - Init
    required init(view: AboutUsViewInput, networkService: NetworkServiceProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

    func makeImageVisible(completion: (Bool) -> Void) {
        networkService.loadImage { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.showAuthorImage(with: image)
            }
        }
        completion(false)
    }

    // MARK: - Router
    func tapBack() {
        router.goBack()
    }
}
