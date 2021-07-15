//
//  CardsTableViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 4/7/21.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    static let identifier = "identifier"

    private let fontSize = UIFont.systemFont(ofSize: 20)

    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 25)
        return title
    }()

    private let addToHeight: CGFloat = 16
    private let titleLabelTopAndBottomAnchor: CGFloat = 8
    private let titleLabelLeangdAndTrailingAnchor: CGFloat = 5

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: titleLabelTopAndBottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -titleLabelTopAndBottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)

        ])
    }

    func configure(with text: String) {
        titleLabel.text = text
        titleLabel.textColor = .white
    }

}
