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

extension NSStoryboard {
    func instantiate<T: NSViewController>(_ type: T.Type) -> T {
        let id = NSStoryboard.SceneIdentifier(String(describing: T.self))
        guard let vc = instantiateController(withIdentifier: id) as? T else {
            fatalError("Scene \(id.debugDescription) not found in storyboard \(self).")
        }
        return vc
    }

    func instantiate<T: NSViewController>(
        _ type: T.Type,
        creator: @escaping (NSCoder) -> T?
    ) -> T {
        let id = NSStoryboard.SceneIdentifier(String(describing: T.self))
        return instantiateController(identifier: id, creator: creator)
    }
}
