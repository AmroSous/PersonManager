//
//  TestData.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

@testable import PersonManager
import Foundation

struct TestData {
    
    // MARK: - Public properties
    
    static let personNames = [
        "Amro11xx", "Sous32xh"
    ]
    static let personList: [Person] = [
        .init(name: "Amro", symbol: SFSymbol.person),
        .init(name: "Ali", symbol: SFSymbol.car),
        .init(name: "Mohammad", symbol: SFSymbol.person),
        .init(name: "Anas", symbol: SFSymbol.tree),
        .init(name: "Hassan", symbol: SFSymbol.car)
    ]
    static let textToFilterAll = "hal"
    static let textToFilterPart = "hA"
    static let textToFilterNone = ""
    static let partialFilteredPersonList: [Person] = [
        personList[2], personList[4]
    ]
}
