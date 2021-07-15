//
//  SliderRouterProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 14.07.2021.
//

import Foundation

protocol SliderRouterProtocol {
    func showSettingVC(with words: [Word],lesson: Lesson, delegate: UpdateCollectionViewDelegate)
}
