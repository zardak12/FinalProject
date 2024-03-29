//
//  TrainingViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 3/7/21.
//

import UIKit

final class TrainingViewController: UIViewController, TrainingViewInput {

    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = TrainingCollectionViewLayout().createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TrainingCollectionViewCell.self,
                            forCellWithReuseIdentifier: TrainingCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = Colors.backgoundFill
        collection.dataSource = self
        collection.delegate = self

        return collection
    }()

    // MARK: - TrainingViewOutput
    var presenter: TrainingViewOutput?

    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgoundFill
        view.addSubview(collectionView)
        setLayout()
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
    }

    // MARK: - Layout
    private func setLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Alert Error
    private func errorOfCountWords() {
            let alert = UIAlertController(title: "Мало слов...",
                                          message:
                                            "Вы должны иметь хотябы 5 слов чтобы пользоваться режимом тренировка ",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            present(alert, animated: true)
    }

    private func arrayIndexForRow(_ row: Int) -> Int {
        return row % (presenter?.words.count ?? 0)
    }
}

// MARK: - UICollectionViewDataSource
extension TrainingViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter?.words.count ?? 0 < 5 {
            errorOfCountWords()
            return 0
        }
        return (presenter?.words.count ?? 0) * Constants.reply
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCollectionViewCell.identifier,
                                                            for: indexPath) as? TrainingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.presenter = presenter
        let arrayIndex = arrayIndexForRow(indexPath.item)
        guard let item = presenter?.words[arrayIndex] else { return UICollectionViewCell() }
        cell.configure(with: item)
        return cell
    }
}

// MARK: - QuestionDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension TrainingViewController: QuestionDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func scrollToNext() {
        let collectionBounds = self.collectionView.bounds
        var contentOffset: CGFloat = 0
        contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
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
