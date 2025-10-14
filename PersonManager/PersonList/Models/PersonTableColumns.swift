//
//  PersonTableColumns.swift
//  PersonManager
//
//  Created by Amro Sous on 09/10/2025.
//

import Cocoa

enum PersonTableColumns: String, CaseIterable {
    case name
    case id
    case symbol
    case star
    
    var id: NSUserInterfaceItemIdentifier {
        return .init(self.rawValue)
    }
    
    var title: String {
        switch self {
        case .name:
            return LocalizationKey.nameColumnHeader.stringValue
        case .id:
            return LocalizationKey.idColumnHeader.stringValue
        case .symbol:
            return LocalizationKey.symbolColumnHeader.stringValue
        case .star:
            return LocalizationKey.starColumnHeader.stringValue
        }
    }
    
    var sizing: (min: CGFloat, max: CGFloat?) {
        switch self {
        case .name:
            return (50, nil)
        case .id:
            return (100, nil)
        case .symbol:
            return (50, 200)
        case .star:
            return (40, 70)
        }
    }
    
    var resizingMask: NSTableColumn.ResizingOptions {
        switch self {
        case .name:
            return [.userResizingMask]
        case .id:
            return [.userResizingMask, .autoresizingMask]
        case .symbol:
            return []
        case .star:
            return []
        }
    }
    
    var cellId: NSUserInterfaceItemIdentifier {
        switch self {
        case .name:
            return .init("PersonNameCell")
        case .id:
            return .init("PersonIDCell")
        case .symbol:
            return .init("PersonSymbolCell")
        case .star:
            return .init("PersonStarCell")
        }
    }
}
