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
    init(networkService: NetworkServiceProtocol, stack: CoreDataStack)
}

final class DataService: DataServiceProtocol {

    private let networkService: NetworkServiceProtocol
    private let stack: CoreDataStack
    private let request = NSFetchRequest<Lesson>(entityName: "Lesson")
    private let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()

    required init(networkService: NetworkServiceProtocol, stack: CoreDataStack) {
        self.networkService = networkService
        self.stack = stack
    }

      // MARK: - Загрузка данных

  func load() {
    let writeContext = stack.writeContext
    writeContext.performAndWait {
        guard let objects = try? writeContext.fetch(fetchRequest) else { return }
        if objects.isEmpty {
        networkService.getLessons { result in
            switch result {
            case .success(let responce):
                for lesson in responce {
                    let lessonEntity = Lesson(context: writeContext)
                    lessonEntity.name = lesson.name
                    guard let words = lesson.words else { return }
                    for word in words {
                        let wordEntity = Word(context: writeContext)
                        wordEntity.value = word.value
                        wordEntity.translate = word.translate
                        lessonEntity.addToWords(wordEntity)
                    }
                }
                try? writeContext.save()
            case .failure(let error):
                print(error)
            }
        }
      }
    }
  }
}
