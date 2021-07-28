//
//  TrainingCollectionViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 3/7/21.
//

import UIKit

protocol QuestionDelegate: AnyObject {
    func scrollToNext()
}

final class TrainingCollectionViewCell: UICollectionViewCell {

    // MARK: - Identifier
    static let identifier = "identifier"

    // MARK: - TrainingViewOutput
    var presenter: TrainingViewOutput?

    // MARK: - QuestionDelegate
    weak var delegate: QuestionDelegate?

    // MARK: - UI
    private var buttonArray = [UIButton]()

    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.font = Font.helveticaBoldFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.buttonFill
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Font.helveticaButtonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        return button
    }()

    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.buttonFill
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Font.helveticaButtonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()

    private lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.buttonFill
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Font.helveticaButtonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()

    private lazy var fourthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.buttonFill
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Font.helveticaButtonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(labelName)
        contentView.addSubview(firstButton)
        contentView.addSubview(secondButton)
        contentView.addSubview(thirdButton)
        contentView.addSubview(fourthButton)
        buttonArray = [firstButton, secondButton, thirdButton, fourthButton]
        buttonArray.shuffle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bounds
    override var bounds: CGRect {
        didSet {
            updateMask()
        }
    }

    // MARK: - Layout
    private func setLayout() {
        NSLayoutConstraint.activate([
            labelName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            buttonArray[0].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[0].topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            buttonArray[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            buttonArray[1].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[1].topAnchor.constraint(equalTo: buttonArray[0].bottomAnchor, constant: 20),
            buttonArray[1].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[1].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            buttonArray[2].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[2].topAnchor.constraint(equalTo: buttonArray[1].bottomAnchor, constant: 20),
            buttonArray[2].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[2].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            buttonArray[3].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[3].topAnchor.constraint(equalTo: buttonArray[2].bottomAnchor, constant: 20),
            buttonArray[3].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[3].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            buttonArray[3].bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

      // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        firstButton.isEnabled = true
    }

    // MARK: - Configure
    func configure(with word: Word) {
        labelName.text = word.translate
        firstButton.setTitle(word.value, for: .normal)
        guard let array = presenter?.getNewArray(word: word) else { return }
        secondButton.setTitle(array[0].value, for: .normal)
        thirdButton.setTitle(array[1].value, for: .normal)
        fourthButton.setTitle(array[2].value, for: .normal)

    }

    // MARK: - Update
    private func updateMask() {
        let mask = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius).cgPath
        mask.path = path
        contentView.layer.mask = mask
    }

    // MARK: - Answers
    private func showRightAnswer() {
        firstButton.rightAnimation()
        firstButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.scrollToNext()
        }
    }

    private func showFailedAnswer(with numberButton: Int) {
        switch numberButton {
        case 1:
            secondButton.fallAnimation()
        case 2:
            thirdButton.fallAnimation()
        case 3:
            fourthButton.fallAnimation()
        default:
            print("error")
        }
    }

    // MARK: - Objective functions
    @objc func rightAnswer() {
        showRightAnswer()
        presenter?.rightAnswerAudio()
    }

    @objc func failedAnswer(sender: UIButton) {
        showFailedAnswer(with: sender.tag)
        presenter?.failedAnswerAudio()
    }
}
