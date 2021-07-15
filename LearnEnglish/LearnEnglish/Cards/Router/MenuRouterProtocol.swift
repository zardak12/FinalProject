//
//  MenuRouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import Foundation

protocol MenuRouterProtocol {
    func showSliderController(with words: [Word],lesson: Lesson)
    func showTrainingVC(with words: [Word])
}
