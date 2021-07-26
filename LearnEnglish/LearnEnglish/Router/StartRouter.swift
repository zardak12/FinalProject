//
//  StartRouter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 14.07.2021.
//

import UIKit

final class StartRouter {

    let assembly: AssemblyBuilderProtocol
    let dataService: DataServiceProtocol

    // MARK: - Init
    init(assembly: AssemblyBuilderProtocol, dataService: DataServiceProtocol) {
        self.assembly = assembly
        self.dataService = dataService
    }

    // MARK: - Start
    func getStartViewController() -> UIViewController {
        dataService.load()
        let viewControllers = assembly.createMainVC()
        return viewControllers
    }
}
