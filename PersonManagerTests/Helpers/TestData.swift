//
//  TestData.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

@testable import PersonManager
import Foundation

struct TestData {
    static let personName = "AM123RR123xx"
    static let personIDList: [UUID] = [
        .init(), .init(), .init(), .init(), .init()
    ]
    static let personList: [Person] = [
        .init(id: personIDList[0], name: "Amro", symbol: SFSymbol.person),
        .init(id: personIDList[1], name: "Ali", symbol: SFSymbol.car),
        .init(id: personIDList[2], name: "Mohammad", symbol: SFSymbol.person),
        .init(id: personIDList[3], name: "Anas", symbol: SFSymbol.tree),
        .init(id: personIDList[4], name: "Hassan", symbol: SFSymbol.car),
    ]
    static let personListFilterText = "hA"
    static let personListFilteredWithName: [Person] = [
        .init(id: personIDList[2], name: "Mohammad", symbol: SFSymbol.person),
        .init(id: personIDList[4], name: "Hassan", symbol: SFSymbol.car),
    ]
}
