//
//  SettingsGroup.swift
//  Synapse
//
//  Created by Phillip on 3/13/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class SettingsGroup {
    fileprivate(set) var title: String
    fileprivate(set) var description: String
    
    fileprivate(set) var groupItems = [GroupItem]() // Can hold and display anything that conforms to "GroupItem"
    
    init(title: String?, description: String?, groupItems: [GroupItem]) {
        self.title = title ?? ""
        self.description = description ?? ""
        self.groupItems = groupItems
    }
    
    convenience init(title: String, description: String?) {
        let groupItems = [GroupItem]()
        self.init(title: title, description: description, groupItems: groupItems)
    }
    
    func addGroupItem(_ item: GroupItem) {
        self.groupItems.append(item)
    }
}

protocol GroupItem {
    
    var itemDisplayText: String { get }
    var leftView: UIView? { get }
    var rightView: UIView? { get }
    
    var rightMargin: Double { get }
    
    var settingValueDestination: SettingValueDestination? { get set }
    
    // TableViewCell Specifics
    var shouldHighlightOnSelection: Bool { get }
    var accessoryType: UITableViewCellAccessoryType { get }
    
    func itemWasTappedInNavigationController(_ navigationController: UINavigationController)
}
