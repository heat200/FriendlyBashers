//
//  MPTrafficHandler.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/29/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import MultipeerConnectivity

class MPTrafficHandler:NSObject,MCBrowserViewControllerDelegate {
    var outMoveCount = 0
    var started = false
    var currentTime:TimeInterval = 0
    var sentBlessings = false
    
    func startMPC() {
        if !started {
            print("Started MPTH")
            appDelegate.mpcHandler.setupPeerWithDisplayName(UIDevice.current.name)
            appDelegate.mpcHandler.setupSession()
            appDelegate.mpcHandler.advertiseSelf(true)
            
            NotificationCenter.default.addObserver(self, selector: #selector(MPTrafficHandler.peerChangedStateWithNotification), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(MPTrafficHandler.handleReceivedDataWithNotification), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
            started = true
        }
        
        connectWithPlayer()
    }
    
    func connectWithPlayer() {
        if appDelegate.mpcHandler.session != nil {
            appDelegate.mpcHandler.setupBrowser()
            appDelegate.mpcHandler.browser.delegate = self
            modeSelect?.view?.window?.rootViewController!.present(appDelegate.mpcHandler.browser,animated:true,completion:{
                if appDelegate.mpcHandler.session != nil {
                    connected = true
                    print("Connected with someone!")
                } else {
                    connected = false
                    print("No one was found.")
                }
            })
        }
    }
    
    func disconnectFromPlayers() {
        if appDelegate.mpcHandler.session != nil {
            appDelegate.mpcHandler.session = nil
            connected = false
        }
    }
    
    func peerChangedStateWithNotification(_ notification:Notification){
        let userInfo = NSDictionary(dictionary: (notification as NSNotification).userInfo!)
        let state = userInfo.object(forKey: "state") as! Int
        
        if state == MCSessionState.connected.rawValue {
            print(connected)
            
            sendPlayerSetupInfo()
        }
    }
    
    func sendPlayerSetupInfo() {
        var messageDict = [String:String]()
        messageDict = ["playerName":playerName]
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.unreliable)
            print("Sent PlayerInfo")
        } catch {
            print("Error: Couldn't send PlayerInfo")
        }
    }
    
    func handleReceivedDataWithNotification(_ notification:Notification){
        let userInfo = (notification as NSNotification).userInfo! as Dictionary
        let receivedData:Data = userInfo["data"] as! Data
        let message = try! JSONSerialization.jsonObject(with: receivedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        //let senderPeerId:MCPeerID = userInfo["peerID"] as! MCPeerID
        //let senderDisplayName = senderPeerId.displayName
        
        if message.object(forKey: "playerName") != nil {
            let playerName:String? = message.object(forKey: "playerName") as? String
            let playerAction:String? = message.object(forKey: "playerAction") as? String
            let playerMovement:String? = message.object(forKey: "playerMovement") as? String
            let chosenBasher:String? = message.object(forKey: "chosenBasher") as? String
            let playerBlessing:String? = message.object(forKey: "playerBlessing") as? String
            if chosenBasher != nil {
                if playerName == otherPlayers[0] {
                    print(playerName! + " picked " + chosenBasher!)
                    chosenBasher2 = chosenBasher!
                } else if playerName == otherPlayers[1] {
                    print(playerName! + " picked " + chosenBasher!)
                    chosenBasher3 = chosenBasher!
                } else if playerName == otherPlayers[2] {
                    print(playerName! + " picked " + chosenBasher!)
                    chosenBasher4 = chosenBasher!
                }
                basherSelect?.updateUI()
            } else if playerAction != nil {
                let playerPositionX:CGFloat? = NumberFormatter().number(from: (message.object(forKey: "playerPositionX") as? String)!) as CGFloat?
                let playerPositionY:CGFloat? = NumberFormatter().number(from: (message.object(forKey: "playerPositionY") as? String)!) as CGFloat?
                if playerName == otherPlayers[0] {
                    print("Received Action: " + playerAction! + ". Movement: " + playerMovement!)
                    gameScene?.playerNode2?.playerAction = playerAction!
                    gameScene?.playerNode2?.playerMovement = playerMovement!
                    gameScene?.playerNode2?.position.x = playerPositionX!
                    gameScene?.playerNode2?.position.y = playerPositionY!
                    gameScene?.playerNode2?.checkBlockUnder()
                    gameScene?.playerNode2?.performFrameBasedUpdates(currentTime)
                    if playerMovement! == "Move_Left" {
                        gameScene?.playerNode2?.xScale = -1
                    } else if playerMovement! == "Move_Right" {
                        gameScene?.playerNode2?.xScale = 1
                    }
                } else if playerName == otherPlayers[1] {
                    gameScene?.playerNode3?.playerAction = playerAction!
                    gameScene?.playerNode3?.playerMovement = playerMovement!
                    gameScene?.playerNode3?.position.x = playerPositionX!
                    gameScene?.playerNode3?.position.y = playerPositionY!
                    gameScene?.playerNode3?.checkBlockUnder()
                    gameScene?.playerNode3?.performFrameBasedUpdates(currentTime)
                    if playerMovement! == "Move_Left" {
                        gameScene?.playerNode3?.xScale = -1
                    } else if playerMovement! == "Move_Right" {
                        gameScene?.playerNode3?.xScale = 1
                    }
                } else if playerName == otherPlayers[2] {
                    gameScene?.playerNode4?.playerAction = playerAction!
                    gameScene?.playerNode4?.playerMovement = playerMovement!
                    gameScene?.playerNode4?.position.x = playerPositionX!
                    gameScene?.playerNode4?.position.y = playerPositionY!
                    gameScene?.playerNode4?.checkBlockUnder()
                    gameScene?.playerNode4?.performFrameBasedUpdates(currentTime)
                    if playerMovement! == "Move_Left" {
                        gameScene?.playerNode4?.xScale = -1
                    } else if playerMovement! == "Move_Right" {
                        gameScene?.playerNode4?.xScale = 1
                    }
                }
            } else if playerBlessing != nil {
                print("Received Player Blessings for " + playerName!)
                let playerBlessing1:Int? = NumberFormatter().number(from: (message.object(forKey: "playerBlessings_1") as? String)!) as Int?
                let playerBlessing2:Int? = NumberFormatter().number(from: (message.object(forKey: "playerBlessings_2") as? String)!) as Int?
                let playerBlessing3:Int? = NumberFormatter().number(from: (message.object(forKey: "playerBlessings_3") as? String)!) as Int?
                let playerBlessing4:Int? = NumberFormatter().number(from: (message.object(forKey: "playerBlessings_4") as? String)!) as Int?
                let playerBlessing5:Int? = NumberFormatter().number(from: (message.object(forKey: "playerBlessings_5") as? String)!) as Int?
                print("1: " + String(playerBlessing1!))
                print("2: " + String(playerBlessing2!))
                print("3: " + String(playerBlessing3!))
                print("4: " + String(playerBlessing4!))
                print("5: " + String(playerBlessing5!))
                if otherPlayers[0] == playerName! {
                    otherPlayerBlessings[0][0] = playerBlessing1!
                    otherPlayerBlessings[0][1] = playerBlessing2!
                    otherPlayerBlessings[0][2] = playerBlessing3!
                    otherPlayerBlessings[0][3] = playerBlessing4!
                    otherPlayerBlessings[0][4] = playerBlessing5!
                } else if otherPlayers[1] == playerName! {
                    otherPlayerBlessings[1][0] = playerBlessing1!
                    otherPlayerBlessings[1][1] = playerBlessing2!
                    otherPlayerBlessings[1][2] = playerBlessing3!
                    otherPlayerBlessings[1][3] = playerBlessing4!
                    otherPlayerBlessings[1][4] = playerBlessing5!
                } else if otherPlayers[2] == playerName! {
                    otherPlayerBlessings[2][0] = playerBlessing1!
                    otherPlayerBlessings[2][1] = playerBlessing2!
                    otherPlayerBlessings[2][2] = playerBlessing3!
                    otherPlayerBlessings[2][3] = playerBlessing4!
                    otherPlayerBlessings[2][4] = playerBlessing5!
                }
                
                if !sentBlessings {
                    self.sendPlayerBlessings()
                }
            } else if playerName != nil {
                if otherPlayers[0] == "" && otherPlayers[0] != playerName {
                    otherPlayers[0] = playerName!
                    print("Player 2 is " + playerName!)
                } else if otherPlayers[1] == "" && otherPlayers[1] != playerName && otherPlayers[0] != playerName {
                    otherPlayers[1] = playerName!
                    print("Player 3 is " + playerName!)
                } else if otherPlayers[2] == "" && otherPlayers[2] != playerName && otherPlayers[1] != playerName && otherPlayers[0] != playerName {
                    otherPlayers[2] = playerName!
                    print("Player 4 is " + playerName!)
                }
            }
        } else if message.object(forKey: "backToModeSelect") != nil {
            let msg:String? = message.object(forKey: "backToModeSelect") as? String
            
            if msg == "BACK" {
                basherSelect?.backToModeSelect()
            }
        } else if message.object(forKey: "gameMode") != nil {
            let newGameMode:String? = message.object(forKey: "gameMode") as? String
            
            chosenMode = newGameMode!
            modeSelect?.updateUI()
        } else if message.object(forKey: "chosenMap") != nil {
            let newMap:String? = message.object(forKey: "chosenMap") as? String
            
            chosenMap = newMap!
            basherSelect?.updateUI()
        } else if message.object(forKey: "timeLimit") != nil {
            let newTimeLimit:Int? = message.object(forKey: "timeLimit") as? Int
            let newDeathMode:Int? = message.object(forKey: "deathMode") as? Int
            
            timeLimit = newTimeLimit!
            deathMode = newDeathMode!
        } else if message.object(forKey: "chooseBasher") != nil {
            let msg:String? = message.object(forKey: "chooseBasher") as? String
            if msg == "CHOOSE" {
                modeSelect?.headToBasherSelect(true)
            }
        } else if message.object(forKey: "startGame") != nil {
            let msg:String? = message.object(forKey: "startGame") as? String
            if msg == "START" {
                print("GAME STARTING")
                basherSelect?.headToGameScene()
            }
        } else if message.object(forKey: "pauseGame") != nil {
            let msg:String? = message.object(forKey: "pauseGame") as? String
            if msg == "TOGGLE_PAUSE" {
                gameScene?.togglePause(true)
            }
        } else if message.object(forKey: "quitGame") != nil {
            let msg:String? = message.object(forKey: "quitGame") as? String
            if msg == "QUIT" {
                gameScene?.quitGame(true)
            }
        } else if message.object(forKey: "endGame") != nil {
            let msg:String? = message.object(forKey: "endGame") as? String
            if msg == "Victory" {
                gameScene?.endScreen("Victory", receiving: true)
            } else if msg == "Defeat" {
                gameScene?.endScreen("Defeat", receiving: true)
            }
        }
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        appDelegate.mpcHandler.browser.dismiss(animated: true, completion: {})
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        appDelegate.mpcHandler.browser.dismiss(animated: true, completion: {})
    }
    
    func sendPlayerCharacter() {
        let messageDict = ["playerName":playerName,"chosenBasher":chosenBasher]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
            //print("Sent Player#")
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
    
    func sendChooseBasherMsg() {
        let messageDict = ["chooseBasher":"CHOOSE"]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
    
    func sendStartGameMessage() {
        print("GAME STARTING")
        
        let messageDict = ["startGame":"START"]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
    
    func sendTogglePauseGameMessage() {
        let messageDict = ["pauseGame":"TOGGLE_PAUSE"]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
    
    func sendQuitGameMessage() {
        self.sentBlessings = false
        let messageDict = ["quitGame":"QUIT"]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
    
    func sendEndGameMessage(_ condition:String) {
        self.sentBlessings = false
        let messageDict = ["endGame":condition]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
    
    func sendPlayerInfo() {
        var messageDict = [String:String]()
        outMoveCount += 1
        let player = gameScene?.playerNode!
        messageDict = ["playerName":playerName,"playerMovement":(player?.playerMovement)!,"playerAction":(player?.playerAction)!,"playerPositionX":String(describing: (player?.position.x)!),"playerPositionY":String(describing: (player?.position.y)!),"outCount":String(outMoveCount)]
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.unreliable)
            //print("Sent PlayerInfo")
        } catch {
            print("Error: Couldn't send PlayerInfo")
        }
    }
    
    func sendPlayerBlessings() {
        self.sentBlessings = true
        var messageDict = [String:String]()
        messageDict = ["playerName":playerName,"playerBlessing":"Sent","playerBlessings_1":String(describing: blessingList[chosenBlessing][0]),"playerBlessings_2":String(describing: blessingList[chosenBlessing][1]),"playerBlessings_3":String(describing: blessingList[chosenBlessing][2]),"playerBlessings_4":String(describing: blessingList[chosenBlessing][3]),"playerBlessings_5":String(describing: blessingList[chosenBlessing][4])]
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
            print("Sent Player Blessings for " + playerName)
        } catch {
            print("Error: Couldn't send PlayerInfo")
        }
    }
    
    func confirmPlayerStats() {
        var messageDict = [String:String]()
        let player = gameScene?.playerNode!
        messageDict = ["playerName":playerName,"playerCurrentHP":String(describing: (player?.currentHP)!),"playerMaxHP":String(describing: (player?.maxHP)!),"playerCurrentSpeed":String(describing: (player?.movespeed)!),"playerCurrentResistance":String(describing: (player?.resistance)!),"playerCurrentPower":String(describing: (player?.power)!),"playerCurrentRegen":String(describing: (player?.hpRegen)!)]
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
            //print("Sent PlayerInfo")
        } catch {
            print("Error: Couldn't send PlayerInfo")
        }
    }
    
    func syncGameSettings() {
        let messageDict = ["timeLimit":timeLimit,"deathMode":deathMode] as [String : Any]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't sync game settings")
        }
    }
    
    func syncGameMode() {
        let messageDict = ["gameMode":chosenMode]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't sync gamemode")
        }
    }
    
    func syncChosenMap() {
        let messageDict = ["chosenMap":chosenMap]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't sync gamemode")
        }
    }
    
    func backToModeSelect() {
        let messageDict = ["backToModeSelect":"BACK"]
        
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.reliable)
        } catch {
            print("Error: Couldn't send Player#")
        }
    }
}
