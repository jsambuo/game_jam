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
        let block = BlockNode(texture: nil, color: UIColor.blueColor(), size: self.size)
        
        let position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        block.position = position
        
        addChild(block)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
