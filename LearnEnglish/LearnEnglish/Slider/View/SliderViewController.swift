//
//  ViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit

class SliderViewController: UIViewController, SliderViewInput {

    var presenter: SliderViewOutput?

      // MARK: - UI

    lazy var collectionView: UICollectionView = {
        let layout = SliderCollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SliderCollectionViewCell.self,
                            forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
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
        presenter?.update()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundFill")
        view.addSubview(collectionView)
        self.navigationItem.rightBarButtonItem = settingButton
        setConstraint()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
    }

    // MARK: - Constraint
    func setConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    func arrayIndexForRow(_ row: Int) -> Int {
        return row % (presenter?.words?.count ?? 0)
    }

    func createFirstWord() {
        let alertController = UIAlertController(title: "Новое слово ",
                                                message: "добавьте новое слово",
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

    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @objc func settings() {
        presenter?.tapOnSettings(delegate: self)
    }

}

extension SliderViewController: UICollectionViewDataSource {

    // MARK: - Возвращает количество слов

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter?.words?.isEmpty == true {
            createFirstWord()
        }
        return (presenter?.words?.count ?? 0) * Constants.reply
    }

    // MARK: - Регистрирует ячейку

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

extension SliderViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        presenter?.swipeAudio()
    }
}

extension SliderViewController: UpdateCollectionViewDelegate {

    func addNewWord(_ newWord: Word) {
        presenter?.addWord(newWord)
    }

    func deleteWord(_ deleteIndex: Int) {
        presenter?.deleteWord(deleteIndex)
    }
}
