//
//  Category.swift
//  Synapse
//
//  Created by Phillip on 3/13/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class Category : GroupItem {
    
    // Category can hold other groups too.
    fileprivate(set) var groups = [SettingsGroup]()
    
    init(itemDisplayText: String) {
        self.itemDisplayText = itemDisplayText
    }
    
    func addGroup(_ group: SettingsGroup) {
        self.groups.append(group)
    }
    
    // GroupItem protocol conformance
    fileprivate(set) var itemDisplayText: String = "category"
    fileprivate(set) var leftView: UIView?
    fileprivate(set) var rightView: UIView?
    fileprivate(set) var rightMargin: Double = 20
    
    var settingValueDestination: SettingValueDestination?
    
    fileprivate(set) var shouldHighlightOnSelection = true
    fileprivate(set) var accessoryType: UITableViewCellAccessoryType = .disclosureIndicator
    
    func itemWasTappedInNavigationController(_ navigationController: UINavigationController) {
        let categorySettingsViewController = SettingsViewController(groups: self.groups)
        categorySettingsViewController.navigationItem.title = self.itemDisplayText
        navigationController.pushViewController(categorySettingsViewController, animated: true)
        
        print("Category named '\(self.itemDisplayText)' was tapped.")
    }
}
