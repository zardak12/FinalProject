//
//  DIContainer.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 24.07.2021.
//

import Foundation

// MARK: - Container
final class Container {
    static let shared = Container()
    private init() {}

    lazy var coreDataStack = CoreDataStack()
}
