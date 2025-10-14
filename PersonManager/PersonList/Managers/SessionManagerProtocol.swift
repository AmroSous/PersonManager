//
//  SessionManagerProtocol.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

protocol SessionManagerProtocol {
    func storePersonList(_ personList: [Person])
    func loadPersonList() -> [Person]
}
