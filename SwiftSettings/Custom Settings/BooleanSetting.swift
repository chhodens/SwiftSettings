//
//  BooleanSetting.swift
//  Synapse
//
//  Created by Phillip on 3/14/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class BooleanSetting : Setting {
    
    var booleanSwitch = UISwitch()
    var booleanSwitchHasBeenSetup = false
    
    init(itemDisplayText: String) {
        super.init(itemDisplayText: itemDisplayText, settingID: itemDisplayText)
    }
    
    override init(itemDisplayText: String, settingID: String) {
        super.init(itemDisplayText: itemDisplayText, settingID: settingID)
    }
    
    override var rightView: UIView? {
        get {
            if(!booleanSwitchHasBeenSetup) {
                setupBooleanSwitch()
            }
            return booleanSwitch
        }
    }
    
    func setupDefaultState() {
        // TODO: Rewrite with settings wrapper/provide multiple persistence options?
        // TODO: Come up with a better way to get default values? Get from a central place?
        booleanSwitch.isOn = UserDefaults.standard.bool(forKey: self.settingID)
    }
    
    func setupBooleanSwitch() {
        booleanSwitch.addTarget(self, action: #selector(BooleanSetting.switchDidChange(_:)), for: UIControlEvents.valueChanged)
        
        setupDefaultState()
        booleanSwitchHasBeenSetup = true
    }
    
    // Need to annotate @objc to make it visible to the objc runtime
    // We need this because this class isn't a subclass of NSObject. Without it it crashes at runtime, "does not implement selector".
    @objc func switchDidChange(_ booleanSwitch: AnyObject) {
        settingValueDestination?.setting(self.settingID, didChangeToValue: (booleanSwitch as! UISwitch).isOn as AnyObject)
    }
}
