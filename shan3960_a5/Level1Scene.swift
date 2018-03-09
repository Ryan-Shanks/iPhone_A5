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
    let ship = SKSpriteNode(imageNamed: "Spaceship.png")
    let invader = SKSpriteNode(imageNamed: "space-invader-small.png")
    let shipSize = CGFloat(50)
    let shipSpeed = CGFloat(25)
    var timer:Timer?

    func setup(){
        ship.position = CGPoint(x:0, y:-260)
        ship.size = CGSize(width: shipSize, height: shipSize)
        ship.name="ship"
        addChild(ship)
        
        invader.position = CGPoint(x:0,y:200)
        addChild(invader)
        let moveLeft = SKAction.moveTo(x: frame.minX + invader.frame.width / 2, duration: 5)
        let moveRight = SKAction.moveTo(x:frame.maxX - invader.frame.width / 2, duration: 5)
        invader.run(SKAction.repeatForever(SKAction.sequence([moveLeft,moveRight])))
        
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.size)
        ship.physicsBody?.isDynamic=true
        
    }
    override init(size: CGSize) {
        super.init(size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in:self)
            let theNode = self.atPoint(location)
            if theNode.name == "BulletButton" {
                print("Bullet button clicked")
                let bullet = SKSpriteNode(imageNamed: "bullet-small.png")
                bullet.position = ship.position
                addChild(bullet)
                let actionFire = SKAction.moveTo(y: 500, duration: 2)
                bullet.run(actionFire)
            } else if theNode.name == "LeftButton"{
                if ship.frame.minX - shipSpeed <= frame.minX {
                    ship.position.x = frame.minX + shipSize/2
                }else {
                    ship.position.x -= shipSpeed
                }
            } else if theNode.name == "RightButton"{
                if ship.frame.maxX + shipSpeed >= frame.maxX {
                    ship.position.x = frame.maxX - shipSize/2
                }else{
                    ship.position.x += shipSpeed
                }
            } else if theNode.name == "ship"{
                //handle drag
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


