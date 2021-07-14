//
//  TrainingViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 3/7/21.
//

import UIKit

final class TrainingViewController: UIViewController {
    
    // MARK: -  Слова
    //MARK: - Убирать!!!
    var words : [Word]
    
    let reply = 50
    
    
    // MARK: -   ColectionView
    lazy var collectionView : UICollectionView = {
        let layout =  createLayout()
        let collection =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TrainingCollectionViewCell.self, forCellWithReuseIdentifier: TrainingCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "backrgroundFill")
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    // MARK: - Init
    
    init(with words : [Word]){
        self.words = words
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundFill")
        view.addSubview(collectionView)
        setConstraint()
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
    }
    
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
    
    //MARK: - Убирать!!!
    func errorOfCountWords(){
            let alert = UIAlertController(title: "Мало слов...", message: "Вы должны иметь хотябы 5 слов чтобы пользоваться режимом тренировка ", preferredStyle: .alert)
            let ok = UIAlertAction(title:  "Ok", style: .cancel) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(ok)
            present(alert, animated: true)
    }
    
    //MARK: - Убирать!!!
    func arrayIndexForRow(_ row : Int) -> Int {
        return row % words.count
    }
}

extension TrainingViewController : UICollectionViewDataSource {
    
    // MARK: -  Возвращает количество слов
    
    //MARK: - Убирать!!!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if words.count < 5 {
            errorOfCountWords()
            return 0
        }
        return words.count * reply
    }
    
    // MARK: -  Регистрирует ячейку
    
    //MARK: - Убирать!!!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCollectionViewCell.identifier, for: indexPath) as? TrainingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let arrayIndex = arrayIndexForRow(indexPath.item)
        let item = words[arrayIndex]
        cell.configure(with : item,array : words)
        cell.delegate = self
        return cell
    }
    
      //MARK: - Это мы уберем
    
    //MARK: - Убирать!!!
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        return layout
    }
}


extension TrainingViewController : QuestionDelegate , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func scrollToNext() {
        let collectionBounds = self.collectionView.bounds
        var contentOffset: CGFloat = 0
        contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
}


