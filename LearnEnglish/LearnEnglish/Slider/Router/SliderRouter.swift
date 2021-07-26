//
//  SliderRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 14.07.2021.
//

import UIKit

final class SliderRouter: SliderRouterProtocol, RouterProtocol {
    // MARK: - Properties
    var navigationContoller: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol

    // MARK: - Init
    init(navigationContoller: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Show
    func showSettingVC(lesson: Lesson, delegate: UpdateCollectionViewDelegate) {
        let settingVC = assemblyBuilder.createSettings(lesson: lesson, delegate: delegate)
        navigationContoller.pushViewController(settingVC, animated: true)
    }

}
