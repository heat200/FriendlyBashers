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
        let senderPeerId:MCPeerID = userInfo["peerID"] as! MCPeerID
        let senderDisplayName = senderPeerId.displayName
        
        if message.object(forKey: "playerName") != nil {
            let playerName:String? = message.object(forKey: "playerName") as? String
            let chosenBasher:String? = message.object(forKey: "chosenBasher") as? String
            if chosenBasher != nil && !inPlay {
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
            } else if playerName != nil && !inPlay {
                if otherPlayers[0] == "" && otherPlayers[0] != playerName {
                    otherPlayers[0] = playerName!
                    print("Player 2 is " + playerName!)
                } else if otherPlayers[1] == "" && otherPlayers[1] != playerName {
                    otherPlayers[1] = playerName!
                    print("Player 3 is " + playerName!)
                } else if otherPlayers[2] == "" && otherPlayers[2] != playerName {
                    otherPlayers[2] = playerName!
                    print("Player 4 is " + playerName!)
                }
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
    
    func sendPlayerCurrentBlessings() {
        
    }
    
    func sendPlayerInfo() {
        var messageDict = [String:String]()
        outMoveCount += 1
        messageDict = ["playerName":playerName,"movement":(gameScene?.playerMovement)!,"action":(gameScene?.playerAction)!,"outCount":String(outMoveCount)]
        let messageData = try! JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        do {
            try appDelegate.mpcHandler.session.send(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, with: MCSessionSendDataMode.unreliable)
            //print("Sent PlayerInfo")
        } catch {
            print("Error: Couldn't send PlayerInfo")
        }
    }
    
    func changeinPlayStatus() {
        sendPlayerInfo()
        inPlay = true
    }
}
