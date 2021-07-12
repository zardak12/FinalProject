//
//  Lesson+CoreDataProperties.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 30.06.2021.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var name: String?
    @NSManaged public var words: NSSet?

}

// MARK: Generated accessors for words
extension Lesson {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: Word)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: Word)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}

extension Lesson : Identifiable {

}
