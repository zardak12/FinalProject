//
//  SliderPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation

protocol SliderViewInput : AnyObject {
    func updateCollectionView()
}

protocol SliderViewOutput : AnyObject {
    var words: [Word]? {get set}
    var lesson: Lesson {get set}
    init(view: SliderViewInput, words: [Word], lesson: Lesson)
    func createWord(value: String, translate: String, lesson: Lesson)
}


class SliderPresenter: SliderViewOutput {
    
    private let coreDataStack = Container.shared.coreDataStack
    
    
    weak var view: SliderViewInput?
    var words:[Word]?
    var lesson: Lesson
    
    
    required init(view: SliderViewInput, words: [Word], lesson: Lesson) {
        self.view = view
        self.words = words
        self.lesson = lesson
    }
    
    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataStack.createWord(value: value, translate: translate, lesson: lesson)
        view?.updateCollectionView()
    }
    /*
     self.coreDataStack.createWord(value: valueText, translate: translateText, lesson: self.lesson) { word in
         self.words.insert(word, at: 0)
         DispatchQueue.main.async {
             self.collectionView.reloadData()
         }
     }
     */
    
}
