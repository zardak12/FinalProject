//
//  Word+CoreDataProperties.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 30.06.2021.
//
//

import Foundation
import CoreData

extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var translate: String?
    @NSManaged public var value: String?
    @NSManaged public var lesson: Lesson?

}

extension Word: Identifiable {

}
