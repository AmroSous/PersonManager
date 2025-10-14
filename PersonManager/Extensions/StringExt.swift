//
//  StringExt.swift
//  PersonManager
//
//  Created by Amro Sous on 14/10/2025.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
