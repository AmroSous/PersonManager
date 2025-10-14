//
//  ContentView.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//
    
import Cocoa

protocol ContentViewDelegate: AnyObject {
    func didSelectPerson(_ sender: ContentView, person: Person?)
    func didDeletePerson(_ sender: ContentView, person: Person)
    func didToggleStarPerson(_ sender: ContentView, person: Person)
}

class ContentView: NSView {
    
    // MARK: - Public properties
    
    weak var delegate: ContentViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var personTable: NSTableView!
    
    // MARK: - Private properties
    
    private var visiblePersons: [Person] = []
    private var selectedPersonID: UUID?
    private lazy var tableMenu: NSMenu = makeTableMenu()
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initTable()
    }
    
    override func keyDown(with event: NSEvent) {
        guard let keyCode = KeyCode(rawValue: event.keyCode) else {
            super.keyDown(with: event)
            return
        }
        switch keyCode {
        case .delete, .deleteForward:
            let alert = makeDeleteAlert()
            if alert.runModal() == .alertFirstButtonReturn {
                deleteSelectedRow()
            }
        default:
            super.keyDown(with: event)
        }
    }

    // MARK: - Public functions
    
    func reloadData() {
        personTable.reloadData()
        if let selectedPersonID = selectedPersonID {
            if let row = visiblePersons.firstIndex(where: { $0.id == selectedPersonID }) {
                personTable.selectRowIndexes(IndexSet(integer: row), byExtendingSelection: false)
            }
        }
    }
    
    func updateTableItems(items: [Person], shouldReloadData: Bool = true) {
        visiblePersons = items
        if shouldReloadData {
            reloadData()
        }
    }
    
    // MARK: - Private functions
    
    private func makeTableMenu() -> NSMenu {
        let menu = NSMenu()
        let delete = NSMenuItem(
            title: LocalizationKey.tableMenuDeleteButtonTitle.stringValue,
            action: #selector(deleteSelectedRow),
            keyEquivalent: "")
        delete.target = self
        menu.addItem(delete)
        return menu
    }
    
    private func initTable() {
        personTable.delegate = self
        personTable.dataSource = self
        personTable.menu = tableMenu
        personTable.target = self
        personTable.action = #selector(tableRowClicked)
        initTableColumns()
        personTable.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        personTable.sizeToFit()
        personTable.autosaveName = UserDefaultsKeys.personsTable
        personTable.autosaveTableColumns = true
    }
    
    private func getPerson(atRow row: Int) -> Person? {
        guard row >= 0 else { return nil }
        let nameColumn = personTable.column(withIdentifier: PersonTableColumns.name.id)
        guard let cell = personTable.view(atColumn: nameColumn, row: row, makeIfNecessary: false)
                as? NSTableCellView else { return nil }
        return cell.objectValue as? Person
    }
    
    private func initTableColumns() {
        personTable.tableColumns.forEach { personTable.removeTableColumn($0) }
        PersonTableColumns.allCases
            .map { initColumn($0) }
            .forEach(personTable.addTableColumn)
    }
    
    private func initColumn(_ col: PersonTableColumns) -> NSTableColumn {
        let column = NSTableColumn(identifier: col.id)
        column.title = col.title
        column.minWidth = col.sizing.min
        if let maxWidth = col.sizing.max {
            column.maxWidth = maxWidth
        }
        column.resizingMask = col.resizingMask
        return column
    }
    
    private func initCellView(cell: NSTableCellView, inColumn column: PersonTableColumns, withData person: Person) -> NSView? {
        switch column {
        case .name:
            cell.textField?.stringValue = person.name
            cell.textField?.lineBreakMode = .byTruncatingTail
            cell.objectValue = person

        case .id:
            cell.textField?.stringValue = person.id.uuidString
            cell.textField?.lineBreakMode = .byTruncatingTail
            
        case .symbol:
            cell.imageView?.image = NSImage(systemSymbolName: person.symbol.rawValue, accessibilityDescription: nil)
            
        case .star:
            cell.imageView?.image = NSImage(systemSymbolName: person.starred ? "star.fill" : "star", accessibilityDescription: nil)    // use enum
        }
        
        return cell
    }
    
    private func makeDeleteAlert() -> NSAlert {
        let alert = NSAlert()
        alert.messageText = LocalizationKey.deleteAlertMessageText.stringValue
        alert.informativeText = LocalizationKey.deleteAlertInformativeText.stringValue
        alert.alertStyle = .warning
        alert.addButton(withTitle: LocalizationKey.deleteAlertDeleteButtonTitle.stringValue)
        alert.addButton(withTitle: LocalizationKey.deleteAlertCancelButtonTitle.stringValue)
        return alert
    }
    
    @objc
    private func deleteSelectedRow() {
        let row = personTable.selectedRow
        guard let person = getPerson(atRow: row) else { return }
        delegate?.didDeletePerson(self, person: person)
    }
    
    @objc
    private func tableRowClicked() {
        let row = personTable.selectedRow
        let col = personTable.clickedColumn
        guard row >= 0, col >= 0, let person = getPerson(atRow: row) else {
            selectedPersonID = nil
            return
        }
        selectedPersonID = person.id
        guard personTable.tableColumns[col].identifier == PersonTableColumns.star.id else { return }
        delegate?.didToggleStarPerson(self, person: person)
        personTable.reloadData(forRowIndexes: IndexSet(integer: row), columnIndexes: IndexSet(integer: col))
    }
}

extension ContentView: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = personTable.selectedRow
        guard row >= 0 else { return }
        let person = getPerson(atRow: row)
        delegate?.didSelectPerson(self, person: person)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnRawValue = tableColumn?.identifier.rawValue,
              let column = PersonTableColumns(rawValue: columnRawValue),
              let cell = tableView.makeView(withIdentifier: column.id, owner: nil) as? NSTableCellView
        else { return nil }
        return initCellView(cell: cell, inColumn: column, withData: visiblePersons[row])
    }
}

extension ContentView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return visiblePersons.count
    }
}
