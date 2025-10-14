//
//  DummyDataGenerator.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

final class DummyDataGenerator {
    
    // MARK: - Public functions
    
    static func generateDummyPersonList() -> [Person] {
        return [
            Person(name: "Amro", symbol: SFSymbol.person),
            Person(name: "Rasheed", symbol: SFSymbol.car),
            Person(name: "Mohammad", symbol: SFSymbol.person),
            Person(name: "Karen", symbol: SFSymbol.tree),
            Person(name: "Sarah", symbol: SFSymbol.car)
        ]
    }
}
