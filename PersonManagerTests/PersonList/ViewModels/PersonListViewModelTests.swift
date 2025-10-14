//
//  PersonListViewModelTests.swift
//  PersonManagerTests
//
//  Created by Amro Sous on 13/10/2025.
//

import XCTest
@testable import PersonManager

final class PersonListViewModelTests: XCTestCase {
    
    // MARK: - Private properties
    
    private var viewModel: PersonListViewModel!
    private var sessionManager: SessionManagerMock!
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sessionManager = SessionManagerMock()
        viewModel = PersonListViewModel(sessionManager: sessionManager)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    
    func testAddPersonAppendsAndAppearsInFiltered() throws {
        let person = Person(name: TestData.personName, symbol: SFSymbol.car)
        viewModel.addPerson(person)
        XCTAssertEqual(viewModel.filteredPersons, [person])
    }
    
    func testAddPersonDoesNotDuplicateSameID() throws {
        let id = UUID()
        let person1 = Person(id: id, name: TestData.personName, symbol: SFSymbol.car)
        let person2 = Person(id: id, name: TestData.personName, symbol: SFSymbol.car)
        viewModel.addPerson(person1)
        viewModel.addPerson(person2)
        XCTAssertEqual(viewModel.filteredPersons.count, 1)
        XCTAssertEqual(viewModel.filteredPersons.first?.id, id)
    }
    
    func testRemovePersonRemovesAndDoesNotAppearInFiltered() throws {
        let person = Person(name: TestData.personName, symbol: SFSymbol.car)
        viewModel.addPerson(person)
        viewModel.removePerson(person)
        XCTAssertEqual(viewModel.filteredPersons, [])
    }
    
    func testToggleStarPersonUpdatesStarred() throws {
        let id = UUID()
        let person = Person(id: id, name: TestData.personName, symbol: SFSymbol.car)
        viewModel.addPerson(person)
        viewModel.toggleStarPerson(person)
        let personElement = viewModel.filteredPersons.first(where: { $0.id == id })
        XCTAssertNotNil(personElement)
        XCTAssertTrue(personElement!.starred)
    }
    
    func testFilterPersonsByNameIgnoringCase() throws {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.filterPersons(filterText: TestData.personListFilterText)
        XCTAssertEqual(viewModel.filteredPersons, TestData.personListFilteredWithName)
    }
    
    func testSavePersonListSavesInSessionManager() throws {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.savePersonList()
        XCTAssertEqual(viewModel.filteredPersons, sessionManager.storedPersonList)
    }
}
