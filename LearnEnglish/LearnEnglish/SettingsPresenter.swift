//
//  SettingsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation

protocol UpdateCollectionViewDelegate: AnyObject {
    func addNewWord(_ word: Word)
    func deleteWord(_ indexPath: Int)
    func scrollToNext()
}

protocol SettingsViewInput: AnyObject {
    func updateTableView()
    func showErrorAlert()
}

protocol SettingsViewOutput: AnyObject {
    var words: [Word] { get set }
    var lesson: Lesson { get set }
    init(view: SettingsViewInput, words: [Word],
         lesson: Lesson,
         delegate: UpdateCollectionViewDelegate,
         coreDataService: CoreDataServiceProtocol)
    func createWord(value: String, translate: String, lesson: Lesson)
    func deleteWord(wtih word: Word, _ deleteIndex: Int)
    func update()
}

final class SettingsPresenter: SettingsViewOutput {

    weak var view: SettingsViewInput?
    weak var delegate: UpdateCollectionViewDelegate?
    var coreDataService: CoreDataServiceProtocol
    var words: [Word]
    var lesson: Lesson

    required init(view: SettingsViewInput, words: [Word],
                  lesson: Lesson,
                  delegate: UpdateCollectionViewDelegate,
                  coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.words = words
        self.lesson = lesson
        self.delegate = delegate
        self.coreDataService = coreDataService
    }

    func update() {
        view?.updateTableView()
    }

    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataService.createWord(value: value, translate: translate, lesson: lesson) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let word):
                self.words.append(word)
                self.delegate?.addNewWord(word)
                self.delegate?.scrollToNext()
            case .failure(_):
                self.view?.showErrorAlert()
            }
        }
        view?.updateTableView()
    }

    func deleteWord(wtih word: Word, _ deleteIndex: Int) {
        words.remove(at: deleteIndex)
        delegate?.deleteWord(deleteIndex)
        coreDataService.deleteWord(with: word)
        view?.updateTableView()
    }
}
