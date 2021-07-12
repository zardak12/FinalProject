//
//  WorkoutViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 2/7/21.
//

import UIKit

final class WorkoutViewController: CardsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Тренировка"
        self.navigationItem.rightBarButtonItem = .none
    }
    
    
    // MARK: -  Переопределяю метод и просто напрявляю на другой ViewContoller
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = frc.object(at: indexPath)
        let words = item.words?.allObjects as! [Word]
        let trainingController = TrainingViewController(with: words)
        self.navigationController?.pushViewController(trainingController, animated: true)
    }
}

