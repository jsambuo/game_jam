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

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if let lastDropTime = self.lastDropTime {
            if currentTime - lastDropTime > dropInterval {
                let cannonNodeA = CannonNode()
                
                var randomX = CGFloat(Double(arc4random() % 256) / 256.0)
                if randomX < 0.15 {
                    randomX += 0.15
                }
                
                if randomX > 0.85 {
                    randomX -= 0.15
                }
                
                cannonNodeA.position = CGPoint(x: self.size.width * randomX, y: self.size.height + 200)
                addChild(cannonNodeA)
                
                self.lastDropTime = currentTime
            }
        } else {
            lastDropTime = currentTime
        }
    }
}
