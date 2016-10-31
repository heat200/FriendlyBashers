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
    
    func startMPC() {
        appDelegate.mpcHandler.setupPeerWithDisplayName(NSUserName())
        appDelegate.mpcHandler.setupSession()
        appDelegate.mpcHandler.advertiseSelf(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MPTrafficHandler.peerChangedStateWithNotification), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MPTrafficHandler.handleReceivedDataWithNotification), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
        
        connectWithPlayer()
    }
    
    func connectWithPlayer() {
        if appDelegate.mpcHandler.session != nil {
            appDelegate.mpcHandler.setupBrowser()
            appDelegate.mpcHandler.browser.delegate = self
            modeSelect?.view?.window?.rootViewController!.present(appDelegate.mpcHandler.browser,animated:true,completion:{})
            connected = true
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
            //print("Sent PlayerInfo")
        } catch {
            print("Error: Couldn't send PlayerInfo")
        }
    }
    
    func handleReceivedDataWithNotification(_ notification:Notification){
        let userInfo = (notification as NSNotification).userInfo! as Dictionary
        let receivedData:Data = userInfo["data"] as! Data
        let message = try! JSONSerialization.jsonObject(with: receivedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        let senderPeerId:MCPeerID = userInfo["peerID"] as! MCPeerID
        //let senderDisplayName = senderPeerId.displayName
        
        if message.object(forKey: "player") != nil {
            let playerName:String? = message.object(forKey: "playerName") as? String
            let chosenBasher:String? = message.object(forKey: "chosenBasher") as? String
            if chosenBasher != nil && !inPlay {
                
            } else if playerName != nil && !inPlay {
                if otherPlayers[0] == "" && otherPlayers[0] != playerName {
                    otherPlayers[0] = playerName!
                } else if otherPlayers[1] == "" && otherPlayers[1] != playerName {
                    otherPlayers[1] = playerName!
                } else if otherPlayers[2] == "" && otherPlayers[2] != playerName {
                    otherPlayers[2] = playerName!
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
        let messageDict = ["chosenBasher":chosenBasher]
        
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
