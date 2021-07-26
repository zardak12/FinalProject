//
//  SliderRouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 14.07.2021.
//

import Foundation
import CoreData

protocol SliderRouterProtocol {
    /// Show SettingsViewController
    /// - Parameters:
    ///   - lesson: Lesson Entity
    ///   - delegate: delegate that updated SliderViewController
    func showSettingVC(lesson: Lesson, delegate: UpdateCollectionViewDelegate)
}
