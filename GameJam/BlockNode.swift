//
//  BlockNode.swift
//  GameJam
//
//  Created by Nathan Feldsien on 1/29/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import SpriteKit

class BlockNode: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let yPrimaryPosition = self.size.height / 4 + self.position.y
        let ySecondaryPosition = yPrimaryPosition - self.size.height
        self.size = CGSize(width: self.size.width, height: self.size.height / 2)
        self.position = CGPoint(x: self.position.x, y: yPrimaryPosition)
        
        let block = BlockNode(texture: nil, color: UIColor.redColor(), size: self.size)
        block.position = CGPoint(x: self.position.x, y: ySecondaryPosition)
        
        self.parent?.addChild(block)
    }
}
