//
//  CoreDataStack.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 26.06.2021.
//


import Foundation
import CoreData

final class CoreDataStack { 
    
    private let container: NSPersistentContainer
    
    init(modelName: String) {
        let container = NSPersistentContainer(name: modelName)
        self.container = container
    }
    
    
    func load() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    
    func createLesson(with name : String){
        let lesson = Lesson(context: viewContext)
        lesson.name = name
        try? viewContext.save()
    }
    
//    func createWord(value : String,translate : String, lesson : Lesson
//                    , completion: @escaping (Word) -> Void) {
//        let word = Word(context: viewContext)
//        word.value = value
//        word.translate = translate
//        lesson.addToWords(word)
//        try? viewContext.save()
//        completion(word)
//    }
    
    func createWord(value : String,translate : String, lesson : Lesson) {
        let word = Word(context: viewContext)
        word.value = value
        word.translate = translate
        lesson.addToWords(word)
        try? viewContext.save()
    }
    
    func deleteWord(with word : Word) {
        viewContext.delete(word)
        try? viewContext.save()
    }
    
    func deleteLesson(with lesson: Lesson) {
        viewContext.delete(lesson)
        try? viewContext.save()
    }
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Lesson")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? coordinator.execute(deleteRequest, with: backgroundContext)
    }
    
    var viewContext: NSManagedObjectContext { container.viewContext }
    lazy var backgroundContext: NSManagedObjectContext = container.newBackgroundContext()
    var coordinator: NSPersistentStoreCoordinator { container.persistentStoreCoordinator }
}

