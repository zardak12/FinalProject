//
//  SliderPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation
import AVFoundation

protocol SliderViewInput: AnyObject {

    /// Update collectionView
    func updateCollectionView()

    /// Show alert with Error
    func showErrorAlert()
}

protocol SliderViewCellInput: AnyObject {

    /// Rotate card to one side
    func rotateFirst()

    /// Rotate card to another side
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

    /// Create a new word
    /// - Parameters:
    ///   - value: Word to learn
    ///   - translate: Translation of this word
    ///   - lesson: Specific lesson
    func createWord(value: String, translate: String, lesson: Lesson)

    /// Add word in array
    /// - Parameter newWord: new word
    func addWord(_ newWord: Word)

    /// Delete word from array
    /// - Parameter deleteIndex: index array
    func deleteWord(_ deleteIndex: Int)

    func update()

    /// Switch to the SettingsViewController
    /// - Parameter delegate: delegate that update SliderViewContorller
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

    // MARK: - Init
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

    // MARK: - Update
    func update() {
        view?.updateCollectionView()
    }

    // MARK: - Create Word
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

    // MARK: - UpdateCollectionViewDelegate Methods
    func addWord(_ newWord: Word) {
        words?.insert(newWord, at: 0)
        view?.updateCollectionView()
    }

    func deleteWord(_ deleteIndex: Int) {
        words?.remove(at: deleteIndex)
        view?.updateCollectionView()
    }

    // MARK: - Router
    func tapOnSettings(delegate: UpdateCollectionViewDelegate) {
        router.showSettingVC(lesson: lesson, delegate: delegate)
    }

    // MARK: - Rotate
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
