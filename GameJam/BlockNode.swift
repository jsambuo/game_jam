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
        
        let hue = CGFloat(Double(arc4random() % 256) / 256.0)
        let saturation = CGFloat(( Double(arc4random() % 128) / 256.0 ) + 0.5)
        let brightness = CGFloat(( Double(arc4random() % 128) / 256.0 ) + 0.5)
        let randomColor = UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        
        let random = arc4random() % 2
        print(random)
        
        let divideVertical = Bool.init(NSNumber(int: Int32(random)))
        
        var block:BlockNode!
        
        if (divideVertical) {
            let yPrimaryPosition = self.size.height / 4 + self.position.y
            
            self.size = CGSize(width: self.size.width, height: self.size.height / 2)
            
            let ySecondaryPosition = yPrimaryPosition - self.size.height
            
            self.position = CGPoint(x: self.position.x, y: yPrimaryPosition)
            
            block = BlockNode(texture: nil, color: randomColor, size: self.size)
            block.position = CGPoint(x: self.position.x, y: ySecondaryPosition)
        } else {
            let xPrimaryPosition = self.size.width / 4 + self.position.x
            
            self.size = CGSize(width: self.size.width / 2, height: self.size.height)
            
            let xSecondaryPosition = xPrimaryPosition - self.size.width
            
            self.position = CGPoint(x: xPrimaryPosition, y: self.position.y)
            
            block = BlockNode(texture: nil, color: randomColor, size: self.size)
            block.position = CGPoint(x: xSecondaryPosition, y: self.position.y)
        }
        
        self.parent?.addChild(block)
    }
}
