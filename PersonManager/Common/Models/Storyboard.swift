//
//  Storyboard.swift
//  PersonManager
//
//  Created by Amro Sous on 10/10/2025.
//

import Cocoa

enum Storyboard: String {
    case main = "Main"

    var instance: NSStoryboard {
        NSStoryboard(name: NSStoryboard.Name(rawValue), bundle: nil)
    }
}
