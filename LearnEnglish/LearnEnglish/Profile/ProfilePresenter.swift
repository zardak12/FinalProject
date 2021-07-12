//
//  ProfilePresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

class ProfilePresenter: ProfileViewOutput {
    
    let defaults = UserDefaults.standard
    weak var view: ProfileViewInput?
    
    required init(view: ProfileViewInput) {
        self.view = view
    }
    
    func checkImage() {
        if let imageData = defaults.object(forKey: UserDefaultKeys.keyForAvaImage) as? Data,
           let image = UIImage(data: imageData) {
            view?.showAvaImage(with: image,with: "")
        } else {
            guard let image = UIImage(named: "userIcon") else { return }
            view?.showAvaImage(with: image,with: "Tap to change")
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
    
}
