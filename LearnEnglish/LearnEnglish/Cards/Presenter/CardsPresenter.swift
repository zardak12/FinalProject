//
//  CardsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit
import CoreData

// MARK: - CardsViewInput
protocol CardsViewInput: AnyObject {

    /// show Alert with Error
    func showErrorAlert()
}

// MARK: - CardsViewOutput
protocol CardsViewOutput: AnyObject {
    var frc: NSFetchedResultsController<Lesson>? { get set }
    init(view: CardsViewInput, router: MenuRouterProtocol, coreDataService: CoreDataServiceProtocol)
    func fetch()

    /// Creating a lesson
    /// - Parameter name: name of the lesson
    func createLesson(with name: String)

    /// Delete a lesson
    /// - Parameter lesson: Lesson Entity
    func deleteLesson(with lesson: Lesson)

    /// Switch to SliderViewController
    /// - Parameter lesson: Lesson Entity
    func tapToSliderVC(lesson: Lesson)

    /// Switch to TrainingViewController
    /// - Parameter words: Word Entity
    func tapToWorkoutVC(with words: [Word])
}

// MARK: - CardsPresenter
final class CardsPresenter: CardsViewOutput {

    weak var view: CardsViewInput?
    var frc: NSFetchedResultsController<Lesson>?
    var router: MenuRouterProtocol
    var coreDataService: CoreDataServiceProtocol

    // MARK: - Init
    required init(view: CardsViewInput, router: MenuRouterProtocol, coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.router = router
        self.coreDataService = coreDataService
        self.frc = createFetchResultController()
    }

      // MARK: - FetchResultController
    func createFetchResultController() -> NSFetchedResultsController<Lesson> {
        let request = NSFetchRequest<Lesson>(entityName: "Lesson")
        request.sortDescriptors = [.init(key: "name", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: coreDataService.stack.readContext,
                                          sectionNameKeyPath: "name",
                                          cacheName: nil)
    }

    func fetch() {
        try? frc?.performFetch()
    }

    // MARK: - Lesson
    func createLesson(with name: String) {
        let result = coreDataService.createLesson(with: name)
        if result == false {
            view?.showErrorAlert()
        }
    }

    func deleteLesson(with lesson: Lesson) {
        coreDataService.deleteLesson(with: lesson)
    }

    // MARK: - Router
    func tapToSliderVC(lesson: Lesson) {
        router.showSliderController(lesson: lesson)
    }

    func tapToWorkoutVC(with words: [Word]) {
        router.showTrainingVC(with: words)
    }
}
