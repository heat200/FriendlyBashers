//
//  AppDelegate.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/17/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mpcHandler:MPCHandler = MPCHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let musicSetting = defaults.bool(forKey: "MUSIC")
        let sfxSetting = defaults.bool(forKey: "SFX")
        
        if let pName = defaults.object(forKey: "PLAYERNAME") {
            playerName = pName as! String
        }
        
        musicEnabled = musicSetting
        sfxEnabled = sfxSetting
        
        if let blessingSelected = defaults.object(forKey: "CHOSEN_BLESSING") {
            chosenBlessing = (blessingSelected as? Int)!
        }
        
        if let wins = defaults.object(forKey: "WINS") {
            winCount = wins as! Int
        }
        
        if let blessing_1 = defaults.string(forKey: "BLESSING_NAME_1") {
            blessingNames[0] = blessing_1
        }
        
        if let blessing_2 = defaults.string(forKey: "BLESSING_NAME_2") {
            blessingNames[1] = blessing_2
        }
        
        if let blessing_3 = defaults.string(forKey: "BLESSING_NAME_3") {
            blessingNames[2] = blessing_3
        }
        
        if let blessing_4 = defaults.string(forKey: "BLESSING_NAME_4") {
            blessingNames[3] = blessing_4
        }
        
        let blessing_0_0 = defaults.integer(forKey: "BLESSING_0_0")
        let blessing_0_1 = defaults.integer(forKey: "BLESSING_0_1")
        let blessing_0_2 = defaults.integer(forKey: "BLESSING_0_2")
        let blessing_0_3 = defaults.integer(forKey: "BLESSING_0_3")
        let blessing_0_4 = defaults.integer(forKey: "BLESSING_0_4")
        let blessing_1_0 = defaults.integer(forKey: "BLESSING_1_0")
        let blessing_1_1 = defaults.integer(forKey: "BLESSING_1_1")
        let blessing_1_2 = defaults.integer(forKey: "BLESSING_1_2")
        let blessing_1_3 = defaults.integer(forKey: "BLESSING_1_3")
        let blessing_1_4 = defaults.integer(forKey: "BLESSING_1_4")
        let blessing_2_0 = defaults.integer(forKey: "BLESSING_2_0")
        let blessing_2_1 = defaults.integer(forKey: "BLESSING_2_1")
        let blessing_2_2 = defaults.integer(forKey: "BLESSING_2_2")
        let blessing_2_3 = defaults.integer(forKey: "BLESSING_2_3")
        let blessing_2_4 = defaults.integer(forKey: "BLESSING_2_4")
        let blessing_3_0 = defaults.integer(forKey: "BLESSING_3_0")
        let blessing_3_1 = defaults.integer(forKey: "BLESSING_3_1")
        let blessing_3_2 = defaults.integer(forKey: "BLESSING_3_2")
        let blessing_3_3 = defaults.integer(forKey: "BLESSING_3_3")
        let blessing_3_4 = defaults.integer(forKey: "BLESSING_3_4")
        blessingList[0][0] = blessing_0_0
        blessingList[0][1] = blessing_0_1
        blessingList[0][2] = blessing_0_2
        blessingList[0][3] = blessing_0_3
        blessingList[0][4] = blessing_0_4
        blessingList[1][0] = blessing_1_0
        blessingList[1][1] = blessing_1_1
        blessingList[1][2] = blessing_1_2
        blessingList[1][3] = blessing_1_3
        blessingList[1][4] = blessing_1_4
        blessingList[2][0] = blessing_2_0
        blessingList[2][1] = blessing_2_1
        blessingList[2][2] = blessing_2_2
        blessingList[2][3] = blessing_2_3
        blessingList[2][4] = blessing_2_4
        blessingList[3][0] = blessing_3_0
        blessingList[3][1] = blessing_3_1
        blessingList[3][2] = blessing_3_2
        blessingList[3][3] = blessing_3_3
        blessingList[3][4] = blessing_3_4
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

