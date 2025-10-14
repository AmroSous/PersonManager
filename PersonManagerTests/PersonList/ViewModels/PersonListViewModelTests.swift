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
    
    func testAddPersonWhenNewID() {
        let person = Person(name: TestData.personNames[0], symbol: SFSymbol.car)
        XCTAssertFalse(viewModel.filteredPersons.contains(where: { $0.id == person.id }))
        viewModel.addPerson(person)
        XCTAssertTrue(viewModel.filteredPersons.contains(where: { $0.id == person.id }))
    }
    
    func testAddPersonWhenDuplicateID() {
        let person1 = Person(name: TestData.personNames[0], symbol: SFSymbol.car)
        let person2 = Person(id: person1.id, name: TestData.personNames[1], symbol: SFSymbol.car)
        viewModel.addPerson(person1)
        XCTAssertEqual(viewModel.filteredPersons.count, 1)
        viewModel.addPerson(person2)
        XCTAssertEqual(viewModel.filteredPersons, [person1])
    }
    
    func testRemovePersonWhenPersonExist() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        XCTAssertEqual(viewModel.filteredPersons.count, TestData.personList.count)
        viewModel.removePerson(TestData.personList[0])
        XCTAssertEqual(viewModel.filteredPersons.count, TestData.personList.count - 1)
        XCTAssertFalse(viewModel.filteredPersons.contains(where: { $0.id == TestData.personList[0].id }))
    }
    
    func testRemovePersonWhenPersonDoesNotExist() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        XCTAssertEqual(viewModel.filteredPersons.count, TestData.personList.count)
        let personToRemove = Person(name: TestData.personNames[0], symbol: SFSymbol.car)
        viewModel.removePerson(personToRemove)
        XCTAssertEqual(viewModel.filteredPersons.count, TestData.personList.count)
    }
    
    func testToggleStarPersonWhenStarredIsFalse() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.toggleStarPerson(TestData.personList[0])
        let toggledPerson = viewModel.filteredPersons.first(where: { $0.id == TestData.personList[0].id })
        XCTAssertNotNil(toggledPerson)
        XCTAssertTrue(toggledPerson!.starred)
    }
    
    func testToggleStarPersonWhenStarredIsTrue() {
        let person = Person(name: TestData.personNames[0], symbol: SFSymbol.car, starred: true)
        viewModel.addPerson(person)
        viewModel.toggleStarPerson(person)
        let toggledPerson = viewModel.filteredPersons.first(where: { $0.id == person.id })
        XCTAssertNotNil(toggledPerson)
        XCTAssertFalse(toggledPerson!.starred)
    }
    
    func testFilterPersonsByNameIgnoringCaseWithEmptyResults() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.setFilterText(filterText: TestData.textToFilterAll)
        XCTAssertTrue(viewModel.filteredPersons.isEmpty)
    }
    
    func testFilterPersonsByNameIgnoringCaseWithAllDataReturned() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.setFilterText(filterText: TestData.textToFilterNone)
        XCTAssertEqual(viewModel.filteredPersons, TestData.personList)
    }
    
    func testFilterPersonsByNameIgnoringCaseWithPartialDataReturned() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.setFilterText(filterText: TestData.textToFilterPart)
        XCTAssertEqual(viewModel.filteredPersons, TestData.partialFilteredPersonList)
    }
    
    func testSavePersonListSavesInSessionManager() {
        for person in TestData.personList {
            viewModel.addPerson(person)
        }
        viewModel.savePersonList()
        XCTAssertEqual(viewModel.filteredPersons, sessionManager.storedPersonList)
    }
}
