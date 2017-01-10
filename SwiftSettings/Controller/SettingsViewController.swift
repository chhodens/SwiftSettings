//
//  SettingsViewController.swift
//  Synapse
//
//  Created by Phillip on 3/13/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController, SettingValueDestination {
    
    var groups: [SettingsGroup]
    
    init(groups: [SettingsGroup]) {
        self.groups = groups
        super.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        
        // Once the view loads, we have to make sure we are the delegate for all our items.
        for group in groups {
            for var groupItem in group.groupItems {
                groupItem.settingValueDestination = self
            }
        }
        
        updateUI()
    }
    
    convenience init() {
        let groups = [SettingsGroup]()
        self.init(groups: groups)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // SettingValueDestination
    func controller(_ controller: UIViewController, didReturnValue value: AnyObject, forSettingID settingID: String) {
        print("Changing setting named: '\(settingID)' to value '\(value)'")
        
        // TODO: Rewrite with settings wrapper/provide multiple persistence options?
        UserDefaults.standard.setValue(value, forKey: settingID)
    }
    
    func setting(_ settingID: String, didChangeToValue value: AnyObject) {
        print("Changing setting named: '\(settingID)' to value '\(value)'")
        
        // TODO: Rewrite with settings wrapper/provide multiple persistence options?
        UserDefaults.standard.setValue(value, forKey: settingID)
    }
    
    // TODO: Make this more consistent somehow, with observers, or something.
    func updateUI() {
        self.tableView.reloadData()
    }
}

// TableViewDataSource conformance
extension SettingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.groups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].groupItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO: Setup reuse identifier and reuse cells.
        let cell = SettingsTableViewCell()
        cell.item = self.groups[indexPath.section].groupItems[indexPath.row]
        
        cell.selectionStyle = cell.item.shouldHighlightOnSelection ? .default : .none
        cell.accessoryType = cell.item.accessoryType
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = self.groups[section]
        return group.title
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let group = self.groups[section]
        return group.description
    }
}

// TableViewDelegate conformance
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell {
            
            if let navigationController = self.navigationController {
                cell.item.itemWasTappedInNavigationController(navigationController)
            }
        }
    }
}

protocol SettingValueDestination {
    func controller(_ controller: UIViewController, didReturnValue: AnyObject, forSettingID: String)
    func setting(_ settingID: String, didChangeToValue: AnyObject)
}
