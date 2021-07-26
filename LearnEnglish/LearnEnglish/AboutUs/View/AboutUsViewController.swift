//
//  AboutUsViewController.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 10.07.2021.
//

import UIKit

final class AboutUsViewController: BaseViewController {

    // MARK: - UI
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.helveticaButtonFont
        label.textColor = .white
        label.text = "Автор проекта: Марк Шнейдерман"
        label.sizeToFit()
        return label
    }()

    lazy var avaImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(goBack))
        return button
    }()

    // MARK: - ViewOutput
    var presenter: AboutUsViewOutput?

    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.backgroundColor = Colors.backgoundFill
        view.addSubview(nameLabel)
        view.addSubview(avaImageView)
        setLayout()
        loadData()
    }

    // MARK: - Constraints
    private func  setLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            avaImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            avaImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            avaImageView.widthAnchor.constraint(equalToConstant: 300),
            avaImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    // MARK: - Load Data
    func loadData() {
        isLoading = true
        presenter?.makeImageVisible(completion: { result in
            self.isLoading = result
        })
    }

    // MARK: - @Objective function
    @objc func goBack() {
        presenter?.tapBack()
    }
}

// MARK: - ViewInput
extension AboutUsViewController: AboutUsViewInput {
    func showAuthorImage(with image: UIImage) {
        avaImageView.image = image
    }
}
