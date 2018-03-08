//
//  GameScene.swift
//  shan3960_a5
//
//  Created by user136098 on 3/5/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import SpriteKit
import GameplayKit

class Level1Scene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in:self)
            let theNode = self.atPoint(location)
            if theNode.name == "BackLabel" {
                print("Back button clicked")
                let menu = SKScene(fileNamed: "MenuScene");
                let transition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 2)
                self.view?.presentScene(menu!, transition: transition)
            }
        }
        
        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


