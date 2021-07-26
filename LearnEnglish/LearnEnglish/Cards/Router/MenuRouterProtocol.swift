//
//  MenuRouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import Foundation

  // MARK: - MenuRouterProtocol
protocol MenuRouterProtocol {
    /// Show SliderViewController
    /// - Parameter lesson: Lesson Entity
    func showSliderController(lesson: Lesson)

    /// Show TrainingViewController
    /// - Parameter words: Word Entity
    func showTrainingVC(with words: [Word])
}
