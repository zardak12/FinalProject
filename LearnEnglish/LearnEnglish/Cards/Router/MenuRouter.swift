//
//  MenuRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import UIKit

class MenuRouter: MenuRouterProtocol, RouterProtocol {
    var navigationContoller: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol

    init(navigationContoller: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }

    func showSliderController(with words: [Word], lesson: Lesson) {
        let sliderVC = assemblyBuilder.createSlider(with: navigationContoller, words: words, lesson: lesson)
        navigationContoller.pushViewController(sliderVC, animated: true)
    }

    func showTrainingVC(with words: [Word]) {
        let trainingVC = assemblyBuilder.createTraining(with: words)
        navigationContoller.pushViewController(trainingVC, animated: true)
    }
}
