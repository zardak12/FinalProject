//
//  MenuRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import UIKit

  // MARK: - MenuRouter
final class MenuRouter: MenuRouterProtocol, RouterProtocol {
    var navigationContoller: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol

      // MARK: - Init
    init(navigationContoller: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }

      // MARK: - Show
    func showSliderController(lesson: Lesson) {
        let sliderVC = assemblyBuilder.createSlider(with: navigationContoller, lesson: lesson)
        navigationContoller.pushViewController(sliderVC, animated: true)
    }

    func showTrainingVC(with words: [Word]) {
        let trainingVC = assemblyBuilder.createTraining(with: words)
        navigationContoller.pushViewController(trainingVC, animated: true)
    }
}
