//
//  SettingsTableViewCell.swift
//  Synapse
//
//  Created by Phillip on 3/13/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewCell : UITableViewCell {
    
    var rightView: UIView?
    
    var item: GroupItem! {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        self.textLabel?.text = item.itemDisplayText
        
        if let possibleView = self.item.rightView {
            rightView = possibleView
            attachViewToRightSide(rightView!)
        }
    }
    
    func attachViewToRightSide(_ rightView: UIView) {
        
        rightView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraints += [NSLayoutConstraint(item: rightView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -CGFloat(item.rightMargin))]
        constraints += [NSLayoutConstraint(item: rightView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)]
        
        self.contentView.addSubview(rightView)
        self.contentView.addConstraints(constraints)
    }
}






