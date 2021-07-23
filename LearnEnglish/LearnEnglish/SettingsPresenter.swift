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
}

protocol SettingsViewOutput: AnyObject {
    var words: [Word] { get set }
    var lesson: Lesson { get set }
    init(view: SettingsViewInput, words: [Word], lesson: Lesson, delegate: UpdateCollectionViewDelegate)
    func createWord(value: String, translate: String, lesson: Lesson)
    func deleteWord(wtih word: Word, _ deleteIndex: Int)
    func update()
}

final class SettingsPresenter: SettingsViewOutput {
    private let coreDataStack = Container.shared.coreDataStack

    weak var view: SettingsViewInput?
    weak var delegate: UpdateCollectionViewDelegate?
    var words: [Word]
    var lesson: Lesson

    required init(view: SettingsViewInput, words: [Word], lesson: Lesson, delegate: UpdateCollectionViewDelegate) {
        self.view = view
        self.words = words
        self.lesson = lesson
        self.delegate = delegate
    }

    func update() {
        view?.updateTableView()
    }

    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataStack.createWord(value: value, translate: translate, lesson: lesson) { word in
            self.words.append(word)
            self.delegate?.addNewWord(word)
            self.delegate?.scrollToNext()
        }
        view?.updateTableView()
    }

    func deleteWord(wtih word: Word, _ deleteIndex: Int) {
        words.remove(at: deleteIndex)
        delegate?.deleteWord(deleteIndex)
        coreDataStack.deleteWord(with: word)
        view?.updateTableView()
    }
}
