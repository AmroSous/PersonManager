//
//  SessionManagerMock.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

@testable import PersonManager

class SessionManagerMock: SessionManagerProtocol {
    var storedPersonList: [Person] = []
    
    func storePersonList(_ personList: [PersonManager.Person]) {
        storedPersonList = personList
    }
    
    func loadPersonList() -> [PersonManager.Person] {
        return storedPersonList
    }
}
