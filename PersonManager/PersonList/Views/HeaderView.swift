//
//  HeaderView.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Cocoa

protocol HeaderViewDelegate: AnyObject {
    func filterTextDidChange(_ source: HeaderView, text: String)
    func addPersonDidClicked(_ source: HeaderView)
    func appInfoDidClicked(_ source: HeaderView, anchor: NSButton)
}

private struct UIConfigs {
    static let addButtonImageConfig: NSImage.SymbolConfiguration = NSImage.SymbolConfiguration(pointSize: 18, weight: .regular)
}

class HeaderView: NSView {
    
    // MARK: - Public properties
    
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var filterField: NSTextField! {
        didSet {
            filterField.delegate = self
        }
    }
    @IBOutlet private weak var addPersonButton: NSButton!
    @IBOutlet private weak var appInfoButton: NSButton!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    // MARK: - IBActions
    
    @IBAction private func addPersonButtonDidClicked(_ sender: NSButton) {
        delegate?.addPersonDidClicked(self)
    }
    
    @IBAction private func appInfoDidClicked(_ sender: NSButton) {
        delegate?.appInfoDidClicked(self, anchor: sender)
    }
    
    // MARK: - Private functions
    
    private func initViews() {
        addPersonButton.image = addPersonButton.image?.withSymbolConfiguration(UIConfigs.addButtonImageConfig)
        appInfoButton.image = appInfoButton.image?.withSymbolConfiguration(UIConfigs.addButtonImageConfig)
        filterField.placeholderString = LocalizationKey.filterPlaceholder.stringValue
    }
}

extension HeaderView: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField, textField == filterField else { return }
        delegate?.filterTextDidChange(self, text: textField.stringValue)
    }
}
