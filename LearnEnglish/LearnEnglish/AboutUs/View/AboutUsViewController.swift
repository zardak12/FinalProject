//
//  AboutUsViewController.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 10.07.2021.
//

import UIKit

class AboutUsViewController: BaseViewContoller {

      // MARK: - UI

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
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
        view.backgroundColor = UIColor(named: "backgroundFill")
        view.addSubview(nameLabel)
        view.addSubview(avaImageView)
        setLayout()
        isLoading = true
        presenter?.makeImageVisible(completion: { [weak self] result in
            guard let self = self else { return }
            self.isLoading = result
        })
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

      // MARK: - @Objc function

    @objc func goBack() { // Router
        presenter?.tapBack()
    }
}

  // MARK: - ViewInput
extension AboutUsViewController: AboutUsViewInput {
    func showAuthorImage(with image: UIImage) {
        avaImageView.image = image
    }
}
