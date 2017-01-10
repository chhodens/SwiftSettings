//
//  MultipleChoiceSetting.swift
//  Synapse
//
//  Created by Phillip on 3/14/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class MultipleChoiceSetting : Setting {
    
    fileprivate(set) var options = [MultipleChoiceOption]()
    var selectedIndex = 0 {
        didSet {
            currentlySelectedLabel.text = options[selectedIndex].displayText
        }
    }
    
    var currentlySelectedLabel = UILabel()
    var labelHasBeenSetup = false
    
    init(itemDisplayText: String, settingID: String, options: [MultipleChoiceOption]) {
        super.init(itemDisplayText: itemDisplayText, settingID: settingID)
        self.options = options
    }
    
    fileprivate func indexForDefaultSelectedItem() -> Int {
        // TODO: Rewrite with settings wrapper/provide multiple persistence options?
        // TODO: Come up with a better way to get default values? Get from a central place?
        var index = selectedIndex
        
        if let currentValue = UserDefaults.standard.string(forKey: self.settingID) {
            let possibleIndex = options.index { option in
                option.settingValue == currentValue
            }
            
            if possibleIndex != nil {
                index = possibleIndex!
            }
        }
        
        return index
    }
    
    fileprivate func setupLabel() {
        selectedIndex = indexForDefaultSelectedItem()
        currentlySelectedLabel.text = options[selectedIndex].displayText
        currentlySelectedLabel.textColor = UIColor.lightGray
    }
    
    override var rightView: UIView? {
        get {
            if(!labelHasBeenSetup) {
                setupLabel()
            }
            return currentlySelectedLabel
        }
    }
    
    override var rightMargin: Double {
        return 0
    }
    
    override var shouldHighlightOnSelection: Bool {
        return true
    }
    
    override var accessoryType: UITableViewCellAccessoryType {
        return .disclosureIndicator
    }
    
    override func itemWasTappedInNavigationController(_ navigationController: UINavigationController) {
        let detailViewController = MultipleChoiceSettingDetailViewController(setting: self)
        detailViewController.delegate = self.settingValueDestination
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

struct MultipleChoiceOption {
    
    fileprivate(set) var displayText: String
    fileprivate(set) var settingValue: String
    
    init(displayText: String) {
        self.displayText = displayText
        self.settingValue = displayText
    }
    
    init(displayText: String, settingValue: String) {
        self.displayText = displayText
        self.settingValue = settingValue
    }
}

class MultipleChoiceSettingDetailViewController : UITableViewController {
    
    fileprivate(set) var setting: MultipleChoiceSetting!
    
    var currentlySelectedCell: MultipleChoiceOptionCell?
    
    var delegate: SettingValueDestination?
    
    init(setting: MultipleChoiceSetting) {
        self.setting = setting
        super.init(style: .grouped)
        self.navigationItem.title = self.setting.itemDisplayText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(self.isMovingFromParentViewController) {
            // We are being popped from the navigation controller
            self.delegate?.controller(self, didReturnValue: setting.options[setting.selectedIndex].settingValue as AnyObject, forSettingID: self.setting.settingID)
        }
    }
}

// TableViewDataSource conformance
extension MultipleChoiceSettingDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.setting.options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Setup reuse identifier and reuse cells.
        let cell = MultipleChoiceOptionCell()
        
        cell.textLabel?.text = self.setting.options[indexPath.row].displayText

        if(indexPath.row == self.setting.selectedIndex) {
            self.currentlySelectedCell = cell
            cell.isCurrent = true
        }
        
        //cell.backgroundColor = self.setting.colorSource?.backgroundColor
        //cell.textLabel?.textColor = self.setting.colorSource?.foregroundColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.setting.itemDisplayText
    }
}

// TableViewDelegate conformance
extension MultipleChoiceSettingDetailViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setting.selectedIndex = indexPath.row
        
        // Update the currently selected cell.
        if let newSelectedCell = tableView.cellForRow(at: indexPath) as? MultipleChoiceOptionCell {
            
            currentlySelectedCell?.isCurrent = false
            newSelectedCell.isCurrent = true
            currentlySelectedCell = newSelectedCell
            
            // Use this so that deselectRowAtIndexPath is called so it is only highlighted temporarily.
            newSelectedCell.setSelected(false, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let deselectedCell = tableView.cellForRow(at: indexPath) {
            deselectedCell.selectionStyle = .none
            
            // Reset the cell to have a "Default" selection style next time we click it so it flashes again.
            let mainQueue = DispatchQueue.main
            mainQueue.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 0), execute: {deselectedCell.selectionStyle = .default})
        }
    }
}

class MultipleChoiceOptionCell : UITableViewCell {
    
    var isCurrent: Bool = false {
        didSet {
            updateCheckmark()
        }
    }
    
    fileprivate func updateCheckmark() {
        self.accessoryType = isCurrent ? .checkmark : .none
    }
}
















