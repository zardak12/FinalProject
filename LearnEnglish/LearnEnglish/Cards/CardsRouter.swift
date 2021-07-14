//
//  CardsRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 13.07.2021.
//

import UIKit

class CardsRouter: CardsRouterProtocol,RouterProtocol {
    var navigationContoller: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationContoller: UINavigationController,assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showSliderController(with words: [Word], lesson: Lesson) {
        let sliderVC = assemblyBuilder.createSlider(words: words, lesson: lesson)
        navigationContoller.pushViewController(sliderVC, animated: true)
    }
    
}
