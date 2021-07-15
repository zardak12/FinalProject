//
//  ProfileRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {

    var assemblyBuilder: AssemblyBuilderProtocol
    var view: UIViewController

    init(assemblyBuilder: AssemblyBuilderProtocol, view: UIViewController) {
        self.assemblyBuilder = assemblyBuilder
        self.view = view
    }
    func showAboutUsVC() {
        let aboutUsVC = UINavigationController(rootViewController: AssemblyBuilder().createAboutUs())
        view.present(aboutUsVC, animated: true)
    }

    func goBack() {
        view.dismiss(animated: true)
    }
}
