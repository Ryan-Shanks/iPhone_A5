//
//  GameScene.swift
//  shan3960_a5
//
//  Created by user136098 on 3/5/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import SpriteKit
import GameplayKit

class Level1Scene: SKScene, SKPhysicsContactDelegate {
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
        ship.physicsBody?.categoryBitMask = PhysicsCategory.Ship
        ship.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        ship.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        invader.physicsBody = SKPhysicsBody(rectangleOf: ship.size)
        invader.physicsBody?.isDynamic=true
        invader.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        invader.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        invader.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        physicsWorld.gravity = CGVector(dx:0, dy:0)
        physicsWorld.contactDelegate = self
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
                bullet.position.y += shipSize
                addChild(bullet)
                let actionFire = SKAction.moveTo(y: 500, duration: 2)
                bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
                bullet.physicsBody?.isDynamic=true
                bullet.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
                bullet.physicsBody?.contactTestBitMask = PhysicsCategory.All
                bullet.physicsBody?.collisionBitMask = PhysicsCategory.None
                bullet.run(actionFire)
                run(SKAction.playSoundFileNamed("Sounds/artillery2.m4a", waitForCompletion: false))
                
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
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in:self)
            let theNode = self.atPoint(location)
            if theNode.name == "ship" {
                ship.position.x = location.x
                if ship.position.x + shipSize / 2 > frame.maxX{
                    ship.position.x = frame.maxX - shipSize / 2;
                } else if ship.frame.minX < frame.minX {
                    ship.position.x = frame.minX + shipSize / 2
                }
            }
        }
    }
    
    func projectileDidCollideWithMonster(_ monster:SKSpriteNode, projectile:SKSpriteNode) {
        run(SKAction.playSoundFileNamed("Sounds/invaderkilled.wav", waitForCompletion: true))
        print("Hit")
        projectile.removeFromParent()
        monster.removeFromParent()
        let winScene = SKScene(fileNamed: "WinScene")
        let transition = SKTransition.doorway(withDuration: 1.0)
        self.view?.presentScene(winScene!, transition: transition) // we killed the monster, we win!
    }
    func projectileDidCollideWithShip(_ ship:SKSpriteNode, projectile:SKSpriteNode) {
        run(SKAction.playSoundFileNamed("Sounds/scream.mp3", waitForCompletion: true))
        print("Hit")
        projectile.removeFromParent()
        ship.removeFromParent()
        let loseScene = SKScene(fileNamed: "LoseScene")
        let transition = SKTransition.doorway(withDuration: 1.0)
        self.view?.presentScene(loseScene!, transition: transition) // we were killed and we lost
    }
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
        var first = contact.bodyA
        var second = contact.bodyB
        if first.categoryBitMask > second.categoryBitMask{
            let tmp = first
            first = second
            second = tmp
        }
        if first.categoryBitMask == PhysicsCategory.Projectile && second.categoryBitMask == PhysicsCategory.Ship || first.categoryBitMask == PhysicsCategory.Ship && second.categoryBitMask == PhysicsCategory.Projectile {
            //Dead
            print("dead")
            self.projectileDidCollideWithShip(second.node as! SKSpriteNode, projectile: first.node as! SKSpriteNode)
        }else if first.categoryBitMask == PhysicsCategory.Monster && second.categoryBitMask == PhysicsCategory.Projectile {
            projectileDidCollideWithMonster(first.node as! SKSpriteNode, projectile: second.node as! SKSpriteNode)
        }
    }
    
    var lastFired:TimeInterval = 0.0
    override func update(_ currentTime: TimeInterval) {
        if currentTime - lastFired > 1 {
            //invader should fire a bullet
            let rock = SKSpriteNode(imageNamed: "rock.png")
            rock.position = invader.position
            rock.position.y -= 40
            addChild(rock)
            let actionFire = SKAction.moveTo(y: -500, duration: 2)
            rock.physicsBody = SKPhysicsBody(rectangleOf: rock.size)
            rock.physicsBody?.isDynamic=true
            rock.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
            rock.physicsBody?.collisionBitMask = PhysicsCategory.None
            rock.physicsBody?.contactTestBitMask = PhysicsCategory.All
            rock.run(actionFire)
            run(SKAction.playSoundFileNamed("Sounds/artillery2.m4a", waitForCompletion: false))
            rock.run(actionFire)
            rock.scale(to: CGSize(width:20, height:20))
            lastFired = currentTime
        }
    }
    
}


