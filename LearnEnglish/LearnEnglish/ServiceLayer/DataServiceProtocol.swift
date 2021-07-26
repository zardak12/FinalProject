//
//  DataServiceProtocol.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 26.07.2021.
//

import Foundation

// MARK: - DataServiceProtocol
protocol DataServiceProtocol: AnyObject {

    /// Load  from Coredata or Network
    func load()

    init(networkService: NetworkServiceProtocol, stack: CoreDataStackProtocol)
}
