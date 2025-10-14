//
//  PersonSymbol.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

enum PersonSymbol: CaseIterable {
    case person
    case tree
    case car
    
    // MARK: - Public properties
    
    var displayTitle: String {
        switch self {
        case .person:
            return LocalizationKey.personSymbolDisplayTitle.stringValue
        case .car:
            return LocalizationKey.carSymbolDisplayTitle.stringValue
        case .tree:
            return LocalizationKey.treeSymbolDisplayTitle.stringValue
        }
    }
    
    var sfSymbol: SFSymbol {
        switch self {
        case .person: .person
        case .tree: .tree
        case .car: .car
        }
    }
}
