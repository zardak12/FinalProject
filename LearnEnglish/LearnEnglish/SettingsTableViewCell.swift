//
//  SettingsTableViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 8/7/21.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {

    static let identifier = "identifier"

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.helveticaBoldFont
        label.textColor = .black
        return label
    }()

    private lazy var translateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.helveticaFont
        label.textColor = Colors.placeholderFill
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(valueLabel)
        contentView.addSubview(translateLabel)
        setLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = Constants.cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setLayout() {
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10 ),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            valueLabel.bottomAnchor.constraint(equalTo: translateLabel.topAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            translateLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5),
            translateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10 ),
            translateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            translateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    func configure(with word: Word) {
        valueLabel.text = word.value
        translateLabel.text = word.translate
    }

}
