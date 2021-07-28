//
//  SnapshotTest.swift
//  LearnEnglishSnapshotTests
//
//  Created by Марк Шнейдерман on 24.07.2021.
//

import XCTest
import SnapshotTesting
@testable import LearnEnglish

class SnapshotTest: XCTestCase {

    func testCardVC() throws {
        /// Add isRecording = true if first time, after write  isRecording = false
        let cardVC = AssemblyBuilder().createCards()
        assertSnapshot(matching: cardVC, as: .image(on: .iPhone8))
    }
}
