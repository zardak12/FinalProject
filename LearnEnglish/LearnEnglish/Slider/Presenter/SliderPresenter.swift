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
    init(view: SliderViewInput, lesson: Lesson, router: SliderRouterProtocol)
    func createWord(value: String, translate: String, lesson: Lesson)
    func addWord(_ newWord: Word)
    func deleteWord(_ deleteIndex: Int)
    func update()
    func tapOnSettings(delegate: UpdateCollectionViewDelegate)
    func rotate()
    func swipeAudio()
}

final class SliderPresenter: SliderViewOutput {

    private let coreDataStack = Container.shared.coreDataStack

    weak var view: SliderViewInput?
    var cell: SliderViewCellInput?
    var words: [Word]?
    var lesson: Lesson
    var router: SliderRouterProtocol
    var isSelect: Bool = false
    var whoosh: AVAudioPlayer?

    required init(view: SliderViewInput, lesson: Lesson, router: SliderRouterProtocol) {
        self.view = view
        self.lesson = lesson
        self.router = router
        words = lesson.words?.allObjects as? [Word]
    }

    func update() {
        view?.updateCollectionView()
    }

    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataStack.createWord(value: value, translate: translate, lesson: lesson) { word in
            self.words?.insert(word, at: 0)
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

    func swipeAudio() {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let path = Bundle.main.path(forResource: "Whoosh.mp3", ofType: nil) else { return }
            let url = URL(fileURLWithPath: path)
            do {
                self.whoosh = try AVAudioPlayer(contentsOf: url)
                self.whoosh?.play()
                self.whoosh?.setVolume(0.5, fadeDuration: 0.5)
            } catch {
                print("couldn't load file :(")
            }
        }
    }
}
