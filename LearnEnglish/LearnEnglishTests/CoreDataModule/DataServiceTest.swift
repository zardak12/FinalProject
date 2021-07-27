//
//  DataServiceTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 27.07.2021.
//

import XCTest
import CoreData

class DataServiceTest: XCTestCase {
    var sut: DataServiceProtocol!
    var stack = MockCoreDataStack()
    var network: NetworkServiceProtocol!

    override func setUp() {
        super.setUp()
        let image = UIImage()
        let lessonDTO = [LessonDTO]()
        network = MockNetwork(with: lessonDTO, with: image)
        sut = DataService(networkService: network, stack: stack)
    }

    override func tearDown() {
        network = nil
        sut = nil
        super.tearDown()
    }

    func testLoad() {
        sut.load()
        let fetchRequest = NSFetchRequest<Lesson>(entityName: "Lesson")
        let objects = try? stack.readContext.fetch(fetchRequest)
        XCTAssertEqual(objects?.count, 0)
    }
}
