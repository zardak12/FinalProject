//
//  SettingsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation

// MARK: - UpdateCollectionViewDelegate
protocol UpdateCollectionViewDelegate: AnyObject {

    /// Add word into SliderViewController
    /// - Parameter word: Word Entity
    func addNewWord(_ word: Word)

    /// Delete word in SliderViewController
    /// - Parameter indexPath: delete indexPath
    func deleteWord(_ indexPath: Int)

    /// Add offset
    func scrollToNext()
}

// MARK: - SettingsViewInput
protocol SettingsViewInput: AnyObject {
    /// Update tableView
    func updateTableView()

    /// show Allert with Error
    func showErrorAlert()
}

// MARK: - SettingsViewOutput
protocol SettingsViewOutput: AnyObject {
    var words: [Word]? { get set }
    var lesson: Lesson { get set }
    init(view: SettingsViewInput,
         lesson: Lesson,
         delegate: UpdateCollectionViewDelegate,
         coreDataService: CoreDataServiceProtocol)

    /// Create Word
    /// - Parameters:
    ///   - value: Word to learn
    ///   - translate: Translation of this word
    ///   - lesson: Specific lesson
    func createWord(value: String, translate: String, lesson: Lesson)

    /// Delete Word
    /// - Parameters:
    ///   - word: Word Entity thaw want to delete
    ///   - deleteIndex: delete index array
    func deleteWord(wtih word: Word, _ deleteIndex: Int)
    func update()
}

// MARK: - SettingsPresenter
final class SettingsPresenter: SettingsViewOutput {

    weak var view: SettingsViewInput?
    weak var delegate: UpdateCollectionViewDelegate?
    var coreDataService: CoreDataServiceProtocol
    var words: [Word]?
    var lesson: Lesson

    // MARK: - Init
    required init(view: SettingsViewInput,
                  lesson: Lesson,
                  delegate: UpdateCollectionViewDelegate,
                  coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.lesson = lesson
        self.delegate = delegate
        self.coreDataService = coreDataService
        words = lesson.words?.allObjects as? [Word]

    }

    // MARK: - Update
    func update() {
        view?.updateTableView()
    }

    // MARK: - Create Word
    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataService.createWord(value: value, translate: translate, lesson: lesson) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let word):
                self.words?.insert(word, at: 0)
                self.delegate?.addNewWord(word)
                self.delegate?.scrollToNext()
            case .failure(_):
                self.view?.showErrorAlert()
            }
        }
        view?.updateTableView()
    }

    // MARK: - DeleteWord
    func deleteWord(wtih word: Word, _ deleteIndex: Int) {
        words?.remove(at: deleteIndex)
        delegate?.deleteWord(deleteIndex)
        coreDataService.deleteWord(with: word)
        view?.updateTableView()
    }
}
