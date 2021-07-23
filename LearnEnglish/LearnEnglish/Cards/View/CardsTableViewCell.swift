//
//  CardsTableViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 4/7/21.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    static let identifier = "identifier"

    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = Font.boldSystemFont
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = Constants.cornerRadius
    }

    // MARK: - Layout
    func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)

        ])
    }

    func configure(with text: String) {
        titleLabel.text = text
        titleLabel.textColor = .white
    }
}
