//
//  Containers.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 29.06.2021.
//

import Foundation

final class Container {
    static let shared = Container()
    private init() {}

    lazy var coreDataStack = CoreDataStack(modelName: "Lessons")
}
