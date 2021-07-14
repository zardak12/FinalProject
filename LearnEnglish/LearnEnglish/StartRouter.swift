//
//  StartRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 14.07.2021.
//

import UIKit

class StartRouter {
    
    let assembly: AssemblyBuilderProtocol
    
    init(assembly: AssemblyBuilderProtocol) {
        self.assembly = assembly
    }
    
    func getStartViewController() -> UIViewController {
        let viewControllers = assembly.createMainVC()
        return viewControllers
    }
}
