//
//  SliderPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation
import AVFoundation

protocol SliderViewInput: AnyObject {
    func updateCollectionView()
    func showErrorAlert()
}

protocol SliderViewCellInput: AnyObject {
    func rotateFirst()
    func rotateSecond()
}

protocol SliderViewOutput: AnyObject {
    var cell: SliderViewCellInput? { get set }
    var words: [Word]? { get set }
    var lesson: Lesson { get set }
    var isSelect: Bool { get set }
    init(view: SliderViewInput,
         lesson: Lesson,
         router: SliderRouterProtocol,
          coreDataService: CoreDataServiceProtocol)
    func createWord(value: String, translate: String, lesson: Lesson)
    func addWord(_ newWord: Word)
    func deleteWord(_ deleteIndex: Int)
    func update()
    func tapOnSettings(delegate: UpdateCollectionViewDelegate)
    func rotate()
}

final class SliderPresenter: SliderViewOutput {

    weak var view: SliderViewInput?
    var cell: SliderViewCellInput?
    var words: [Word]?
    var lesson: Lesson
    var router: SliderRouterProtocol
    var coreDataService: CoreDataServiceProtocol
    var isSelect: Bool = false

    required init(view: SliderViewInput,
                  lesson: Lesson,
                  router: SliderRouterProtocol,
                  coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.lesson = lesson
        self.router = router
        self.coreDataService = coreDataService
        words = lesson.words?.allObjects as? [Word]
    }

    func update() {
        view?.updateCollectionView()
    }

    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataService.createWord(value: value, translate: translate, lesson: lesson) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let word):
                self.words?.insert(word, at: 0)
            case .failure(_):
                self.view?.showErrorAlert()
            }
        }
        view?.updateCollectionView()
    }

    func addWord(_ newWord: Word) {
        words?.insert(newWord, at: 0)
        view?.updateCollectionView()
    }

    func deleteWord(_ deleteIndex: Int) {
        words?.remove(at: deleteIndex)
        view?.updateCollectionView()
    }

    func tapOnSettings(delegate: UpdateCollectionViewDelegate) {
        guard  let words = words else { return }
        router.showSettingVC(with: words, lesson: lesson, delegate: delegate)
    }

    func rotate() {
      if isSelect == false {
        cell?.rotateSecond()
        isSelect = true
      } else {
        cell?.rotateFirst()
        isSelect = false
      }
    }
}
