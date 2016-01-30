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
    
    init() {
        let size = CGSize(width: 50, height: 50)
        
        super.init(texture: nil, color: .blueColor(), size: size)
        
        userInteractionEnabled = true
        
        ammoNode = SKShapeNode(circleOfRadius: self.size.height / 2)
        guard let ammoNode = ammoNode as? SKShapeNode
            else {
                return
        }
        ammoNode.fillColor = UIColor.blueColor()
        ammoNode.position = CGPoint(x: 0, y: self.size.height)
        addChild(ammoNode)
        
        let rotateLeftAction = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 1)
        let rotateRightAction = SKAction.rotateToAngle(-CGFloat(M_PI_4), duration: 1)
        let rotateArray = SKAction.sequence([rotateLeftAction, rotateRightAction])
        let repeatAction = SKAction.repeatActionForever(rotateArray)
        
        runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        shootNode()
    }
    
    func shootNode() {
        guard
            let ammoNode = self.ammoNode as? SKShapeNode,
            let parent = self.parent
        else {
                return
        }
        
        let parentPosition = convertPoint(ammoNode.position, toNode: parent)
        ammoNode.removeFromParent()
        ammoNode.position = parentPosition
        self.parent?.addChild(ammoNode)
        
        ammoNode.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        ammoNode.physicsBody?.mass = 12
        
        let dx = CGFloat(tanf(Float(self.zRotation))) * -5000
        
        ammoNode.physicsBody?.applyImpulse(CGVector(dx: dx, dy: 10000))
    }
}
