//
//  SettingsViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 8/7/21.
//

import UIKit

final class SettingsViewController: UIViewController, SettingsViewInput {

    var presenter: SettingsViewOutput?

    private var cellSpacingHeight: CGFloat = 10

    private lazy var addItem: UIBarButtonItem = {
      let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
      add.tintColor = .white
      return add
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()

        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.tableFooterView = UIView()
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        return table

    }()

    // MARK: - Life Cyrcle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.backgoundFill
        self.navigationItem.rightBarButtonItem = addItem
        view.addSubview(tableView)
        setLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.update()
    }

      // MARK: - Layout

    private func setLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - OBJECTIVE FUNCTION

    @objc func addWord() {
        let alertController = UIAlertController(title: "Введите слово и значение", message: "", preferredStyle: .alert)
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

      // MARK: - SettingsViewInput
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showErrorAlert() {
        let alertError = UIAlertController(title: "Уже есть...",
                                           message: "Такое слово уже существует. Введите другое слово",
                                           preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertError, animated: true)
    }

}

  // MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.words.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                       for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        guard let word = presenter?.words[indexPath.section] else { return UITableViewCell() }
        cell.configure(with: word)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = Constants.cornerRadius
        cell.clipsToBounds = true
        return cell

    }
}

  // MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
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

    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteIndex = indexPath.section
            guard let word = presenter?.words[indexPath.section] else { return }
            presenter?.deleteWord(wtih: word, deleteIndex)
        }
    }

}
