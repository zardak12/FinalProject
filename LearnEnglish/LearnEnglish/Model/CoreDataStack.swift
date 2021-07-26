//
//  CoreDataStack.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 26.06.2021.
//

import Foundation
import CoreData

// MARK: - CoreDataStackProtocol
protocol CoreDataStackProtocol {
    var readContext: NSManagedObjectContext { get set }
    var writeContext: NSManagedObjectContext { get set }
}

// MARK: - CoreDataStack
final class CoreDataStack: CoreDataStackProtocol {

    var readContext: NSManagedObjectContext
    var writeContext: NSManagedObjectContext

    private let coordinator: NSPersistentStoreCoordinator
    private let objectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "Lessons", withExtension: "momd") else {
            fatalError("CoreDataStack: CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("CoreDataStack: CoreData MOMD is nil")
        }
        return model
    }()

    init() {

        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                      .userDomainMask, true).first else {
            fatalError("Documents is nil")
        }

        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("LearnEnglish.sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)

        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: url,
                                               options: [NSMigratePersistentStoresAutomaticallyOption: true,
                                                        NSInferMappingModelAutomaticallyOption: true])
        } catch {
            fatalError("AddPersistentStore failure")
        }

        self.coordinator = coordinator

        self.readContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.readContext.persistentStoreCoordinator = coordinator

        self.writeContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.writeContext.persistentStoreCoordinator = coordinator

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.writeContext)

    }
}

private extension CoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            readContext.performAndWait {
                readContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}
