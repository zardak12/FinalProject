//
//  MenuRouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import Foundation

  // MARK: - MenuRouterProtocol
protocol MenuRouterProtocol {
    func showSliderController(lesson: Lesson)
    func showTrainingVC(with words: [Word])
}
