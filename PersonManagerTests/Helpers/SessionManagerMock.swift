//
//  SessionManagerMock.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

@testable import PersonManager

class SessionManagerMock: SessionManagerProtocol {
    
    // MARK: - Public properties
    
    var storedPersonList: [Person] = []
    
    // MARK: - Public functions
    
    func storePersonList(_ personList: [PersonManager.Person]) {
        storedPersonList = personList
    }
    
    func loadPersonList() -> [PersonManager.Person] {
        return storedPersonList
    }
}
