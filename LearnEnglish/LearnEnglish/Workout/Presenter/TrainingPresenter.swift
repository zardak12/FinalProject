//
//  TrainingPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation
import AVFoundation

protocol TrainingViewInput: AnyObject {

}

protocol TrainingViewOutput: AnyObject {
    var words: [Word] { get set }
    init(view: TrainingViewInput, words: [Word])
    func getNewArray(word: Word) -> [Word]
    func rightAnswerAudio()
    func failedAnswerAudio()
}

class TrainingPresenter: TrainingViewOutput {

    var words: [Word]
    var answer: AVAudioPlayer?

    required init(view: TrainingViewInput, words: [Word]) {
        self.words = words
    }

    func getNewArray(word: Word) -> [Word] {
        var newArray = [Word]()
        var number = 0

        while number < 3 {
            if let newWord = words.randomElement() {
                if newWord != word {
                    if !newArray.contains(newWord) {
                        newArray.append(newWord)
                        number += 1
                    }
                }
            }
        }
        return newArray.shuffled()
    }

    func rightAnswerAudio() {
        guard let path = Bundle.main.path(forResource: "rightAnswer.wav", ofType: nil) else { return }
        answerAudio(with: path)
    }

    func failedAnswerAudio() {
        guard let path = Bundle.main.path(forResource: "Fail-sound.mp3", ofType: nil) else { return }
        answerAudio(with: path)
    }

    func answerAudio(with path: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            let url = URL(fileURLWithPath: path)
            do {
                self.answer = try AVAudioPlayer(contentsOf: url)
                self.answer?.play()
                self.answer?.setVolume(0.5, fadeDuration: 0.5)
            } catch {
                print("couldn't load file :(")
            }
        }
    }
}
