//
//  TrainingPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import Foundation
import AVFoundation

  // MARK: - TrainingViewInput
protocol TrainingViewInput: AnyObject {}

  // MARK: - TrainingViewOutput
protocol TrainingViewOutput: AnyObject {
    var words: [Word] { get set }
    init(view: TrainingViewInput, words: [Word])
    /// Create a new array
    /// - Parameter word: Word Entity
    func getNewArray(word: Word) -> [Word]
    func rightAnswerAudio()
    func failedAnswerAudio()
}

final class TrainingPresenter: TrainingViewOutput {

      // MARK: - Properties
    var words: [Word]
    var answer: AVAudioPlayer?

      // MARK: - Init
    required init(view: TrainingViewInput, words: [Word]) {
        self.words = words
    }

      // MARK: - getNewArray
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

      // MARK: - Right Answer
    func rightAnswerAudio() {
        guard let path = Bundle.main.path(forResource: "rightAnswer.wav", ofType: nil) else { return }
        answerAudio(with: path)
    }

      // MARK: - Failed Answer
    func failedAnswerAudio() {
        guard let path = Bundle.main.path(forResource: "Fail-sound.mp3", ofType: nil) else { return }
        answerAudio(with: path)
    }

      // MARK: - Audio
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
