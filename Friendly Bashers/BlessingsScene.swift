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
    
    var backButton:SKSpriteNode?
    var confirmButton:SKSpriteNode?
    var helpButton:SKSpriteNode?
    
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
    }
    
    override func didMove(to view: SKView) {
        textField = UITextField(frame: CGRect(x: self.size.width/2, y: self.size.height/2 - 50, width: 100, height: 20))
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.alphabet
        self.view?.addSubview(textField)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.backButton?.contains(pos))! {
                if let view = self.view {
                    view.presentScene(mainMenu)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = false
                }
            } else if (self.confirmButton?.contains(pos))! {
                blessingList[chosenBlessing] = currentBlessings
                print("Save blessingList here (Ln. 139 'BlessingScene')")
            } else if (self.helpButton?.contains(pos))! {
                print("Blessings?? Wtf is that?")
            } else if (self.selectPage1?.contains(pos))! {
                chosenBlessing = 0
                currentBlessings = blessingList[chosenBlessing]
                textField.resignFirstResponder()
            } else if (self.selectPage2?.contains(pos))! {
                chosenBlessing = 1
                currentBlessings = blessingList[chosenBlessing]
                textField.resignFirstResponder()
            } else if (self.selectPage3?.contains(pos))! {
                chosenBlessing = 2
                currentBlessings = blessingList[chosenBlessing]
                textField.resignFirstResponder()
            } else if (self.selectPage4?.contains(pos))! {
                chosenBlessing = 3
                currentBlessings = blessingList[chosenBlessing]
                textField.resignFirstResponder()
            } else if (self.renamePage1?.contains(pos))! {
                editing1 = true
                textField.becomeFirstResponder()
            } else if (self.renamePage2?.contains(pos))! {
                editing2 = true
                textField.becomeFirstResponder()
            } else if (self.renamePage3?.contains(pos))! {
                editing3 = true
                textField.becomeFirstResponder()
            } else if (self.renamePage4?.contains(pos))! {
                editing4 = true
                textField.becomeFirstResponder()
            } else if (self.deletePage1?.contains(pos))! {
                blessingList[0] = [0,0,0,0,0]
                blessingNames[0] = "Page 1"
                textField.resignFirstResponder()
            } else if (self.deletePage2?.contains(pos))! {
                blessingList[1] = [0,0,0,0,0]
                blessingNames[1] = "Page 2"
                textField.resignFirstResponder()
            } else if (self.deletePage3?.contains(pos))! {
                blessingList[2] = [0,0,0,0,0]
                blessingNames[2] = "Page 3"
                textField.resignFirstResponder()
            } else if (self.deletePage4?.contains(pos))! {
                blessingList[3] = [0,0,0,0,0]
                blessingNames[3] = "Page 4"
                textField.resignFirstResponder()
            } else if (self.blessingMobility1?.contains(pos))! && currentBlessings[0] < 3 && pageUnder17Points() {
                currentBlessings[0] += 1
                textField.resignFirstResponder()
            } else if (self.blessingMobility2?.contains(pos))! && currentBlessings[0] < 5 && currentBlessings[0] >= 3 && pageUnder17Points() {
                currentBlessings[0] += 1
                textField.resignFirstResponder()
            } else if (self.blessingMobility3?.contains(pos))! && currentBlessings[0] < 7 && currentBlessings[0] >= 5 && pageUnder17Points() {
                currentBlessings[0] += 1
                textField.resignFirstResponder()
            } else if (self.blessingMobility4?.contains(pos))! && currentBlessings[0] < 9 && currentBlessings[0] >= 7 && pageUnder17Points() {
                currentBlessings[0] += 1
                textField.resignFirstResponder()
            } else if (self.blessingMobility5?.contains(pos))! && currentBlessings[0] < 10 && currentBlessings[0] >= 9 && pageUnder17Points() {
                currentBlessings[0] += 1
                textField.resignFirstResponder()
            } else if (self.blessingPower1?.contains(pos))! && currentBlessings[1] < 3 && pageUnder17Points() {
                currentBlessings[1] += 1
                textField.resignFirstResponder()
            } else if (self.blessingPower2?.contains(pos))! && currentBlessings[1] < 5 && currentBlessings[1] >= 3 && pageUnder17Points() {
                currentBlessings[1] += 1
                textField.resignFirstResponder()
            } else if (self.blessingPower3?.contains(pos))! && currentBlessings[1] < 7 && currentBlessings[1] >= 5 && pageUnder17Points() {
                currentBlessings[1] += 1
                textField.resignFirstResponder()
            } else if (self.blessingPower4?.contains(pos))! && currentBlessings[1] < 9 && currentBlessings[1] >= 7 && pageUnder17Points() {
                currentBlessings[1] += 1
                textField.resignFirstResponder()
            } else if (self.blessingPower5?.contains(pos))! && currentBlessings[1] < 10 && currentBlessings[1] >= 9 && pageUnder17Points() {
                currentBlessings[1] += 1
                textField.resignFirstResponder()
            } else if (self.blessingResistance1?.contains(pos))! && currentBlessings[2] < 3 && pageUnder17Points() {
                currentBlessings[2] += 1
                textField.resignFirstResponder()
            } else if (self.blessingResistance2?.contains(pos))! && currentBlessings[2] < 5 && currentBlessings[2] >= 3 && pageUnder17Points() {
                currentBlessings[2] += 1
                textField.resignFirstResponder()
            } else if (self.blessingResistance3?.contains(pos))! && currentBlessings[2] < 7 && currentBlessings[2] >= 5 && pageUnder17Points() {
                currentBlessings[2] += 1
                textField.resignFirstResponder()
            } else if (self.blessingResistance4?.contains(pos))! && currentBlessings[2] < 9 && currentBlessings[2] >= 7 && pageUnder17Points() {
                currentBlessings[2] += 1
                textField.resignFirstResponder()
            } else if (self.blessingResistance5?.contains(pos))! && currentBlessings[2] < 10 && currentBlessings[2] >= 9 && pageUnder17Points() {
                currentBlessings[2] += 1
                textField.resignFirstResponder()
            } else if (self.blessingHealing1?.contains(pos))! && currentBlessings[3] < 3 && pageUnder17Points() {
                currentBlessings[3] += 1
                textField.resignFirstResponder()
            } else if (self.blessingHealing2?.contains(pos))! && currentBlessings[3] < 5 && currentBlessings[3] >= 3 && pageUnder17Points() {
                currentBlessings[3] += 1
                textField.resignFirstResponder()
            } else if (self.blessingHealing3?.contains(pos))! && currentBlessings[3] < 7 && currentBlessings[3] >= 5 && pageUnder17Points() {
                currentBlessings[3] += 1
                textField.resignFirstResponder()
            } else if (self.blessingHealing4?.contains(pos))! && currentBlessings[3] < 9 && currentBlessings[3] >= 7 && pageUnder17Points() {
                currentBlessings[3] += 1
                textField.resignFirstResponder()
            } else if (self.blessingHealing5?.contains(pos))! && currentBlessings[3] < 10 && currentBlessings[3] >= 9 && pageUnder17Points() {
                currentBlessings[3] += 1
                textField.resignFirstResponder()
            } else if (self.blessingUtility1?.contains(pos))! && currentBlessings[4] < 3 && pageUnder17Points() {
                currentBlessings[4] += 1
                textField.resignFirstResponder()
            } else if (self.blessingUtility2?.contains(pos))! && currentBlessings[4] < 5 && currentBlessings[4] >= 3 && pageUnder17Points() {
                currentBlessings[4] += 1
                textField.resignFirstResponder()
            } else if (self.blessingUtility3?.contains(pos))! && currentBlessings[4] < 7 && currentBlessings[4] >= 5 && pageUnder17Points() {
                currentBlessings[4] += 1
                textField.resignFirstResponder()
            } else if (self.blessingUtility4?.contains(pos))! && currentBlessings[4] < 9 && currentBlessings[4] >= 7 && pageUnder17Points() {
                currentBlessings[4] += 1
                textField.resignFirstResponder()
            } else if (self.blessingUtility5?.contains(pos))! && currentBlessings[4] < 10 && currentBlessings[4] >= 9 && pageUnder17Points() {
                currentBlessings[4] += 1
                textField.resignFirstResponder()
            }
            
            
            
            print(String(currentBlessings[0]) + "/" + String(currentBlessings[1]) + "/" + String(currentBlessings[2]) + "/" + String(currentBlessings[3]) + "/" + String(currentBlessings[4]))
        }
    }
    
    func pageUnder17Points() -> Bool {
        var returnVal = false
        if currentBlessings[0] + currentBlessings[1] + currentBlessings[2] + currentBlessings[3] + currentBlessings[4] < 17 {
            returnVal = true
        }
        
        return returnVal
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        pageName1!.text = blessingNames[0]
        pageName2!.text = blessingNames[1]
        pageName3!.text = blessingNames[2]
        pageName4!.text = blessingNames[3]
        
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
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[0] <= 3 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[0] <= 5 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[0] <= 7 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[0] <= 9 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[0] <= 10 {
            blessingMobility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingMobility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        }
        
        if currentBlessings[1] == 0 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[1] <= 3 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[1] <= 5 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[1] <= 7 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[1] <= 9 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[1] <= 10 {
            blessingPower1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingPower5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        }
        
        if currentBlessings[2] == 0 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[2] <= 3 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[2] <= 5 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[2] <= 7 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[2] <= 9 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[2] <= 10 {
            blessingResistance1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingResistance5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        }
        
        if currentBlessings[3] == 0 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[3] <= 3 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[3] <= 5 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[3] <= 7 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[3] <= 9 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[3] <= 10 {
            blessingHealing1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingHealing5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        }
        
        if currentBlessings[4] == 0 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[4] <= 3 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[4] <= 5 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[4] <= 7 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[4] <= 9 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        } else if currentBlessings[4] <= 10 {
            blessingUtility1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            blessingUtility5?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        }
        
        if pageUnder17Points() {
            confirmButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree_Disabled")))
        } else {
            confirmButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree")))
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
    }
}
