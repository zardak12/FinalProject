//
//  ProfileViewController.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 09.07.2021.
//

import UIKit

final class ProfileViewController: UIViewController {

      // MARK: - UI

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(imageTap)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var tapToChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .clear
        field.textColor = .white
        field.placeholder = "Как вас зовут?"
        let placeholderText = NSAttributedString(string: "Как вас зовут?",
                                                 attributes:
                                                    [NSAttributedString.Key.foregroundColor:
                                                        UIColor(named: "placeholderFill") as Any])
        field.attributedPlaceholder = placeholderText
        field.font = UIFont.boldSystemFont(ofSize: 30)
        return field
    }()

    private lazy var imagePicker: UIImagePickerController = {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      return imagePicker
    }()

    private lazy var aboutProjectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = button.bounds.height / 2
        button.backgroundColor = .clear
        button.setTitle("About us", for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.addTarget(self, action: #selector(showAboutUs), for: .touchUpInside)
        return button
    }()

      // MARK: - ViewOutput

    var presenter: ProfileViewOutput?

      // MARK: - Life Cyrcle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Профиль"
        view.backgroundColor = UIColor(named: "backgroundFill")
        view.addSubview(imageView)
        view.addSubview(tapToChangeLabel)
        view.addSubview(nameTextField)
        view.addSubview(aboutProjectButton)
        setUpLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.checkImage()
        presenter?.checkName()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }

      // MARK: - Layout

    func setUpLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 125),
            imageView.widthAnchor.constraint(equalToConstant: 125)
        ])

        NSLayoutConstraint.activate([
            tapToChangeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            tapToChangeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: tapToChangeLabel.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            aboutProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            aboutProjectButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])

    }

      // MARK: - Objc fucntions

    @objc func openImagePicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func showAboutUs() {
        presenter?.tapOnAboutUsVC()
    }

}

  // MARK: - ViewInput

extension ProfileViewController: ProfileViewInput {
    func showAvaImage(with image: UIImage, with text: String) {
        imageView.image = image
        tapToChangeLabel.text = text
    }

    func showName(with name: String) {
        nameTextField.text = name
    }
}

  // MARK: - UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            if let text = textField.text {
                presenter?.saveName(with: text)

            }
            nameTextField.resignFirstResponder()
        }
        return true
    }
}

  // MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      guard let image = info[.editedImage] as? UIImage else { return }
      presenter?.saveImage(with: image)
      dismiss(animated: true, completion: nil)
    }
}
