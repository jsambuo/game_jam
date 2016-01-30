//
//  CannonNode.swift
//  GameJam
//
//  Created by Nathan Feldsien on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import SpriteKit

class CannonNode: SKSpriteNode {

    var ammoNode:SKNode? = nil
    var used:Bool = false
    
    init(withAmmo:Bool) {
        let size = CGSize(width: 100, height: 100)
        
        let cannonTexture = SKTexture(imageNamed: "cannon")
        super.init(texture: nil, color: .clearColor(), size: size)
        
        physicsBody = SKPhysicsBody(texture: cannonTexture, size: size)
        physicsBody?.mass = 8
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = true
        physicsBody?.collisionBitMask = CategoryType.Cannon.rawValue
        physicsBody?.categoryBitMask = CategoryType.Cannon.rawValue
        physicsBody?.contactTestBitMask = CategoryType.Projectile.rawValue
        
        let cannonNode = SKSpriteNode(texture: cannonTexture, color: .clearColor(), size: size)
        cannonNode.zPosition = 10
        addChild(cannonNode)
        
        userInteractionEnabled = true
        
        if (withAmmo) {
            loadAmmo()
        }
        
        let rotateLeftInitialAction = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 0.5)
        runAction(rotateLeftInitialAction) { 
            let rotateLeftAction = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 1)
            let rotateRightAction = SKAction.rotateToAngle(-CGFloat(M_PI_4), duration: 1)
            let rotateArray = SKAction.sequence([rotateRightAction, rotateLeftAction])
            let repeatAction = SKAction.repeatActionForever(rotateArray)
            
            self.runAction(repeatAction)
        }
        
        let moveToBottomAction = SKAction.moveToY(-200, duration: 8)
        
        runAction(moveToBottomAction) {
            self.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        shootNode()
    }
    
    func shootNode() {
        guard
            let ammoNode = self.ammoNode as? SKSpriteNode,
            let parent = self.parent
        else {
                return
        }
        
        used = true
        
        let parentPosition = convertPoint(ammoNode.position, toNode: parent)
        ammoNode.removeFromParent()
        ammoNode.position = parentPosition
        self.parent?.addChild(ammoNode)
        
        ammoNode.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        ammoNode.physicsBody?.dynamic = true
        ammoNode.physicsBody?.mass = 8
        ammoNode.physicsBody?.categoryBitMask = CategoryType.Projectile.rawValue
        ammoNode.physicsBody?.collisionBitMask = CategoryType.Projectile.rawValue
        ammoNode.physicsBody?.contactTestBitMask = CategoryType.Cannon.rawValue
        
        let dx = CGFloat(tanf(Float(self.zRotation))) * -5000
        
        ammoNode.physicsBody?.applyImpulse(CGVector(dx: dx, dy: 10000))
        
        let rotateAction = SKAction.rotateByAngle(1, duration: 0.25)
        let repeatRotateAction = SKAction.repeatActionForever(rotateAction)
        
        ammoNode.runAction(repeatRotateAction)
    }
    
    func loadAmmo() {
        let babyTexture = SKTexture(imageNamed: "sprites_baby")
        ammoNode = SKSpriteNode(texture: babyTexture, color: .clearColor(), size: CGSize(width: 40, height: 60))
        guard let ammoNode = ammoNode as? SKSpriteNode
            else {
                return
        }
        ammoNode.position = CGPoint(x: 0, y: 30)
        ammoNode.zPosition = 1
        addChild(ammoNode)
        used = true
    }
}
