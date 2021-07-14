//
//  AboutUsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

protocol AboutUsViewInput : AnyObject {
    func showAuthorImage(with image: UIImage)
}

protocol AboutUsViewOutput : AnyObject {
    init(view: AboutUsViewInput,networkService: NetworkServiceProtocol)
    func makeImageVisible()
}


class AboutUsPresenter: AboutUsViewOutput{
    weak var view: AboutUsViewInput?
    let networkService: NetworkServiceProtocol
    
    required init(view: AboutUsViewInput, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func makeImageVisible() {
        networkService.loadImage { image in
            DispatchQueue.main.async {
                self.view?.showAuthorImage(with: image)
            }
        }
    }
}
