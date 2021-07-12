//
//  Assembly.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

protocol AssemblyProtocol {
    static func createProfile() -> UIViewController
}

class Assembly: AssemblyProtocol {
    static func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
}
