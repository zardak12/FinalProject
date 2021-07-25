//
//  MockCoreDataStack.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 25.07.2021.
//

import Foundation
import CoreData
@testable import LearnEnglish

class MockCoreDataStack: CoreDataStackProtocol {

    var readContext: NSManagedObjectContext

    var writeContext: NSManagedObjectContext

    private var coordinator: NSPersistentStoreCoordinator

    init() {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        coordinator.addPersistentStore(with: description, completionHandler: { _, error in
            guard error == nil else {
                fatalError("fatal error")
            }
        })

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

private extension MockCoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            readContext.performAndWait {
                readContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}
