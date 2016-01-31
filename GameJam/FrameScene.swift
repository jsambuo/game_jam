//
//  FrameScene.swift
//  GameJam
//
//  Created by Nathan Feldsien on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import SpriteKit

class FrameScene: SKScene {
    
    var textureArray:AnyObject?
    
    override func didMoveToView(view: SKView) {
//        guard let textureArray = textureArray as?  Array<SKTexture?>
//            else {
//                return
//        }
        
        for object in textureArray as! Array<AnyObject> {
            guard let texture = object as? SKTexture
                else {
                    return
            }
            let textureNode = SKSpriteNode(texture: texture)
            textureNode.size = CGSize(width: 50, height: 50)
            textureNode.position = CGPoint(x: 50, y: 50)
            addChild(textureNode)
        }
    }
}