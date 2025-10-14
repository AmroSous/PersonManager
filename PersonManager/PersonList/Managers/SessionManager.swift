//
//  SessionManager.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Foundation

final class SessionManager: SessionManagerProtocol {
    
    // MARK: - Public functions
    
    func storePersonList(_ personList: [Person]) {
        do {
            let data = try JSONEncoder().encode(personList)
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.personList)
        } catch {
            assertionFailure("Failed to encode people: \(error)")
        }
    }
        
    func loadPersonList() -> [Person] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.personList) else { return [] }
        do {
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            assertionFailure("Failed to decode people: \(error)")
            return []
        }
    }
}
