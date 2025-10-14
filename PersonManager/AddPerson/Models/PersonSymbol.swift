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
    
    static let s = "My name is Amro Sous and I am a software engineer at Apple. I am passionate about building innovative products that make a positive impact on people's lives. I am currently working on a project that aims to help people manage their personal information and make it easier to share with others. I am excited about the opportunity to bring this project to life and make a difference in the world. Thank you for considering my application. Sincerely, Amro Sous [Your Contact Information]"
}
