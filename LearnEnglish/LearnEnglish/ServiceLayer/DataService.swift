//
//  DataService.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 15.07.2021.
//

import Foundation
import CoreData

protocol DataServiceProtocol: AnyObject {
    func load()
    init(networkService: NetworkServiceProtocol)
}

class DataService: DataServiceProtocol {

    let networkService: NetworkServiceProtocol
    private let coreDataStack = Container.shared.coreDataStack
    let request = NSFetchRequest<Lesson>(entityName: "Lesson")
    let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()

    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

      // MARK: - Загрузка данных

  func load() {
    coreDataStack.load()
    let viewContext = coreDataStack.viewContext
    viewContext.performAndWait {
        guard let objects = try? viewContext.fetch(fetchRequest) else { return }
        if objects.isEmpty {
        networkService.getLessons { result in
            switch result {
            case .success(let responce):
                for lesson in responce {
                    let lessonEntity = Lesson(context: viewContext)
                    lessonEntity.name = lesson.name
                    guard let words = lesson.words else { return }
                    for word in words {
                        let wordEntity = Word(context: viewContext)
                        wordEntity.value = word.value
                        wordEntity.translate = word.translate
                        lessonEntity.addToWords(wordEntity)
                    }
                }
                try? viewContext.save()
            case .failure(let error):
                print(error)
            }
        }
      }
    }
  }
}
