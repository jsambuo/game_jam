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
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 100))
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
            let ammoNode = PlayerNode()
            loadAmmo(ammoNode)
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
            let ammoNode = self.ammoNode as? PlayerNode,
            let parent = self.parent
        else {
                return
        }
        
        used = true
        
        let parentPosition = convertPoint(ammoNode.position, toNode: parent)
        ammoNode.removeFromParent()
        ammoNode.position = parentPosition
        self.parent?.addChild(ammoNode)
        
        ammoNode.shootPlayer()

        ammoNode.physicsBody = SKPhysicsBody(rectangleOfSize: ammoNode.size)
        ammoNode.physicsBody?.dynamic = true
        ammoNode.physicsBody?.mass = ammoNode.curPlayer.mass.rawValue
        ammoNode.physicsBody?.categoryBitMask = CategoryType.Projectile.rawValue
        ammoNode.physicsBody?.collisionBitMask = CategoryType.Projectile.rawValue
        ammoNode.physicsBody?.contactTestBitMask = CategoryType.Cannon.rawValue
        
        let dx = CGFloat(tanf(Float(self.zRotation))) * -5000
        
        ammoNode.physicsBody?.applyImpulse(CGVector(dx: dx, dy: 10000))
        
        let rotateAction = SKAction.rotateByAngle(1, duration: 0.25)
        let repeatRotateAction = SKAction.repeatActionForever(rotateAction)
        
        ammoNode.runAction(repeatRotateAction)
        userInteractionEnabled = false
    }
    
    func loadAmmo(ammoNode:PlayerNode) {
        self.ammoNode = ammoNode
        guard let ammoNode = self.ammoNode
            else {
                return
        }
        
        playCannonLoad()
        
        ammoNode.hidden = true
        
        ammoNode.removeAllActions()
        ammoNode.physicsBody = nil
        
        addChild(ammoNode)
        
        ammoNode.position = CGPoint(x: 0, y: 30)
        ammoNode.zPosition = 1
        
        ammoNode.zRotation = 0
        
        used = true
        
        ammoNode.hidden = false
    }
}
