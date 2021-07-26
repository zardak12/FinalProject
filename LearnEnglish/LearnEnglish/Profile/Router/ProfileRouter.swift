//
//  ProfileRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import UIKit

final class ProfileRouter: ProfileRouterProtocol {

    var assemblyBuilder: AssemblyBuilderProtocol
    var view: UIViewController

    // MARK: - Init
    init(assemblyBuilder: AssemblyBuilderProtocol, view: UIViewController) {
        self.assemblyBuilder = assemblyBuilder
        self.view = view
    }

    // MARK: - Show
    func showAboutUsVC() {
        let aboutUsVC = UINavigationController(rootViewController: AssemblyBuilder().createAboutUs())
        view.present(aboutUsVC, animated: true)
    }

    // MARK: - Back
    func goBack() {
        view.dismiss(animated: true)
    }
}
