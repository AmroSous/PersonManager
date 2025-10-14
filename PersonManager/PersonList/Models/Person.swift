//
//  Person.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Foundation

struct Person: Codable, Equatable, Identifiable {
    
    // MARK: - Public properties
    
    let id: UUID
    let name: String
    let symbol: SFSymbol
    var starred: Bool
    
    // MARK: - Life Cycle
    
    init(id: UUID = UUID(), name: String, symbol: SFSymbol, starred: Bool = false) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.starred = starred
    }
}
