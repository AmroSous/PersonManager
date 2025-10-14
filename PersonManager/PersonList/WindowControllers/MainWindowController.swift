//
//  MainWindowController.swift
//  PersonManager
//
//  Created by Amro Sous on 11/10/2025.
//

import Cocoa

private struct UIConfigs {
    static let windowSize = NSSize(width: 600, height: 300)
    static let minWindowSize = NSSize(width: 450, height: 250)
}

class MainWindowController: NSWindowController {
        
    override func windowDidLoad() {
        super.windowDidLoad()
        setWindowSize()
    }
    
    private func setWindowSize() {
        window?.setContentSize(UIConfigs.windowSize)
        window?.minSize = UIConfigs.minWindowSize
    }
}
