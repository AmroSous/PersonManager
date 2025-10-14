//
//  PersonListViewModel.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Foundation

class PersonListViewModel {
    
    // MARK: - Public properties
    
    var filteredPersons: [Person] {
        if filterText.isEmpty { return persons }
        return persons.filter {
            $0.name.lowercased().contains(filterText.lowercased())
        }
    }
    
    // MARK: - Private properties
    
    private var persons: [Person] = []
    private var sessionManager: SessionManagerProtocol
    private var filterText = ""
    
    // MARK: - Life Cycle
    
    init(sessionManager: SessionManagerProtocol) {
        self.sessionManager = sessionManager
        loadPersonList()
    }
    
    // MARK: - Public functions
    
    func addPerson(_ person: Person) {
        if !persons.contains(where: { $0.id == person.id }) {
            persons.append(person)
        }
        setFilterText(filterText: filterText)
    }
    
    func removePerson(_ person: Person) {
        persons.removeAll { $0.id == person.id }
        setFilterText(filterText: filterText)
    }
    
    func toggleStarPerson(_ person: Person) {
        if let index = persons.firstIndex(where: { $0.id == person.id }) {
            persons[index].starred.toggle()
        }
        setFilterText(filterText: filterText)
    }

    func setFilterText(filterText: String) {
        self.filterText = filterText
    }
    
    func loadPersonList() {
        persons = sessionManager.loadPersonList()
    }
    
    func savePersonList() {
        sessionManager.storePersonList(persons)
    }
}
