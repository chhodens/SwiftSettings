//
//  Setting.swift
//  Synapse
//
//  Created by Phillip on 3/13/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class Setting : GroupItem {
    
    fileprivate(set) var settingID: String!
    
    init(itemDisplayText: String, settingID: String) {
        self.itemDisplayText = itemDisplayText
        self.settingID = settingID
    }
    
    // GroupItem protocol conformance
    fileprivate(set) var itemDisplayText: String = "setting"
    fileprivate(set) var leftView: UIView?
    fileprivate(set) var rightView: UIView?
    fileprivate(set) var rightMargin: Double = 20
    
    var settingValueDestination: SettingValueDestination?
    
    fileprivate(set) var shouldHighlightOnSelection = false
    fileprivate(set) var accessoryType: UITableViewCellAccessoryType = .none
    
    func itemWasTappedInNavigationController(_ navigationController: UINavigationController) {
        print("Setting named '\(self.itemDisplayText)' was tapped.")
    }
}
