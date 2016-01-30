//
//  GameScene.swift
//  GameJam
//
//  Created by Nathan Feldsien on 1/29/16.
//  Copyright (c) 2016 CodeDezyn. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var lastDropTime:CFTimeInterval? = nil
    var dropInterval = 1.3
    var backgroundVelocity : CGFloat = 1.0
    
    override func didMoveToView(view: SKView) {
        view.showsPhysics = true
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
        self.physicsWorld.contactDelegate = self
        
        initializingScrollingBackground()
        
        let initialCannonNode = CannonNode(withAmmo: true)
        
        initialCannonNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(initialCannonNode)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.moveBackground()
        
        if let lastDropTime = self.lastDropTime {
            if currentTime - lastDropTime > dropInterval {
                let cannonNodeA = CannonNode(withAmmo: false)
                
                var randomX = CGFloat(Double(arc4random() % 256) / 256.0)
                if randomX < 0.15 {
                    randomX += 0.15
                }
                
                if randomX > 0.85 {
                    randomX -= 0.15
                }
                
                cannonNodeA.position = CGPoint(x: self.size.width * randomX, y: self.size.height + 100)
                addChild(cannonNodeA)
                
                self.lastDropTime = currentTime
            }
        } else {
            lastDropTime = currentTime
        }
    }
    
    func initializingScrollingBackground() {
        for index in 0 ..< 2 {
            let bg = SKSpriteNode(imageNamed: "sky-1")
            bg.position = CGPoint(x: 0, y: index * Int(bg.size.height))
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            bg.zPosition = 0
            self.addChild(bg)
        }
    }
    
    func moveBackground() {
        self.enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x, y: bg.position.y - self.backgroundVelocity)
                
                // Checks if bg node is completely scrolled off the screen, if yes, then puts it at the end of the other node.
                if bg.position.y <= -bg.size.height {
                    bg.position = CGPointMake(bg.position.x, bg.position.y + bg.size.height * 2)
                }
            }
        })
    }
}

extension GameScene:SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        guard
            let projectileNode = contact.bodyB.node as? SKSpriteNode,
            let cannonNode = contact.bodyA.node as? CannonNode
            else {
            return
        }
        
        if (cannonNode.used == false) {
            projectileNode.removeFromParent()
            cannonNode.loadAmmo()
        }
    }
}
