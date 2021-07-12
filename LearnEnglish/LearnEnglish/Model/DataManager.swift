//
//  DataManager.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 27.06.2021.
//

import Foundation
import CoreData

protocol DataManagerProtocol : AnyObject{
    func load()
}

class DataManager: DataManagerProtocol {
    
    let network = NetworkContainer.shared
    private let coreDataStack = Container.shared.coreDataStack
    let request = NSFetchRequest<Lesson>(entityName: "Lesson")
    let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()

      //MARK: - Загрузка данных
  func load() {
    coreDataStack.load()
    let viewContext = coreDataStack.viewContext
    viewContext.performAndWait {
      let objects = try? viewContext.fetch(fetchRequest)
      if objects?.count == 0{
        network.getLessons { (result) in
                for lesson in result.lessons {
                    let lessonEntity = Lesson(context: viewContext)
                    lessonEntity.name = lesson.fields.name.stringValue
                    for word in lesson.fields.words.arrayValue.values {
                        let wordEntity = Word(context: viewContext)
                        wordEntity.value = word.mapValue.fields.value.stringValue
                        wordEntity.translate = word.mapValue.fields.translate.stringValue
                        lessonEntity.addToWords(wordEntity)
                    }
                }
              try? viewContext.save()
        }
      }
    }
  }
  
  
    func delete() {
        coreDataStack.deleteAll()
    }
}

