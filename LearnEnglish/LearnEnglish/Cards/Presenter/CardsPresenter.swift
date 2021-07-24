//
//  CardsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit
import CoreData

protocol CardsViewInput: AnyObject {
    func showErrorAlert()
}

protocol CardsViewOutput: AnyObject {
    var frc: NSFetchedResultsController<Lesson>? { get set }
    init(view: CardsViewInput, router: MenuRouterProtocol, coreDataService: CoreDataServiceProtocol)
    func fetch()
    func createLesson(with name: String)
    func deleteLesson(with lesson: Lesson)
    func tapToSliderVC(lesson: Lesson)
    func tapToWorkoutVC(with words: [Word])
}

class CardsPresenter: CardsViewOutput {

    weak var view: CardsViewInput?
    var frc: NSFetchedResultsController<Lesson>?
    var router: MenuRouterProtocol
    var coreDataService: CoreDataServiceProtocol

    required init(view: CardsViewInput, router: MenuRouterProtocol, coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.router = router
        self.coreDataService = coreDataService
        self.frc = createFetchResultController()
    }

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

    func createLesson(with name: String) {
        let result = coreDataService.createLesson(with: name)
        if result == false {
            view?.showErrorAlert()
        }
    }

    func deleteLesson(with lesson: Lesson) {
        coreDataService.deleteLesson(with: lesson)
    }

    func tapToSliderVC(lesson: Lesson) {
        router.showSliderController(lesson: lesson)
    }

    func tapToWorkoutVC(with words: [Word]) {
        router.showTrainingVC(with: words)
    }
}
