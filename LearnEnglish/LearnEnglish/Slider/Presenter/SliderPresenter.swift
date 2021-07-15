//
//  SliderPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation
import AVFoundation

protocol SliderViewInput : AnyObject {
    func updateCollectionView()
}

protocol SliderViewCellInput: AnyObject {
    func rotateFirst()
    func rotateSecond()
}

protocol SliderViewOutput : AnyObject {
    var cell: SliderViewCellInput? {get set }
    var words: [Word]? { get set }
    var lesson: Lesson { get set }
    var isSelect: Bool { get set }
    init(view: SliderViewInput, words: [Word], lesson: Lesson,router: SliderRouterProtocol)
    func createWord(value: String, translate: String, lesson: Lesson)
    func addWord(_ newWord: Word)
    func deleteWord(_ deleteIndex: Int)
    func update()
    func tapOnSettings(delegate: UpdateCollectionViewDelegate)
    func rotate()
    func swipeAudio()
}


class SliderPresenter: SliderViewOutput {
    
    private let coreDataStack = Container.shared.coreDataStack
    
    weak var view: SliderViewInput?
    var cell: SliderViewCellInput?
    var words:[Word]?
    var lesson: Lesson
    var router: SliderRouterProtocol
    var isSelect: Bool = false
    var answer: AVAudioPlayer?
    
    
    required init(view: SliderViewInput, words: [Word], lesson: Lesson,router: SliderRouterProtocol) {
        self.view = view
        self.words = words
        self.lesson = lesson
        self.router = router
    }
    
    func update() {
        view?.updateCollectionView()
    }
    
    func createWord(value: String, translate: String, lesson: Lesson) {
        coreDataStack.createWord(value: value, translate: translate, lesson: lesson) { word in
            self.words?.append(word)
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
      if isSelect  == false{
        cell?.rotateSecond()
        isSelect = true
      }
      else {
        cell?.rotateFirst()
        isSelect = false
      }
    }
    
    func swipeAudio() {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let path = Bundle.main.path(forResource: "Whoosh.mp3", ofType:nil) else { return }
            let url = URL(fileURLWithPath: path)
            do {
                self.answer = try AVAudioPlayer(contentsOf: url)
                self.answer?.play()
                self.answer?.setVolume(0.1, fadeDuration: 0.5)
            } catch {
                print("couldn't load file :(")
            }
        }
    }
}
