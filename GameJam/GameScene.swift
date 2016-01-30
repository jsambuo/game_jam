//
//  GameScene.swift
//  GameJam
//
//  Created by Nathan Feldsien on 1/29/16.
//  Copyright (c) 2016 CodeDezyn. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        let cannonNodeA = CannonNode()
        cannonNodeA.position = CGPoint(x: self.size.width / 2, y: 100)
        addChild(cannonNodeA)
        
        let cannonNodeB = CannonNode()
        cannonNodeB.position = CGPoint(x: self.size.width / 2, y: 200)
        addChild(cannonNodeB)
        
        let cannonNodeC = CannonNode()
        cannonNodeC.position = CGPoint(x: self.size.width / 2, y: 400)
        addChild(cannonNodeC)
        
        let cannonNodeD = CannonNode()
        cannonNodeD.position = CGPoint(x: self.size.width / 2, y: 600)
        addChild(cannonNodeD)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
