//
//  CardsPresenter.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit
import CoreData

protocol CardsViewOutput: AnyObject {
    var frc: NSFetchedResultsController<Lesson>? { get set}
    init(view: CardsViewInput,router: MenuRouterProtocol)
    func fetch()
    func createLesson(with name: String)
    func deleteLesson(with lesson: Lesson)
    func tapToSliderVC(with words: [Word], lesson: Lesson)
    func tapToWorkoutVC(with words: [Word])
}

class CardsPresenter: CardsViewOutput {
    
    weak var view: CardsViewInput?
    let coreDataStack = Container.shared.coreDataStack
    var frc: NSFetchedResultsController<Lesson>?
    var router: MenuRouterProtocol
    
    
    
    required init(view: CardsViewInput,router: MenuRouterProtocol) {
        self.view = view
        self.router = router
        self.frc = createFetchResultController()
    }
    
    func createFetchResultController() -> NSFetchedResultsController<Lesson> {
        let request = NSFetchRequest<Lesson>(entityName: "Lesson")
        request.sortDescriptors = [.init(key: "name", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: coreDataStack.viewContext,
                                          sectionNameKeyPath: "name",
                                          cacheName: nil)
    }
    
    func fetch() {
        try? frc?.performFetch()
    }
    
    func createLesson(with name: String) {
        coreDataStack.createLesson(with: name)
    }
    
    func deleteLesson(with lesson: Lesson) {
        coreDataStack.deleteLesson(with: lesson)
    }
    
    func tapToSliderVC(with words: [Word], lesson: Lesson) {
        router.showSliderController(with: words, lesson: lesson)
    }
    
    
    func tapToWorkoutVC(with words: [Word]) {
        router.showTrainingVC(with: words)
    }
}
