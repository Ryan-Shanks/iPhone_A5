//
//  GameScene.swift
//  shan3960_a5
//
//  Created by user136098 on 3/5/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    deinit{
        print("Deleting the menu view controller")
    }
    override func didMove(to view: SKView) {

    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in:self)
            let theNode = self.atPoint(location)
            if theNode.name == "PlayLabel" {
                print("Play button clicked")
            } else if theNode.name == "InstructionsLabel"{
                print ("Instructions button clicked")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2)
                let scene = SKScene(fileNamed: "InstructionsScene")
                //let instructionScene = InstructionsScene(size:self.size)
                self.view?.presentScene(scene!, transition:transition)
            } else if theNode.name == "PlayMusicLabel" {
                print("Play music clicked")
            } else if theNode.name == "StopMusicLabel" {
                print("Stop music clicked")
            }
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
