//
//  ProfilePresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

// MARK: - ProfileViewInput

protocol ProfileViewInput: AnyObject {
  func showAvaImage(with image: UIImage, with text: String)
  func showName(with name: String)
}

// MARK: - ProfileViewOutput

protocol ProfileViewOutput: AnyObject {

  init(view: ProfileViewInput, with router: ProfileRouterProtocol)

  func checkImage()
  func checkName()

  func saveImage(with image: UIImage)
  func saveName(with name: String)
  func tapOnAboutUsVC()
}

  // MARK: - ProfilePresenter

final class ProfilePresenter: ProfileViewOutput {

    let defaults = UserDefaults.standard
    weak var view: ProfileViewInput?
    var router: ProfileRouterProtocol

    required init(view: ProfileViewInput, with router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }

    func checkImage() {
        if let imageData = defaults.object(forKey: UserDefaultKeys.keyForAvaImage) as? Data,
           let image = UIImage(data: imageData) {
            view?.showAvaImage(with: image, with: "")
        } else {
            guard let image = UIImage(named: "userIcon") else { return }
            view?.showAvaImage(with: image, with: "Tap to change")
        }
    }

    func checkName() {
        if let textValue = defaults.object(forKey: UserDefaultKeys.keyForName) as? String {
            view?.showName(with: textValue)
        }
    }

    func saveImage(with image: UIImage) {
        view?.showAvaImage(with: image, with: "")
        if let png = image.pngData() {
            defaults.set(png, forKey: UserDefaultKeys.keyForAvaImage)
        }
    }

    func saveName(with name: String) {
        view?.showName(with: name)
        defaults.set(name, forKey: UserDefaultKeys.keyForName)
    }

    func tapOnAboutUsVC() {
        router.showAboutUsVC()
    }

}
