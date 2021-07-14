//
//  TrainingCollectionViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 3/7/21.
//

import UIKit

protocol QuestionDelegate : AnyObject {
    func scrollToNext()
}

final class TrainingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "identifier"
    
    
    weak var delegate : QuestionDelegate?
    
    lazy var labelName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"Helvetica-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        return button
    }()
    
    lazy var secondButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()
    
    lazy var thirdButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()
    
    lazy var fourthButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonFill")
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Helvetica", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        button.addTarget(self, action: #selector(failedAnswer), for: .touchUpInside)
        return button
    }()
    
    var buttonArray =  [UIButton]()
    
    var buttonValueArray =  [Word]()
    
    
    private var cornerRadius: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(labelName)
        contentView.addSubview(firstButton)
        contentView.addSubview(secondButton)
        contentView.addSubview(thirdButton)
        contentView.addSubview(fourthButton)
        buttonArray = [firstButton,secondButton,thirdButton,fourthButton]
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
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
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
    
    func configure(with word : Word, array : [Word]) {
        labelName.text = word.translate
        firstButton.setTitle(word.value, for: .normal)
        buttonValueArray = getNewArray(word : word, array : array)
        secondButton.setTitle(buttonValueArray[0].value, for: .normal)
        thirdButton.setTitle(buttonValueArray[1].value, for: .normal)
        fourthButton.setTitle(buttonValueArray[2].value, for: .normal)
        
    }
    
    //MARK: - Убирать!!!
    func getNewArray(word : Word, array : [Word]) -> [Word] {
        var newArray = [Word]()
        var number = 0
        
        
        while number < 3 {
            if let newWord = array.randomElement() {
                if newWord != word {
                    if !newArray.contains(newWord) {
                        newArray.append(newWord)
                        number += 1
                    }
                }
            }
        }
        return newArray
    }
    
    
    
    func updateMask() {
        let mask = CAShapeLayer()
        let path =  UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        mask.path = path
        contentView.layer.mask = mask
    }
    
    // MARK: -  Objc functions
    
    //MARK: - Убирать!!!
    @objc func rightAnswer() {
        firstButton.backgroundColor = .green
        delegate?.scrollToNext()
    }
    
    //MARK: - Убирать!!!
    @objc func failedAnswer(sender : UIButton) {
        switch sender.tag {
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
}

