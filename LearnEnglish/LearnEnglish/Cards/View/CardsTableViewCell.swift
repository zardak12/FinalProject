//
//  CardsTableViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 4/7/21.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    static let identifier = "identifier"

      // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = Font.boldSystemFont
        return title
    }()

      // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = Constants.cornerRadius
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)

        ])
    }

      // MARK: - Configure
    func configure(with text: String) {
        titleLabel.text = text
        titleLabel.textColor = .white
    }
}
