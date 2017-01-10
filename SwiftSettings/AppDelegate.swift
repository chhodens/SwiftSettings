//
//  AppDelegate.swift
//  SwiftSettings
//
//  Created by Phillip on 3/16/16.
//  Copyright © 2016 OOM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let windowFrame = UIScreen.main.bounds
        window = UIWindow(frame: windowFrame)
        
        if let window = self.window {
            
            // Create some settings and add them as the root controller for the navigation controller.
            
            // Create "detailed settings" category.
            let detailedCategory = Category(itemDisplayText: "Detailed Settings")
            
            let detailedSettings: [GroupItem] = [
                    BooleanSetting(itemDisplayText: "Detailed Setting 1"),
                    BooleanSetting(itemDisplayText: "Detailed Setting 2"),
                    MultipleChoiceSetting(itemDisplayText: "Detailed Multiple Choice Setting 1",
                        settingID: "detailed_mc",
                        options: [MultipleChoiceOption(displayText: "Option 1"),
                            MultipleChoiceOption(displayText: "Option 2"),
                            MultipleChoiceOption(displayText: "Option 3")])]
            
            let detailedGroupOne = SettingsGroup(title: "Detailed Settings", description: nil, groupItems: detailedSettings)
            detailedCategory.addGroup(detailedGroupOne)
            
            
            // Create root settings screen.
            let settings: [GroupItem] = [detailedCategory,
                BooleanSetting(itemDisplayText: "Setting 1"),
                BooleanSetting(itemDisplayText: "Setting 2")]
            
            let mainGroup = SettingsGroup(title: "Settings Group 1", description: nil, groupItems: settings)

            // Create the controller, add the group.
            let settingsController = SettingsViewController()
            settingsController.groups.append(mainGroup) // TODO: Refactor as .addGroup(group: SettingsGroup)
            settingsController.navigationItem.title = "Settings"
            
            let navigationController = UINavigationController(rootViewController: settingsController)
            window.rootViewController = navigationController
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

