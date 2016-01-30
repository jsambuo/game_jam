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
    
    override func didMoveToView(view: SKView) {
        view.showsPhysics = true
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
        self.physicsWorld.contactDelegate = self
        
        let initialCannonNode = CannonNode(withAmmo: true)
        
        initialCannonNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(initialCannonNode)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
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
