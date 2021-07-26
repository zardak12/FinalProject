//
//  WorkoutViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 2/7/21.
//

import UIKit

final class WorkoutViewController: CardsViewController {

      // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Тренировка"
        self.navigationItem.rightBarButtonItem = .none
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = presenter?.frc?.object(at: indexPath)
        guard let words = item?.words?.allObjects as? [Word] else { return }
        presenter?.tapToWorkoutVC(with: words)
    }
}
