//
//  HelpScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 11/21/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class HelpScene:SKScene {
    var backButton:SKSpriteNode?
    
    var Cat:SKSpriteNode?
    var Dog:SKSpriteNode?
    var Jack:SKSpriteNode?
    var Boy:SKSpriteNode?
    var Girl:SKSpriteNode?
    var Plum:SKSpriteNode?
    var Rosetta:SKSpriteNode?
    var Sarah:SKSpriteNode?
    var Silva:SKSpriteNode?
    var ItemCrate:SKSpriteNode?
    var AirPower:SKSpriteNode?
    var SugarPower:SKSpriteNode?
    var FairyPower:SKSpriteNode?
    var FiresPower:SKSpriteNode?
    var GolemsPower:SKSpriteNode?
    var IcyPower:SKSpriteNode?
    var HP_Bar:SKSpriteNode?
    var Jump:SKSpriteNode?
    var Left:SKSpriteNode?
    var Right:SKSpriteNode?
    var Teal:SKSpriteNode?
    var Beige:SKSpriteNode?
    var Limbo:SKSpriteNode?
    var Enrage:SKSpriteNode?
    var Survival:SKSpriteNode?
    var LuckySoul:SKSpriteNode?
    var Hoarder:SKSpriteNode?
    
    var positionMaxY1:CGFloat = 0
    var positionMaxY2:CGFloat = -280
    
    var animateMode = false
    
    override func sceneDidLoad() {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        
        self.Cat = self.childNode(withName: "//Cat") as? SKSpriteNode
        self.Dog = self.childNode(withName: "//Dog") as? SKSpriteNode
        self.Jack = self.childNode(withName: "//Jack") as? SKSpriteNode
        self.Boy = self.childNode(withName: "//Boy") as? SKSpriteNode
        self.Girl = self.childNode(withName: "//Girl") as? SKSpriteNode
        self.Plum = self.childNode(withName: "//Plum") as? SKSpriteNode
        self.Rosetta = self.childNode(withName: "//Rosetta") as? SKSpriteNode
        self.Sarah = self.childNode(withName: "//Sarah") as? SKSpriteNode
        self.Silva = self.childNode(withName: "//Silva") as? SKSpriteNode
        self.ItemCrate = self.childNode(withName: "//Item_Crate") as? SKSpriteNode
        self.AirPower = self.childNode(withName: "//Air_Power") as? SKSpriteNode
        self.SugarPower = self.childNode(withName: "//Sugar_Power") as? SKSpriteNode
        self.FairyPower = self.childNode(withName: "//Fairy_Power") as? SKSpriteNode
        self.FiresPower = self.childNode(withName: "//Fires_Power") as? SKSpriteNode
        self.GolemsPower = self.childNode(withName: "//Golems_Power") as? SKSpriteNode
        self.IcyPower = self.childNode(withName: "//Icy_Power") as? SKSpriteNode
        self.HP_Bar = self.childNode(withName: "//HP_Bar") as? SKSpriteNode
        self.Jump = self.childNode(withName: "//Jump") as? SKSpriteNode
        self.Left = self.childNode(withName: "//Left") as? SKSpriteNode
        self.Right = self.childNode(withName: "//Right") as? SKSpriteNode
        self.Teal = self.childNode(withName: "//Teal") as? SKSpriteNode
        self.Beige = self.childNode(withName: "//Beige") as? SKSpriteNode
        self.Limbo = self.childNode(withName: "//Limbo") as? SKSpriteNode
        self.Enrage = self.childNode(withName: "//Enrage") as? SKSpriteNode
        self.Survival = self.childNode(withName: "//Survival") as? SKSpriteNode
        self.LuckySoul = self.childNode(withName: "//Lucky_Soul") as? SKSpriteNode
        self.Hoarder = self.childNode(withName: "//Hoarder") as? SKSpriteNode
        self.camera = self.childNode(withName: "//CAMERA_NODE") as? SKCameraNode
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.backButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    self.backToMainMenu()
                })
            } else if (self.Cat?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 160HP. \n 5 Power. \n 20 Resistance. \n 0.1 HP Regen. \n 420 MS. \n \n Move Stats: \n Tag: +25 (+ 100% of  HP) MS & +20 (+20% New MS) Power. \n (Duration: 5s, CD: 9s) \n Double Slide Tackle: 15 (+50% Power) Damage (up to 2x). \n (Duration: 0s, CD: 3s) \n Slide Tackle: 15 (+50% Power) Damage. \n (Duration: 0s, CD: 1.75s)"
                let title = "About Cog: \n The (Cat)/Dog Duo"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Dog?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 240HP. \n 10 Power. \n 20 Resistance. \n 0.1 HP Regen. \n 360 MS. \n \n Move Stats: \n Tag: +25 (+ 100% of  HP) MS & +20 (+20% New MS) Power. \n (Duration: 5s, CD: 9s) \n Double Slide Tackle: 15 (+50% Power) Damage (up to 2x). \n (Duration: 0s, CD: 3s) \n Slide Tackle: 15 (+50% Power) Damage. \n (Duration: 0s, CD: 1.75s)"
                let title = "About Cog: \n The Cat/(Dog) Duo"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Jack?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 400HP. \n 20 Power. \n 40 Resistance. \n 0.1 HP Regen. \n 375 MS. \n \n Move Stats: \n Summon: summons a Zombie couple (Holds up to 4 charges; -1 Charge per Zombie). \n (Duration: 0s, CD: 6s) \n Slide Tackle: 15 (+50% Power) Damage. \n (Duration: 0s, CD: 1.75s)"
                let title = "About Jack-O: \n The Zombie Spawner"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Boy?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 20 (+10% of creator's MAX HP). \n 0 (+1% of creator's Power) Power. \n 0 (+60% of creator's Resistance) Resistance. \n 0 (-Max HP/140) HP Regen. \n 0 (+50% of creator's MS) MS. \n \n Move Stats: \n Hand Slash: 0 (+100% Power) Damage. \n (Duration: 0s, CD: 0.75s) \n (Min. Lifetime: 3.5s)"
                let title = "About Zombie Boy"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Girl?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 20 (+5% of creator's MAX HP). \n 0 (+0.5% of creator's Power) Power. \n 0 (+20% of creator's Resistance) Resistance. \n 0 (-Max HP/140) HP Regen. \n 0 (+100% of creator's MS) MS. \n \n Move Stats: \n Hand Slash: 0 (+100% Power) Damage. \n (Duration: 0s, CD: 0.75s) \n (Min. Lifetime: 3.5s)"
                let title = "About Zombie Girl"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Plum?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 225HP. \n 50 Power. \n 35 Resistance. \n 0.1 HP Regen. \n 400 MS. \n \n Move Stats: \n Kunai Throw: 5 (+ 10% of  Power) Damage. Holds 1 (+ Power/10) Charges. \n (Duration: 0s, CD: 0.8s) \n Kitana Slash: -25 (+ 100% of  Power) Damage. Holds 1 (+ Power/25) Charges. \n (Duration: 0s, CD: 1.5s) \n Slide Tackle: 15 (+50% Power) Damage. \n (Duration: 0s, CD: 1.75s)"
                let title = "About Plum: \n The Purple Ninja"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Rosetta?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 120HP. \n 60 Power. \n 35 Resistance. \n 0.1 HP Regen. \n 525 MS. \n \n Move Stats: \n Kunai Throw: 5 (+ 10% of  Power) Damage. Holds 1 (+ Power/10) Charges. \n (Duration: 0s, CD: 0.8s) \n Kitana Slash: -25 (+ 100% of  Power) Damage. Holds 1 (+ Power/25) Charges. \n (Duration: 0s, CD: 1.5s) \n Slide Tackle: 15 (+50% Power) Damage. \n (Duration: 0s, CD: 1.75s)"
                let title = "About Rosetta: \n The Pink Ninja"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Sarah?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 300HP. \n 30 Power. \n 35 Resistance. \n 0.1 HP Regen. \n 395 MS. \n \n Move Stats: \n Knife Swipe: 5 (+50% of Power) Damage. Holds 1 (+ Power/10) Charges. \n (Duration: 0s, CD: 1s) \n Gun Shot: 5 (+ 15% of Power) Damage. Holds 3 (+ Power/10) Charges. \n (Duration: 0s, CD: 0.85s) \n Slide Tackle: 15 (+50% Power) Damage. \n (Duration: 0s, CD: 1.75s)"
                let title = "About Sarah: \n The Adventurer"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Silva?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Base Stats: \n 750HP. \n 10 Power. \n 50 Resistance. \n 0.1 HP Regen. \n 375 MS. \n \n Move Stats: \n Sword Slash: 5 (+ 5% of  Power) Damage. Holds 1 (+ Power/25) Charges. \n (Duration: 0s, CD: 0.9s) \n Lions Pride: +10 (+50% of Missing HP) Power. \n (Duration: 7s, CD: 12.5s) \n Lions Rush: +10 (+50% of  HP) MS. \n (Duration: 5s, CD: 8s)"
                let title = "About Silva: \n The Golden Maned Knight"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.ItemCrate?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "Item Crates hold items that give special abilities while held, items that give permanent stat boosts, or items with on hold effects (NOT YET ADDED) \n \n Stats: \n 5 HP"
                let title = "About Item Crates"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.AirPower?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Air Crate holds the power 'Air Blast' which pushes nearby enemies away. \n \n Stats: \n 5 HP"
                let title = "About Power Crate: \n Air Crate"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.SugarPower?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Sugar Crate holds the power 'Sugar Rush' which is a self cast buff. It increases your MS by 50% and decreases your cooldowns by 30%. \n \n Stats: \n 5 HP \n Duration: 4s"
                let title = "About Power Crate: \n Sugar Crate"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.FairyPower?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Fairy Crate holds the power 'Fairys Heart' which heals the user by 10% of their Max HP. \n \n Stats: \n 5 HP"
                let title = "About Power Crate: \n Fairy Crate"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.FiresPower?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Fire Crate holds the power 'Fires Passion' which is a self cast buff. It makes those hit by your melee attacks catch fire burning them for 3s (Total burn damage being equal to the damage of your attack). \n \n Stats: \n 5 HP \n Duration: 5s"
                let title = "About Power Crate: \n Fire Crate"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.GolemsPower?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Stone Crate holds the power 'Golems Curse' which petrifies nearby enemies for 3s. \n \n Stats: \n 5 HP"
                let title = "About Power Crate: \n Stone Crate"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.IcyPower?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Ice Crate holds the power 'Icy Grasp' which is a self cast buff. It makes those hit by your melee attacks catch 'Frost Bite' reducing their MS by 5% for 1.5s. \n \n Stats: \n 5 HP \n Duration: 5s"
                let title = "About Power Crate: \n Ice Crate"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.HP_Bar?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "This is THE health bar. Health bars are placed to the left of a players' in-game icon."
                let title = "About Health Bar"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Jump?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Jump Button is used to jump. Becomes grey when your Basher has no more jumps left or while stunned or resting."
                let title = "About Jump Button"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Left?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Move Left Button is used to move left. Becomes grey while your Basher is stunned or resting."
                let title = "About Move Left Button"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Right?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Move Right Button is used to move right. Becomes grey while your Basher is stunned or resting."
                let title = "About Move Right Button"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Teal?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Teal Button is used for the Basher's most basic move. Becomes grey when your Basher has no charges left or while stunned or resting."
                let title = "About Teal Button"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Beige?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Beige Button is used for the Basher's other 2 moves (1 move while moving, 1 move while still). Becomes grey when your Basher has no charges left or while stunned or resting."
                let title = "About Beige Button"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Limbo?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Mastery Button is used for the Basher's Mastery Move. If the Mastery Button looks like this then it means your Mastery Move is 'Limbo'. Becomes grey while on cooldown."
                let title = "About Mastery Button: \n Limbo"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Enrage?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Mastery Button is used for the Basher's Mastery Move. If the Mastery Button looks like this then it means your Mastery Move is 'Enrage'. Becomes grey while on cooldown."
                let title = "About Mastery Button: \n Enrage"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Survival?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Mastery Button is used for the Basher's Mastery Move. If the Mastery Button looks like this then it means your Mastery Move is 'Survival'. Becomes grey while on cooldown."
                let title = "About Mastery Button: \n Survival"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.LuckySoul?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Mastery Button is used for the Basher's Mastery Move. If the Mastery Button looks like this then it means your Mastery Move is 'Lucky Soul'. Becomes grey while on cooldown."
                let title = "About Mastery Button: \n Lucky Soul"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            } else if (self.Hoarder?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                let message = "The Mastery Button is used for the Basher's Mastery Move. If the Mastery Button looks like this then it means your Mastery Move is 'Hoarder'. Becomes grey while on cooldown."
                let title = "About Mastery Button: \n Hoarder"
                let userInfo = ["title":title,"message":message]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
            }
        }
    }
    
    func moveThingsDown() {
        if sfxEnabled {
            self.run(clickSound)
        }
        
        self.camera?.position.y -= 140
        if self.camera!.position.y < positionMaxY1 {
            self.camera!.position.y = positionMaxY1
        }
    }
    
    func moveThingsUp() {
        if sfxEnabled {
            self.run(clickSound)
        }
        
        self.camera?.position.y += 140
        if self.camera!.position.y > positionMaxY2 {
            self.camera!.position.y = positionMaxY2
        }
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
