//
//  EndScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/22/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class EndScene:SKScene {
    var outcome:String?
    var outcomeLabel:SKLabelNode?
    var okayButton:SKSpriteNode?
    
    override func sceneDidLoad() {
        self.okayButton = self.childNode(withName: "//okayButton") as? SKSpriteNode
        self.outcomeLabel = self.childNode(withName: "//outcomeLabel") as? SKLabelNode
    }
    
    override func didMove(to view: SKView) {
        if outcome == nil {
            outcome = "LOL"
        }
        
        if outcome == "Victory" {
            outcomeLabel?.fontColor = SKColor.green
            outcomeLabel?.text = outcome! + "!"
        } else if outcome == "Defeat" {
            outcomeLabel?.fontColor = SKColor.red
            outcomeLabel?.text = outcome! + "..."
        }
        print(outcome!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.okayButton?.contains(pos))! {
                if let view = self.view {
                    view.presentScene(basherSelect)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = true
                    view.showsNodeCount = false
                }
            }
        }
    }
}
