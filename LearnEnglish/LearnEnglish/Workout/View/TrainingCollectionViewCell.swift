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

    static let identifier = "identifier"

    var presenter: TrainingViewOutput?
    var buttonArray = [UIButton]()
    weak var delegate: QuestionDelegate?

    lazy var labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        return button
    }()

    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()

    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()

    lazy var fourthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()

    private var cornerRadius: CGFloat = 10

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
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var bounds: CGRect {
        didSet {
            updateMask()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        firstButton.backgroundColor = UIColor(named: "buttonFill")
        secondButton.backgroundColor = UIColor(named: "buttonFill")
        thirdButton.backgroundColor = UIColor(named: "buttonFill")
        fourthButton.backgroundColor = UIColor(named: "buttonFill")
    }

    func layout() {
        NSLayoutConstraint.activate([
            labelName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            labelName.bottomAnchor.constraint(equalTo: firstButton.topAnchor, constant: -10)

        ])

        NSLayoutConstraint.activate([
            buttonArray[0].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            buttonArray[1].topAnchor.constraint(equalTo: buttonArray[0].bottomAnchor, constant: 20),
            buttonArray[1].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[1].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[1].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            buttonArray[2].topAnchor.constraint(equalTo: buttonArray[1].bottomAnchor, constant: 20),
            buttonArray[2].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[2].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[2].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            buttonArray[3].topAnchor.constraint(equalTo: buttonArray[2].bottomAnchor, constant: 20),
            buttonArray[3].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonArray[3].bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            buttonArray[3].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            buttonArray[3].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }

    func configure(with word: Word) {
        labelName.text = word.translate
        firstButton.setTitle(word.value, for: .normal)
        guard let array = presenter?.getNewArray(word: word) else { return }
        secondButton.setTitle(array[0].value, for: .normal)
        thirdButton.setTitle(array[1].value, for: .normal)
        fourthButton.setTitle(array[2].value, for: .normal)

    }

    func updateMask() {
        let mask = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        mask.path = path
        contentView.layer.mask = mask
    }

      // MARK: - TrainingViewCell

    func showRightAnswer() {
        firstButton.rightAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.scrollToNext()
        }
    }

    func showFailedAnswer(with numberButton: Int) {
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

    // MARK: - Objc functions

    @objc func rightAnswer() {
        showRightAnswer()
        presenter?.rightAnswerAudio()
    }

    @objc func failedAnswer(sender: UIButton) {
        showFailedAnswer(with: sender.tag)
        presenter?.failedAnswerAudio()
    }
}
