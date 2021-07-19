//
//  SnapshotTest.swift
//  LearnEnglishTests
//
//  Created by Марк Шнейдерман on 19.07.2021.
//

import SnapshotTesting
import XCTest
@testable import LearnEnglish

class SnapshotTest: XCTestCase {

    func testAboutUsVC() throws {
        let aboutUsVc = AssemblyBuilder().createAboutUs()
        assertSnapshot(matching: aboutUsVc, as: .image(on: .iPhone8))
    }
}
