//
//  AddPersonView.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Cocoa

protocol AddPersonViewDelegate: AnyObject {
    func didRequestAddPerson(_ sender: AddPersonView, withName name: String, symbol: SFSymbol)
    func didRequestCancelAddPerson(_ sender: AddPersonView)
}

class AddPersonView: NSView {

    // MARK: - Public properties

    weak var delegate: AddPersonViewDelegate?
    
    // MARK: - IBOutlets

    @IBOutlet private weak var nameTextField: NSTextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet private weak var symbolPopUp: NSPopUpButton!
    @IBOutlet private weak var addButton: NSButton!
    @IBOutlet private weak var backButton: NSButton!
    @IBOutlet private weak var progressIndicator: NSProgressIndicator!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    // MARK: - IBActions

    @IBAction private func addButtonPressed(_ sender: NSButton) {
        let name = trimmedName()
        guard !name.isEmpty else {
            return
        }
        let symbol = selectedSymbol()
        delegate?.didRequestAddPerson(self, withName: name, symbol: symbol)
    }

    @IBAction private func backButtonPressed(_ sender: NSButton) {
        delegate?.didRequestCancelAddPerson(self)
    }
    
    // MARK: - Public functions
    
    func setLoading(_ isLoading: Bool) {
        addButton.isEnabled = !isLoading && !trimmedName().isEmpty
        nameTextField.isEditable = !isLoading
        progressIndicator.isHidden = !isLoading
        isLoading ? progressIndicator.startAnimation(self) : progressIndicator.stopAnimation(self)
    }
    
    func resetInputs() {
        nameTextField.stringValue = ""
    }
    
    // MARK: - Private functions
    
    private func initViews() {
        addButton.isEnabled = !nameTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        progressIndicator.isHidden = true
        progressIndicator.isDisplayedWhenStopped = false
        initSymbolPopUp()
    }
    
    private func initSymbolPopUp() {
        symbolPopUp.removeAllItems()
        PersonSymbol.allCases.forEach {
            let item = NSMenuItem(title: $0.displayTitle, action: nil, keyEquivalent: "")
            item.image = NSImage(systemSymbolName: $0.sfSymbol.rawValue, accessibilityDescription: nil)?.withSymbolConfiguration(.init(pointSize: 14, weight: .regular))
            item.representedObject = $0.sfSymbol
            symbolPopUp.menu?.addItem(item)
        }
    }
    
    private func trimmedName() -> String {
        return nameTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func selectedSymbol() -> SFSymbol {
        return symbolPopUp.selectedItem?.representedObject as! SFSymbol
    }
    
}

extension AddPersonView: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField, textField == nameTextField else { return }
        addButton.isEnabled = !textField.stringValue.isEmpty
    }
}
