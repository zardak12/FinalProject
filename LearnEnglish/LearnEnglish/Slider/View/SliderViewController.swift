//
//  ViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit

final class SliderViewController: UIViewController, SliderViewInput {

    // MARK: - SliderViewOutput
    var presenter: SliderViewOutput?

    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = SliderCollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SliderCollectionViewCell.self,
                            forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        return collection
    }()

    private lazy var settingButton: UIBarButtonItem = {
        let  image  = UIImage(systemName: "gearshape")
        let setting = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(settings))
        setting.tintColor = .white
        return setting
    }()

    // MARK: - Life Circle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }

      // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgoundFill
        view.addSubview(collectionView)
        self.navigationItem.rightBarButtonItem = settingButton
        setLayout()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
    }

    // MARK: - Layout
    private func setLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    private func arrayIndexForRow(_ row: Int) -> Int {
        return row % (presenter?.words?.count ?? 0)
    }

    // MARK: - Create First Word
    private func createFirstWord() {
        let alertController = UIAlertController(title: "Введите слово и значение",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Слово"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Перевод"
        }

        let add = UIAlertAction(title: "Add", style: .default) { _ in
            guard let value = alertController.textFields?[0],
                  let translate = alertController.textFields?[1],
                  let valueText = value.text, !valueText.isEmpty,
                  let translateText = translate.text, !translateText.isEmpty
            else {
                return
            }
            guard let lesson = self.presenter?.lesson else { return }
            self.presenter?.createWord(value: valueText, translate: translateText, lesson: lesson)
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }

    // MARK: - SliderViewInput
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Alert
    func showErrorAlert() {
        let alertError = UIAlertController(title: "Уже есть...",
                                           message: "Такое слово уже существует. Введите другое слово",
                                           preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertError, animated: true)
    }

    // MARK: - Objective Function
    @objc func settings() {
        presenter?.tapOnSettings(delegate: self)
    }
}

// MARK: - UICollectionViewDataSource
extension SliderViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter?.words?.isEmpty == true {
            createFirstWord()
        }
        return (presenter?.words?.count ?? 0) * Constants.reply
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier,
                                                            for: indexPath) as? SliderCollectionViewCell else {
            return UICollectionViewCell()
        }
        let arrayIndex = arrayIndexForRow(indexPath.item)
        guard let item = presenter?.words?[arrayIndex] else { return UICollectionViewCell() }
        cell.presenter = presenter
        presenter?.cell = cell
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UpdateCollectionViewDelegate
extension SliderViewController: UpdateCollectionViewDelegate {

    func addNewWord(_ newWord: Word) {
        presenter?.addWord(newWord)
    }

    func deleteWord(_ deleteIndex: Int) {
        presenter?.deleteWord(deleteIndex)
    }

    func scrollToNext() {
        let collectionBounds = self.collectionView.bounds
        var contentOffset: CGFloat = 0
        contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + 25 * collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset: CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset,
                                   y: self.collectionView.contentOffset.y,
                                   width: self.collectionView.frame.width,
                                   height: self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }

}
