//
//  RouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 13.07.2021.
//

import UIKit

protocol RouterProtocol {
    var navigationContoller: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}
