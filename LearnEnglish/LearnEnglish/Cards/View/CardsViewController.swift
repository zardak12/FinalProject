//
//  CardsViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit
import CoreData

class CardsViewController: UIViewController, CardsViewInput {

    // MARK: - Уроки

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CardsTableViewCell.self, forCellReuseIdentifier: CardsTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        return table
    }()

    private lazy var addItem: UIBarButtonItem = {
        let  image = UIImage(named: "plus")
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewLesson))
        add.tintColor = .white
        return add
    }()

    var presenter: CardsViewOutput?

    private var cellSpacingHeight: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Карточки"
        view.backgroundColor = Colors.backgoundFill
        self.navigationItem.rightBarButtonItem = addItem
        view.addSubview(tableView)
        setLayout()
        presenter?.frc?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetch()
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    func showErrorAlert() {
        let alertError = UIAlertController(title: "Уже есть...",
                                           message: "Такая тема уже существует. Введите другую тему",
                                           preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertError, animated: true)
    }

    @objc func addNewLesson() {
        let alert = UIAlertController(title: "Введите название темы", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty  else { return }
            self.presenter?.createLesson(with: text)
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension CardsViewController: UITableViewDataSource {

    // MARK: - Presenter ViewOutput
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.frc?.sections?.count ?? 0
    }
    // MARK: - Presenter ViewOutput
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = presenter?.frc?.sections else { return 0 }
        return sections[section].numberOfObjects
    }

    // MARK: - Presenter ViewOutput
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter?.frc?.object(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardsTableViewCell.identifier,
                                                       for: indexPath) as? CardsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: item?.name ?? "")
        cell.backgroundColor = Colors.foregroundFill
        cell.clipsToBounds = true
        return cell
    }

}

extension CardsViewController: UITableViewDelegate {

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
        guard let item = presenter?.frc?.object(at: indexPath) else { return }
        presenter?.tapToSliderVC(lesson: item)
    }

    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let item = presenter?.frc?.object(at: indexPath) else { return }
            presenter?.deleteLesson(with: item)
        }
    }
}

extension CardsViewController: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}
