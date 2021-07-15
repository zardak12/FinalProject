//
//  SliderRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 14.07.2021.
//

import UIKit

class SliderRouter: SliderRouterProtocol, RouterProtocol {
    var navigationContoller: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationContoller: UINavigationController,assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }
    func showSettingVC(with words: [Word], lesson: Lesson, delegate: UpdateCollectionViewDelegate) {
        let settingVC = assemblyBuilder.createSettings(words: words, lesson: lesson, delegate: delegate)
        navigationContoller.pushViewController(settingVC, animated: true)
    }

    
    
}
