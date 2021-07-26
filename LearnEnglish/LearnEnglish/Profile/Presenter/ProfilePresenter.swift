//
//  ProfilePresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

// MARK: - ProfileViewInput
protocol ProfileViewInput: AnyObject {
    /// Show Image
    /// - Parameters:
    ///   - image: Change Image
    ///   - text: Change text inder image
  func showAvaImage(with image: UIImage, with text: String)

    /// Show name
    /// - Parameter name: name that display
  func showName(with name: String)
}

// MARK: - ProfileViewOutput
protocol ProfileViewOutput: AnyObject {

  init(view: ProfileViewInput, with router: ProfileRouterProtocol)

  func checkImage()
  func checkName()

    /// Save Image UserDefaults
    /// - Parameter image: UIImage from picker
  func saveImage(with image: UIImage)

    /// Save Name UserDefaults
    /// - Parameter name: Put your name
  func saveName(with name: String)

    /// Switch to AboutUsViewController
  func tapOnAboutUsVC()
}

// MARK: - ProfilePresenter
final class ProfilePresenter: ProfileViewOutput {

    // MARK: - Properties
    let defaults = UserDefaults.standard
    weak var view: ProfileViewInput?
    var router: ProfileRouterProtocol

    // MARK: - Init
    required init(view: ProfileViewInput, with router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }

    // MARK: - Check
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

    // MARK: - Save UserDefaults
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

    // MARK: - Router
    func tapOnAboutUsVC() {
        router.showAboutUsVC()
    }

}
