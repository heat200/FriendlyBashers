//
//  BlessingsScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/25/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class BlessingsScene:SKScene, UITextFieldDelegate {
    var textField:UITextField!
    
    var currentBlessings = [0,0,0,0,0]
    
    var helpMode = false
    
    var backButton:SKSpriteNode?
    var confirmButton:SKSpriteNode?
    var helpButton:SKSpriteNode?
    
    var masteryPointCounter = 0
    var masteryPointsLabel:SKLabelNode?
    
    var blessingMobility1:SKSpriteNode?
    var blessingMobility2:SKSpriteNode?
    var blessingMobility3:SKSpriteNode?
    var blessingMobility4:SKSpriteNode?
    var blessingMobility5:SKSpriteNode?
    var blessingPower1:SKSpriteNode?
    var blessingPower2:SKSpriteNode?
    var blessingPower3:SKSpriteNode?
    var blessingPower4:SKSpriteNode?
    var blessingPower5:SKSpriteNode?
    var blessingResistance1:SKSpriteNode?
    var blessingResistance2:SKSpriteNode?
    var blessingResistance3:SKSpriteNode?
    var blessingResistance4:SKSpriteNode?
    var blessingResistance5:SKSpriteNode?
    var blessingHealing1:SKSpriteNode?
    var blessingHealing2:SKSpriteNode?
    var blessingHealing3:SKSpriteNode?
    var blessingHealing4:SKSpriteNode?
    var blessingHealing5:SKSpriteNode?
    var blessingUtility1:SKSpriteNode?
    var blessingUtility2:SKSpriteNode?
    var blessingUtility3:SKSpriteNode?
    var blessingUtility4:SKSpriteNode?
    var blessingUtility5:SKSpriteNode?
    
    var blessingMobilityPoints1:SKLabelNode?
    var blessingMobilityPoints2:SKLabelNode?
    var blessingMobilityPoints3:SKLabelNode?
    var blessingMobilityPoints4:SKLabelNode?
    var blessingMobilityPoints5:SKLabelNode?
    var blessingPowerPoints1:SKLabelNode?
    var blessingPowerPoints2:SKLabelNode?
    var blessingPowerPoints3:SKLabelNode?
    var blessingPowerPoints4:SKLabelNode?
    var blessingPowerPoints5:SKLabelNode?
    var blessingResistancePoints1:SKLabelNode?
    var blessingResistancePoints2:SKLabelNode?
    var blessingResistancePoints3:SKLabelNode?
    var blessingResistancePoints4:SKLabelNode?
    var blessingResistancePoints5:SKLabelNode?
    var blessingHealingPoints1:SKLabelNode?
    var blessingHealingPoints2:SKLabelNode?
    var blessingHealingPoints3:SKLabelNode?
    var blessingHealingPoints4:SKLabelNode?
    var blessingHealingPoints5:SKLabelNode?
    var blessingUtilityPoints1:SKLabelNode?
    var blessingUtilityPoints2:SKLabelNode?
    var blessingUtilityPoints3:SKLabelNode?
    var blessingUtilityPoints4:SKLabelNode?
    var blessingUtilityPoints5:SKLabelNode?
    
    var selectPage1:SKSpriteNode?
    var selectPage2:SKSpriteNode?
    var selectPage3:SKSpriteNode?
    var selectPage4:SKSpriteNode?
    
    var renamePage1:SKSpriteNode?
    var renamePage2:SKSpriteNode?
    var renamePage3:SKSpriteNode?
    var renamePage4:SKSpriteNode?
    
    var deletePage1:SKSpriteNode?
    var deletePage2:SKSpriteNode?
    var deletePage3:SKSpriteNode?
    var deletePage4:SKSpriteNode?
    
    var pageName1:SKLabelNode?
    var pageName2:SKLabelNode?
    var pageName3:SKLabelNode?
    var pageName4:SKLabelNode?
    
    var editing1 = false
    var editing2 = false
    var editing3 = false
    var editing4 = false
    
    override func sceneDidLoad() {
        self.confirmButton = self.childNode(withName: "//confirmButton") as? SKSpriteNode
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.helpButton = self.childNode(withName: "//helpButton") as? SKSpriteNode
        
        self.selectPage1 = self.childNode(withName: "//selectPage1") as? SKSpriteNode
        self.selectPage2 = self.childNode(withName: "//selectPage2") as? SKSpriteNode
        self.selectPage3 = self.childNode(withName: "//selectPage3") as? SKSpriteNode
        self.selectPage4 = self.childNode(withName: "//selectPage4") as? SKSpriteNode
        
        self.renamePage1 = self.childNode(withName: "//renamePage1") as? SKSpriteNode
        self.renamePage2 = self.childNode(withName: "//renamePage2") as? SKSpriteNode
        self.renamePage3 = self.childNode(withName: "//renamePage3") as? SKSpriteNode
        self.renamePage4 = self.childNode(withName: "//renamePage4") as? SKSpriteNode
        
        self.deletePage1 = self.childNode(withName: "//deletePage1") as? SKSpriteNode
        self.deletePage2 = self.childNode(withName: "//deletePage2") as? SKSpriteNode
        self.deletePage3 = self.childNode(withName: "//deletePage3") as? SKSpriteNode
        self.deletePage4 = self.childNode(withName: "//deletePage4") as? SKSpriteNode
        
        self.blessingMobility1 = self.childNode(withName: "//blessingMobility1") as? SKSpriteNode
        self.blessingMobility2 = self.childNode(withName: "//blessingMobility2") as? SKSpriteNode
        self.blessingMobility3 = self.childNode(withName: "//blessingMobility3") as? SKSpriteNode
        self.blessingMobility4 = self.childNode(withName: "//blessingMobility4") as? SKSpriteNode
        self.blessingMobility5 = self.childNode(withName: "//blessingMobility5") as? SKSpriteNode
        self.blessingPower1 = self.childNode(withName: "//blessingPower1") as? SKSpriteNode
        self.blessingPower2 = self.childNode(withName: "//blessingPower2") as? SKSpriteNode
        self.blessingPower3 = self.childNode(withName: "//blessingPower3") as? SKSpriteNode
        self.blessingPower4 = self.childNode(withName: "//blessingPower4") as? SKSpriteNode
        self.blessingPower5 = self.childNode(withName: "//blessingPower5") as? SKSpriteNode
        self.blessingResistance1 = self.childNode(withName: "//blessingResistance1") as? SKSpriteNode
        self.blessingResistance2 = self.childNode(withName: "//blessingResistance2") as? SKSpriteNode
        self.blessingResistance3 = self.childNode(withName: "//blessingResistance3") as? SKSpriteNode
        self.blessingResistance4 = self.childNode(withName: "//blessingResistance4") as? SKSpriteNode
        self.blessingResistance5 = self.childNode(withName: "//blessingResistance5") as? SKSpriteNode
        self.blessingHealing1 = self.childNode(withName: "//blessingHealing1") as? SKSpriteNode
        self.blessingHealing2 = self.childNode(withName: "//blessingHealing2") as? SKSpriteNode
        self.blessingHealing3 = self.childNode(withName: "//blessingHealing3") as? SKSpriteNode
        self.blessingHealing4 = self.childNode(withName: "//blessingHealing4") as? SKSpriteNode
        self.blessingHealing5 = self.childNode(withName: "//blessingHealing5") as? SKSpriteNode
        self.blessingUtility1 = self.childNode(withName: "//blessingUtility1") as? SKSpriteNode
        self.blessingUtility2 = self.childNode(withName: "//blessingUtility2") as? SKSpriteNode
        self.blessingUtility3 = self.childNode(withName: "//blessingUtility3") as? SKSpriteNode
        self.blessingUtility4 = self.childNode(withName: "//blessingUtility4") as? SKSpriteNode
        self.blessingUtility5 = self.childNode(withName: "//blessingUtility5") as? SKSpriteNode
        
        self.masteryPointsLabel = self.childNode(withName: "//masteryPointsLabel") as? SKLabelNode
        
        self.blessingMobilityPoints1 = blessingMobility1?.childNode(withName: "//blessingMobilityPoints1") as? SKLabelNode
        self.blessingMobilityPoints2 = blessingMobility2?.childNode(withName: "//blessingMobilityPoints2") as? SKLabelNode
        self.blessingMobilityPoints3 = blessingMobility3?.childNode(withName: "//blessingMobilityPoints3") as? SKLabelNode
        self.blessingMobilityPoints4 = blessingMobility4?.childNode(withName: "//blessingMobilityPoints4") as? SKLabelNode
        self.blessingMobilityPoints5 = blessingMobility5?.childNode(withName: "//blessingMobilityPoints5") as? SKLabelNode
        self.blessingPowerPoints1 = blessingPower1?.childNode(withName: "//blessingPowerPoints1") as? SKLabelNode
        self.blessingPowerPoints2 = blessingPower2?.childNode(withName: "//blessingPowerPoints2") as? SKLabelNode
        self.blessingPowerPoints3 = blessingPower3?.childNode(withName: "//blessingPowerPoints3") as? SKLabelNode
        self.blessingPowerPoints4 = blessingPower4?.childNode(withName: "//blessingPowerPoints4") as? SKLabelNode
        self.blessingPowerPoints5 = blessingPower5?.childNode(withName: "//blessingPowerPoints5") as? SKLabelNode
        self.blessingResistancePoints1 = blessingResistance1?.childNode(withName: "//blessingResistancePoints1") as? SKLabelNode
        self.blessingResistancePoints2 = blessingResistance2?.childNode(withName: "//blessingResistancePoints2") as? SKLabelNode
        self.blessingResistancePoints3 = blessingResistance3?.childNode(withName: "//blessingResistancePoints3") as? SKLabelNode
        self.blessingResistancePoints4 = blessingResistance4?.childNode(withName: "//blessingResistancePoints4") as? SKLabelNode
        self.blessingResistancePoints5 = blessingResistance5?.childNode(withName: "//blessingResistancePoints5") as? SKLabelNode
        self.blessingHealingPoints1 = blessingHealing1?.childNode(withName: "//blessingHealingPoints1") as? SKLabelNode
        self.blessingHealingPoints2 = blessingHealing2?.childNode(withName: "//blessingHealingPoints2") as? SKLabelNode
        self.blessingHealingPoints3 = blessingHealing3?.childNode(withName: "//blessingHealingPoints3") as? SKLabelNode
        self.blessingHealingPoints4 = blessingHealing4?.childNode(withName: "//blessingHealingPoints4") as? SKLabelNode
        self.blessingHealingPoints5 = blessingHealing5?.childNode(withName: "//blessingHealingPoints5") as? SKLabelNode
        self.blessingUtilityPoints1 = blessingUtility1?.childNode(withName: "//blessingUtilityPoints1") as? SKLabelNode
        self.blessingUtilityPoints2 = blessingUtility2?.childNode(withName: "//blessingUtilityPoints2") as? SKLabelNode
        self.blessingUtilityPoints3 = blessingUtility3?.childNode(withName: "//blessingUtilityPoints3") as? SKLabelNode
        self.blessingUtilityPoints4 = blessingUtility4?.childNode(withName: "//blessingUtilityPoints4") as? SKLabelNode
        self.blessingUtilityPoints5 = blessingUtility5?.childNode(withName: "//blessingUtilityPoints5") as? SKLabelNode
        
        self.pageName1 = selectPage1?.childNode(withName: "//pageName1") as? SKLabelNode
        pageName1?.text = blessingNames[0]
        self.pageName2 = selectPage2?.childNode(withName: "//pageName2") as? SKLabelNode
        pageName2?.text = blessingNames[1]
        self.pageName3 = selectPage3?.childNode(withName: "//pageName3") as? SKLabelNode
        pageName3?.text = blessingNames[2]
        self.pageName4 = selectPage4?.childNode(withName: "//pageName4") as? SKLabelNode
        pageName4?.text = blessingNames[3]
        
        let masteryPointCounter = masteryPoints - (currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4])
        masteryPointsLabel?.text = "MP x " + String(describing: masteryPointCounter)
    }
    
    override func didMove(to view: SKView) {
        if menuMusic.parent == nil && musicEnabled {
            self.addChild(menuMusic)
        }
        
        currentBlessings = blessingList[chosenBlessing]
        textField = UITextField(frame: CGRect(x: self.size.width/2, y: self.size.height/2 - 50, width: 100, height: 20))
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.alphabet
        self.view?.addSubview(textField)
        updateUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.backButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                menuMusic.run(SKAction.pause(),completion:{
                    menuMusic.removeFromParent()
                })
                
                defaults.setValue(blessingList[0][0], forKey: "BLESSING_0_0")
                defaults.setValue(blessingList[0][1], forKey: "BLESSING_0_1")
                defaults.setValue(blessingList[0][2], forKey: "BLESSING_0_2")
                defaults.setValue(blessingList[0][3], forKey: "BLESSING_0_3")
                defaults.setValue(blessingList[0][4], forKey: "BLESSING_0_4")
                
                defaults.setValue(blessingList[1][0], forKey: "BLESSING_1_0")
                defaults.setValue(blessingList[1][1], forKey: "BLESSING_1_1")
                defaults.setValue(blessingList[1][2], forKey: "BLESSING_1_2")
                defaults.setValue(blessingList[1][3], forKey: "BLESSING_1_3")
                defaults.setValue(blessingList[1][4], forKey: "BLESSING_1_4")
                
                defaults.setValue(blessingList[2][0], forKey: "BLESSING_2_0")
                defaults.setValue(blessingList[2][1], forKey: "BLESSING_2_1")
                defaults.setValue(blessingList[2][2], forKey: "BLESSING_2_2")
                defaults.setValue(blessingList[2][3], forKey: "BLESSING_2_3")
                defaults.setValue(blessingList[2][4], forKey: "BLESSING_2_4")
                
                defaults.setValue(blessingList[3][0], forKey: "BLESSING_3_0")
                defaults.setValue(blessingList[3][1], forKey: "BLESSING_3_1")
                defaults.setValue(blessingList[3][2], forKey: "BLESSING_3_2")
                defaults.setValue(blessingList[3][3], forKey: "BLESSING_3_3")
                defaults.setValue(blessingList[3][4], forKey: "BLESSING_3_4")
                
                defaults.setValue(blessingNames[0], forKey: "BLESSING_NAME_1")
                defaults.setValue(blessingNames[1], forKey: "BLESSING_NAME_2")
                defaults.setValue(blessingNames[2], forKey: "BLESSING_NAME_3")
                defaults.setValue(blessingNames[3], forKey: "BLESSING_NAME_4")
                defaults.set(chosenBlessing, forKey: "CHOSEN_BLESSING")
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    self.backToMainMenu()
                })
            } else if (self.confirmButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button to save your current Masteries Page to the slot being used."
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else if !helpMode && pageSaveable() {
                    blessingList[chosenBlessing] = currentBlessings
                }
            } else if (self.helpButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    helpMode = false
                } else {
                    helpMode = true
                }
            } else if (self.selectPage1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to select your " + blessingNames[0] + " Masteries Page for your next battle"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBlessing = 0
                    currentBlessings = blessingList[chosenBlessing]
                }
                textField.resignFirstResponder()
            } else if (self.selectPage2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to select your " + blessingNames[1] + " Masteries Page for your next battle"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBlessing = 1
                    currentBlessings = blessingList[chosenBlessing]
                }
                textField.resignFirstResponder()
            } else if (self.selectPage3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to select your " + blessingNames[2] + " Masteries Page for your next battle"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBlessing = 2
                    currentBlessings = blessingList[chosenBlessing]
                }
                textField.resignFirstResponder()
            } else if (self.selectPage4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to select your " + blessingNames[3] + " Masteries Page for your next battle"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBlessing = 3
                    currentBlessings = blessingList[chosenBlessing]
                }
                textField.resignFirstResponder()
            } else if (self.renamePage1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to edit the name of your " + blessingNames[0] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    editing1 = true
                    textField.becomeFirstResponder()
                }
            } else if (self.renamePage2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to edit the name of your " + blessingNames[1] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    editing2 = true
                    textField.becomeFirstResponder()
                }
            } else if (self.renamePage3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to edit the name of your " + blessingNames[2] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    editing3 = true
                    textField.becomeFirstResponder()
                }
            } else if (self.renamePage4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to edit the name of your " + blessingNames[3] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    editing4 = true
                    textField.becomeFirstResponder()
                }
            } else if (self.deletePage1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to delete your " + blessingNames[0] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    blessingList[0] = [0,0,0,0,0]
                    blessingNames[0] = "Page 1"
                }
                textField.resignFirstResponder()
            } else if (self.deletePage2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to delete your " + blessingNames[1] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    blessingList[1] = [0,0,0,0,0]
                    blessingNames[1] = "Page 2"
                }
                textField.resignFirstResponder()
            } else if (self.deletePage3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to delete your " + blessingNames[2] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    blessingList[2] = [0,0,0,0,0]
                    blessingNames[2] = "Page 3"
                }
                textField.resignFirstResponder()
            } else if (self.deletePage4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "This button is to delete your " + blessingNames[3] + " Masteries Page"
                    let title = "About this Button"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    blessingList[3] = [0,0,0,0,0]
                    blessingNames[3] = "Page 4"
                }
                textField.resignFirstResponder()
            } else if (self.blessingMobility1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/3: +1% Movespeed. \n 2/3: +2.5% Movesped. \n 3/3: +5% Movespeed."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[0] < 3 && pageReady(){
                        currentBlessings[0] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingMobility2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +1 Max Jumps. \n 2/2: +2 Max Jumps."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[0] < 5 && currentBlessings[0] >= 3 && pageReady(){
                        currentBlessings[0] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingMobility3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +15% Movespeed Steal.\n 2/2: +30% Movespeed Steal. \n (Applies to melee attacks only; Lasts 2.5 Seconds)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[0] < 7 && currentBlessings[0] >= 5 && pageReady(){
                        currentBlessings[0] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingMobility4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +7.5% Movespeed. \n 2/2: +10% Movespeed."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[0] < 9 && currentBlessings[0] >= 7 && pageReady(){
                        currentBlessings[0] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingMobility5?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/1: Unlocks Move 'Limbo', a short ranged blink ability. \n Tap the mastery ability button and then tap the screen to blink \n (20 Second Cooldown)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[0] < 10 && currentBlessings[0] >= 9 && pageReady(){
                        currentBlessings[0] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingPower1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/3: +1% Power. \n 2/3: +2.5% Power. \n 3/3: +5% Power."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[1] < 3 && pageReady(){
                        currentBlessings[1] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingPower2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +5% Life Steal. \n 2/2: +20% Life Steal. \n (Applies to melee attacks only)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[1] < 5 && currentBlessings[1] >= 3 && pageReady(){
                        currentBlessings[1] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingPower3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +35% Life Steal.\n 2/2: +50% Life Steal. \n (Applies to melee attacks only)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[1] < 7 && currentBlessings[1] >= 5 && pageReady(){
                        currentBlessings[1] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingPower4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +7.5% Power. \n 2/2: +10% Power."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[1] < 9 && currentBlessings[1] >= 7 && pageReady(){
                        currentBlessings[1] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingPower5?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/1: Unlocks Move 'Enrage', a self-casted buff that lowers all other cooldowns by 75%. \n (40 Second Cooldown)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[1] < 10 && currentBlessings[1] >= 9 && pageReady(){
                        currentBlessings[1] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingResistance1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/3: +1% Damage Resistance. \n 2/3: +2.5% Damage Resistance. \n 3/3: +5% Damage Resistance."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[2] < 3 && pageReady(){
                        currentBlessings[2] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingResistance2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +5 Damage Resistance. \n 2/2: +10 Damage Resistance."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[2] < 5 && currentBlessings[2] >= 3 && pageReady(){
                        currentBlessings[2] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingResistance3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +25 Max HP.\n 2/2: +50 Max HP."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[2] < 7 && currentBlessings[2] >= 5 && pageReady(){
                        currentBlessings[2] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingResistance4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +7.5% Damage Resistance. \n 2/2: +10% Damage Resistance."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[2] < 9 && currentBlessings[2] >= 7 && pageReady(){
                        currentBlessings[2] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingResistance5?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/1: Unlocks Move 'Survivalist', a self-casted ability that heals you by 30% of missing HP. \n (45 Second Cooldown)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[2] < 10 && currentBlessings[2] >= 9 && pageReady(){
                        currentBlessings[2] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingHealing1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/3: +0.1 HP Regen. \n 2/3: +0.25 HP Regen. \n 3/3: +0.5 HP Regen. \n (This is per second)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[3] < 3 && pageReady(){
                        currentBlessings[3] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingHealing2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +2.5% Healing. \n 2/2: +5% Healing. \n (From all sources)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[3] < 5 && currentBlessings[3] >= 3 && pageReady(){
                        currentBlessings[3] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingHealing3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +1.5% of Max HP Regen.\n 2/2: +3% of Max HP Regen. \n (This is per second)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[3] < 7 && currentBlessings[3] >= 5 && pageReady(){
                        currentBlessings[3] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingHealing4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +0.75 HP Regen. \n 2/2: +1.0 HP Regen."
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[3] < 9 && currentBlessings[3] >= 7 && pageReady(){
                        currentBlessings[3] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingHealing5?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/1: Unlocks Move 'Lucky Soul', a self-casted buff that increase all healing by 75% for 4 seconds. \n (45 Second Cooldown)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[3] < 10 && currentBlessings[3] >= 9 && pageReady(){
                        currentBlessings[3] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingUtility1?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/3: -4% all Cooldowns. \n 2/3: -10% all Cooldowns. \n 3/3: -20% for all other Cooldowns. \n (Does not apply to Mastery Ability)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[4] < 3 && pageReady(){
                        currentBlessings[4] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingUtility2?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +2.5% Power Steal. \n 2/2: +5% Power Steal. \n (Applies to melee attacks only; Lasts for 1 Second)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[4] < 5 && currentBlessings[4] >= 3 && pageReady(){
                        currentBlessings[4] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingUtility3?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: +7.5% Power Steal.\n 2/2: +10% Power Steal. \n (Applies to melee attacks only; Lasts for 1 Second)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[4] < 7 && currentBlessings[4] >= 5 && pageReady(){
                        currentBlessings[4] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingUtility4?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/2: -30% all Cooldowns. \n 2/2: -40% all Cooldowns. \n (Does not apply to Mastery Ability)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[4] < 9 && currentBlessings[4] >= 7 && pageReady(){
                        currentBlessings[4] += 1
                    }
                }
                textField.resignFirstResponder()
            } else if (self.blessingUtility5?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    let message = "1/1: Unlocks Move 'Hoarder', allows user to hold an item which is then used on press. \n (5 Second Cooldown)"
                    let title = ""
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    if currentBlessings[4] < 10 && currentBlessings[4] >= 9 && pageReady() {
                        currentBlessings[4] += 1
                    }
                }
                textField.resignFirstResponder()
            }
            updateUI()
        }
    }
    
    func pageUnder17Points() -> Bool {
        var returnVal = false
        if currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4] < 17 {
            returnVal = true
        }
        
        return returnVal
    }
    
    func page17Points() -> Bool {
        var returnVal = false
        if currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4] <= 17 {
            returnVal = true
        }
        
        return returnVal
    }
    
    func pageSaveable() -> Bool {
        var returnVal = false
        if masteryPoints - (currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4]) >= 0 && page17Points() {
            returnVal = true
        }
        
        return returnVal
    }
    
    func pageReady() -> Bool {
        var returnVal = false
        if masteryPoints - (currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4]) > 0 && pageUnder17Points() {
            returnVal = true
        }
        
        return returnVal
    }
    
    func updateUI() {
        if masteryPoints > 17 {
            masteryPointCounter = 17 - (currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4])
        } else {
            masteryPointCounter = masteryPoints - (currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4])
        }
        
        masteryPointsLabel?.text = "MP x " + String(describing: masteryPointCounter)
        
        if helpMode {
            helpButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Help_Active")))
        } else {
            helpButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Help")))
        }
        
        if currentBlessings[0] > 3 {
            blessingMobilityPoints1?.text = "3/3"
        } else {
            blessingMobilityPoints1?.text = String(describing: currentBlessings[0]) + "/3"
        }
        
        if currentBlessings[1] > 3 {
            blessingPowerPoints1?.text = "3/3"
        } else {
            blessingPowerPoints1?.text = String(describing: currentBlessings[1]) + "/3"
        }
        
        if currentBlessings[2] > 3 {
            blessingResistancePoints1?.text = "3/3"
        } else {
            blessingResistancePoints1?.text = String(describing: currentBlessings[2]) + "/3"
        }
        
        if currentBlessings[3] > 3 {
            blessingHealingPoints1?.text = "3/3"
        } else {
            blessingHealingPoints1?.text = String(describing: currentBlessings[3]) + "/3"
        }
        
        if currentBlessings[4] > 3 {
            blessingUtilityPoints1?.text = "3/3"
        } else {
            blessingUtilityPoints1?.text = String(describing: currentBlessings[4]) + "/3"
        }
        
        if currentBlessings[0] > 5 {
            blessingMobilityPoints2?.text = "2/2"
        } else if currentBlessings[0] < 3 {
            blessingMobilityPoints2?.text = "0/2"
        } else {
            blessingMobilityPoints2?.text = String(describing: currentBlessings[0] - 3) + "/2"
        }
        
        if currentBlessings[1] > 5 {
            blessingPowerPoints2?.text = "2/2"
        } else if currentBlessings[1] < 3 {
            blessingPowerPoints2?.text = "0/2"
        } else {
            blessingPowerPoints2?.text = String(describing: currentBlessings[1] - 3) + "/2"
        }
        
        if currentBlessings[2] > 5 {
            blessingResistancePoints2?.text = "2/2"
        } else if currentBlessings[2] < 3 {
            blessingResistancePoints2?.text = "0/2"
        } else {
            blessingResistancePoints2?.text = String(describing: currentBlessings[2] - 3) + "/2"
        }
        
        if currentBlessings[3] > 5 {
            blessingHealingPoints2?.text = "2/2"
        } else if currentBlessings[3] < 3 {
            blessingHealingPoints2?.text = "0/2"
        } else {
            blessingHealingPoints2?.text = String(describing: currentBlessings[3] - 3) + "/2"
        }
        
        if currentBlessings[4] > 5 {
            blessingUtilityPoints2?.text = "2/2"
        } else if currentBlessings[4] < 3 {
            blessingUtilityPoints2?.text = "0/2"
        } else {
            blessingUtilityPoints2?.text = String(describing: currentBlessings[4] - 3) + "/2"
        }
        
        if currentBlessings[0] > 7 {
            blessingMobilityPoints3?.text = "2/2"
        } else if currentBlessings[0] < 5 {
            blessingMobilityPoints3?.text = "0/2"
        } else {
            blessingMobilityPoints3?.text = String(describing: currentBlessings[0] - 5) + "/2"
        }
        
        if currentBlessings[1] > 7 {
            blessingPowerPoints3?.text = "2/2"
        } else if currentBlessings[1] < 5 {
            blessingPowerPoints3?.text = "0/2"
        } else {
            blessingPowerPoints3?.text = String(describing: currentBlessings[1] - 5) + "/2"
        }
        
        if currentBlessings[2] > 7 {
            blessingResistancePoints3?.text = "2/2"
        } else if currentBlessings[2] < 5 {
            blessingResistancePoints3?.text = "0/2"
        } else {
            blessingResistancePoints3?.text = String(describing: currentBlessings[2] - 5) + "/2"
        }
        
        if currentBlessings[3] > 7 {
            blessingHealingPoints3?.text = "2/2"
        } else if currentBlessings[3] < 5 {
            blessingHealingPoints3?.text = "0/2"
        } else {
            blessingHealingPoints3?.text = String(describing: currentBlessings[3] - 5) + "/2"
        }
        
        if currentBlessings[4] > 7 {
            blessingUtilityPoints3?.text = "2/2"
        } else if currentBlessings[4] < 5 {
            blessingUtilityPoints3?.text = "0/2"
        } else {
            blessingUtilityPoints3?.text = String(describing: currentBlessings[4] - 5) + "/2"
        }
        
        if currentBlessings[0] > 9 {
            blessingMobilityPoints4?.text = "2/2"
        } else if currentBlessings[0] < 7 {
            blessingMobilityPoints4?.text = "0/2"
        } else {
            blessingMobilityPoints4?.text = String(describing: currentBlessings[0] - 7) + "/2"
        }
        
        if currentBlessings[1] > 9 {
            blessingPowerPoints4?.text = "2/2"
        } else if currentBlessings[1] < 7 {
            blessingPowerPoints4?.text = "0/2"
        } else {
            blessingPowerPoints4?.text = String(describing: currentBlessings[1] - 7) + "/2"
        }
        
        if currentBlessings[2] > 9 {
            blessingResistancePoints4?.text = "2/2"
        } else if currentBlessings[2] < 7 {
            blessingResistancePoints4?.text = "0/2"
        } else {
            blessingResistancePoints4?.text = String(describing: currentBlessings[2] - 7) + "/2"
        }
        
        if currentBlessings[3] > 9 {
            blessingHealingPoints4?.text = "2/2"
        } else if currentBlessings[3] < 7 {
            blessingHealingPoints4?.text = "0/2"
        } else {
            blessingHealingPoints4?.text = String(describing: currentBlessings[3] - 7) + "/2"
        }
        
        if currentBlessings[4] > 9 {
            blessingUtilityPoints4?.text = "2/2"
        } else if currentBlessings[4] < 7 {
            blessingUtilityPoints4?.text = "0/2"
        } else {
            blessingUtilityPoints4?.text = String(describing: currentBlessings[4] - 7) + "/2"
        }
        
        if currentBlessings[0] > 9 {
            blessingMobilityPoints5?.text = "1/1"
        } else if currentBlessings[0] < 9 {
            blessingMobilityPoints5?.text = "0/1"
        }
        
        if currentBlessings[1] > 9 {
            blessingPowerPoints5?.text = "1/1"
        } else if currentBlessings[1] < 9 {
            blessingPowerPoints5?.text = "0/1"
        }
        
        if currentBlessings[2] > 9 {
            blessingResistancePoints5?.text = "1/1"
        } else if currentBlessings[2] < 9 {
            blessingResistancePoints5?.text = "0/1"
        }
        
        if currentBlessings[3] > 9 {
            blessingHealingPoints5?.text = "1/1"
        } else if currentBlessings[3] < 9 {
            blessingHealingPoints5?.text = "0/1"
        }
        
        if currentBlessings[4] > 9 {
            blessingUtilityPoints5?.text = "1/1"
        } else if currentBlessings[4] < 9 {
            blessingUtilityPoints5?.text = "0/1"
        }
        
        if currentBlessings[0] == 0 {
            if masteryPointCounter > 0 {
                blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[0] >= 10 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
        } else if currentBlessings[0] >= 9 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            } else {
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[0] >= 7 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[0] >= 5 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[0] >= 3 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        }
        
        if currentBlessings[1] == 0 {
            if masteryPointCounter > 0 {
                blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[1] >= 10 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
        } else if currentBlessings[1] >= 9 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            } else {
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[1] >= 7 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[1] >= 5 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[1] >= 3 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        }
        
        if currentBlessings[2] == 0 {
            if masteryPointCounter > 0 {
                blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[2] >= 10 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
        } else if currentBlessings[2] >= 9 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            } else {
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[2] >= 7 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[2] >= 5 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[2] >= 3 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        }
        
        if currentBlessings[3] == 0 {
            if masteryPointCounter > 0 {
                blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[3] >= 10 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
        } else if currentBlessings[3] >= 9 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            } else {
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[3] >= 7 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[3] >= 5 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[3] >= 3 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        }
        
        if currentBlessings[4] == 0 {
            if masteryPointCounter > 0 {
                blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[4] >= 10 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
        } else if currentBlessings[4] >= 9 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            } else {
                blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[4] >= 7 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[4] >= 5 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        } else if currentBlessings[4] >= 3 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Selected")))
            if masteryPointCounter > 0 {
                blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            } else {
                blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
                blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            }
        }
        
        if pageSaveable() {
            confirmButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree")))
        } else {
            confirmButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree_Disabled")))
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if editing1 {
            if textField.text! == "" {
                blessingNames[0] = "Page 1"
            } else {
                blessingNames[0] = textField.text!
            }
            textField.text = ""
        }
        
        if editing2 {
            if textField.text! == "" {
                blessingNames[1] = "Page 2"
            } else {
                blessingNames[1] = textField.text!
            }
            textField.text = ""
        }
        
        if editing3 {
            if textField.text! == "" {
                blessingNames[2] = "Page 3"
            } else {
                blessingNames[2] = textField.text!
            }
            textField.text = ""
        }
        
        if editing4 {
            if textField.text! == "" {
                blessingNames[3] = "Page 4"
            } else {
                blessingNames[3] = textField.text!
            }
            textField.text = ""
        }
        
        editing1 = false
        editing2 = false
        editing3 = false
        editing4 = false
        
        pageName1!.text = blessingNames[0]
        pageName2!.text = blessingNames[1]
        pageName3!.text = blessingNames[2]
        pageName4!.text = blessingNames[3]
    }
    
    func backToMainMenu() {
        if let view = self.view {
            view.presentScene(mainMenu)
            self.removeFromParent()
            view.ignoresSiblingOrder = false
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
}
