//
//  CardsViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit
import CoreData

class CardsViewController: UIViewController {
    
    private let coreDataStack = Container.shared.coreDataStack
    
    private let fontSize = UIFont.systemFont(ofSize:40)
    
    let frc: NSFetchedResultsController<Lesson> = {
        let coreDataStack = Container.shared.coreDataStack
        let request = NSFetchRequest<Lesson>(entityName: "Lesson")
        request.sortDescriptors = [.init(key: "name", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: coreDataStack.viewContext,
                                          sectionNameKeyPath: "name",
                                          cacheName: nil)
    }()
    
    //MARK: - Уроки
    
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CardsTableViewCell.self, forCellReuseIdentifier: CardsTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var addItem : UIBarButtonItem = {
        let  image  = UIImage(named: "plus")
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewLesson))
        add.tintColor = .white
        return add
    }()
    

    
    var cellSpacingHeight : CGFloat = 10
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Карточки"
        view.backgroundColor = UIColor(named: "backgroundFill")
        self.navigationItem.rightBarButtonItem = addItem
        view.addSubview(tableView)
        getConstraints()
        tableView.tableFooterView = UIView()
        frc.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? frc.performFetch()
    }
    
    func getConstraints() {
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }
    
    
    
    @objc func addNewLesson() {
        let alert = UIAlertController(title: "Введите название темы", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty  else {return}
            self.coreDataStack.createLesson(with: text)
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension CardsViewController : UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = frc.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = frc.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardsTableViewCell.identifier, for: indexPath) as! CardsTableViewCell
        cell.configure(with : item.name ?? "")
        cell.backgroundColor = UIColor(named: "foregroundFill")
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
}


extension CardsViewController : UITableViewDelegate {
    
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
        let item = frc.object(at: indexPath)
        let words = item.words?.allObjects as! [Word]
        let slider = SliderViewController(words : words, lesson : item)
        self.navigationController?.pushViewController(slider, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = frc.object(at: indexPath)
            coreDataStack.deleteLesson(with: item)
        }
    }
}

extension CardsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}

