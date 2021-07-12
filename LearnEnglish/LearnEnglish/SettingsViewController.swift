//
//  SettingsViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 8/7/21.
//

import UIKit
import CoreData

protocol UpdateCollectionViewDelegate : AnyObject {
    func addNewWord(_ word: Word)
    func deleteWord(_ indexPath: Int)
}

class SettingsViewController: UIViewController {
    
    
    var words : [Word]
    var lesson : Lesson
    
    private let coreDataStack = Container.shared.coreDataStack
    
    var cellSpacingHeight : CGFloat = 10
    
    weak var delegate : UpdateCollectionViewDelegate?
    
    private lazy var addItem : UIBarButtonItem = {
      let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
      add.tintColor = .white
      return add
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.tableFooterView = UIView()
        table.backgroundColor = .clear
        table.dataSource =  self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        return table
        
    }()
    
    
    // MARK: -  Init
    
    init(with words : [Word], lesson : Lesson , delegate : UpdateCollectionViewDelegate) {
        self.words = words
        self.lesson = lesson
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -  Life Cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundFill")
        self.navigationItem.rightBarButtonItem = addItem
        view.addSubview(tableView)
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
      //MARK: - Layout
    
    func setLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }
    
    
    //MARK: - OBJECTIVE FUNCTION
    
    @objc func addWord() {
        let alertController = UIAlertController(title: "Введите слово и значение", message: "", preferredStyle: .alert)
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
                self.delegate?.addNewWord(word)
                self.words.append(word)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
}

  //MARK: - UITableViewDataSource
extension SettingsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,for: indexPath) as! SettingsTableViewCell
        let word = words[indexPath.section]
        cell.configure(with: word)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
        
    }
}

  //MARK: - UITableViewDelegate

extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteIndex = indexPath.section
            let word = words[indexPath.section]
            words.remove(at: deleteIndex)
            delegate?.deleteWord(deleteIndex)
            coreDataStack.deleteWord(with: word)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

