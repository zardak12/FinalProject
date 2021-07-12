//
//  ViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit
import CoreData

class SliderViewController: UIViewController {
    
    private let coreDataStack = Container.shared.coreDataStack
    
    var words : [Word]
    
    var lesson : Lesson

    let reply = 50
    
    // MARK: -  колектш
    lazy var collectionView : UICollectionView = {
        let layout =  SliderCollectionViewLayout()
        let collection =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        return collection
    }()
    
    
    private lazy var settingButton : UIBarButtonItem = {
        let  image  = UIImage(systemName: "gearshape")
        let setting =   UIBarButtonItem(image: image, style: .done , target: self, action:  #selector(settings))
        setting.tintColor = .white
        return setting
    }()
    
    
    init(words : [Word], lesson : Lesson) {
        self.words = words
        self.lesson = lesson
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Circle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
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
    
    
    // MARK: -  Constraint
    func setConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20)
        ])
    }
    
    
    
    func arrayIndexForRow(_ row : Int) -> Int {
        return row % words.count
    }
    
    func createFirstWord() {
        let alertController = UIAlertController(title: "Новое слово ", message: "добавьте новое слово", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Слово"
        }
        
        alertController.addTextField { (textField) in
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
            self.coreDataStack.createWord(value: valueText, translate: translateText, lesson: self.lesson) { word in
                self.words.insert(word, at: 0)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
        
    @objc func settings() {
        let settings = SettingsViewController(with: words,lesson: lesson,delegate: self)
        navigationController?.pushViewController(settings, animated: true)
    }
    
}

extension SliderViewController: UICollectionViewDataSource {
    
    
    
    // MARK: -  Возвращает количество слов
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if words.count == 0 {
            createFirstWord()
        }
        return words.count * reply
    }
    
    // MARK: -  Регистрирует ячейку
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as! SliderCollectionViewCell
        let arrayIndex = arrayIndexForRow(indexPath.item)
        let item = words[arrayIndex]
        cell.configure(with: item)
        return cell
    }
}

extension SliderViewController : UpdateCollectionViewDelegate {
    func deleteWord(_ deleteIndex: Int) {
        words.remove(at: deleteIndex)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    func addNewWord(_ newWord: Word) {
        words.append(newWord)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}



