//
//  FooterView.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Cocoa

class FooterView: NSView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var selectedItemLabel: NSTextField!
    @IBOutlet private weak var selectedItemField: NSTextField!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    // MARK: - Public functions
    
    func updateSelectedItem(to person: Person?) {
        if let person = person {
            selectedItemField.stringValue = "\(person.name) \(person.id)"
        } else {
            selectedItemField.stringValue = "-"
        }
    }
    
    // MARK: - Private functions
    
    func initViews() {
        selectedItemLabel.stringValue = LocalizationKey.selectedItemLabel.stringValue
    }
}
