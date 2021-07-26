//
//  RouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 13.07.2021.
//

import UIKit

// MARK: - RouterProtocol
protocol RouterProtocol {
    var navigationContoller: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}
