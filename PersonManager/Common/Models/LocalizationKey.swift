//
//  L10n.swift
//  PersonManager
//
//  Created by Amro Sous on 13/10/2025.
//

import Cocoa

enum LocalizationKey: String {
    case filterPlaceholder = "person_list_view_controller.header_view.filter_placeholder.title"
    case selectedItemLabel = "person_list_view_controller.footer_view.selected_item_label.title"
    case nameColumnHeader = "person_list_view_controller.content_view.person_table.name_column.title"
    case idColumnHeader = "person_list_view_controller.content_view.person_table.id_column.title"
    case symbolColumnHeader = "person_list_view_controller.content_view.person_table.symbol_column.title"
    case starColumnHeader = "person_list_view_controller.content_view.person_table.star_column.title"
    case deleteAlertMessageText = "person_list_view_controller.content_view.person_table.delete_alert.message_text"
    case deleteAlertInformativeText = "person_list_view_controller.content_view.person_table.delete_alert.informative_text"
    case deleteAlertDeleteButtonTitle = "person_list_view_controller.content_view.person_table.delete_alert.delete_button.title"
    case deleteAlertCancelButtonTitle = "person_list_view_controller.content_view.person_table.delete_alert.cancel_button.title"
    case personSymbolDisplayTitle = "add_person_view_controller.add_person_view.symbol_popup.person.title"
    case treeSymbolDisplayTitle = "add_person_view_controller.add_person_view.symbol_popup.tree.title"
    case carSymbolDisplayTitle = "add_person_view_controller.add_person_view.symbol_popup.car.title"
    
    var stringValue: String {
        return rawValue.localized
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
