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
    var dropInterval = 1.7
    let resetGameInterval = 8.0
    var backgroundVelocity : CGFloat = 1.0
    
    var initialCannonNode: CannonNode!
    
    var hasBegunGame = false
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.81)
        self.physicsWorld.contactDelegate = self
        
        createSceneContents()
    }
    
    func createSceneContents() {
        
        initializingScrollingBackground()
        
        // Cannon
        initialCannonNode = CannonNode(withAmmo: true, hasBegunGame: false)
        initialCannonNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        initialCannonNode.removeAllActions()
        initialCannonNode.rotateAction()
        initialCannonNode.physicsBody?.dynamic = false
        initialCannonNode.cannonNodeDelegate = self
        addChild(initialCannonNode)
        
        // Reset Btn
        let resetNode = SKLabelNode(text: "Reset")
        resetNode.position = CGPoint(x: 40, y: self.size.height - 40)
        resetNode.zPosition = 100
        addChild(resetNode)
        
        // Score Label
        let scoreNode = SKLabelNode(text: "G: 1 Y: 1")
        scoreNode.position = CGPoint(x: self.size.width / 2, y: self.size.height - 40)
        scoreNode.zPosition = 100
        scoreNode.name = "score"
        addChild(scoreNode)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        if (!hasBegunGame) {
            
            hasBegunGame = true
            startGame(true)
        }
        else {
        
            let point = touch.locationInNode(self)
            for node in nodesAtPoint(point) {
                
                // Check if player tapped reset btn
                if let _ = node as? SKLabelNode {
                    resetGame()
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.moveBackground()
        
        if (hasBegunGame) {
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
            }
            else {
                lastDropTime = currentTime
            }
            
            if let playerNode = childNodeWithName("player") as? PlayerNode {
                
                // Update score label
                if let scoreNode = childNodeWithName("score") as? SKLabelNode {
                    let year = playerNode.curPlayer.curShotsInAge
                    let generation = playerNode.curPlayer.generation
                    scoreNode.text = "G: \(generation) Y: \(year)"
                }
                
                if playerNode.parent == self {
                    if playerNode.position.y < 0 {
                        playerNode.removeFromParent()
                        NSNotificationCenter.defaultCenter().postNotificationName("EndGame", object: playerNode.liniage)
                    }
                }
            }
        }
    }
    
    func startGame(shouldStartCannon: Bool) {
        
        self.hasBegunGame = true
        
        if (shouldStartCannon) {
            
            // Start dropping the cannon
            initialCannonNode.hasBegunGame = true
            initialCannonNode.physicsBody?.dynamic = true
            initialCannonNode.moveToBottomAction()
        }
        
        // Remove tap to start label
        
        
    }
    
    func initializingScrollingBackground() {
        for index in 0 ..< 2 {
            let bg = SKSpriteNode(imageNamed: "sky-1")
            bg.position = CGPoint(x: 0, y: index * Int(bg.size.height))
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            bg.zPosition = 0
            self.addChild(bg)
        }
    }
    
    func moveBackground() {
        self.enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x, y: bg.position.y - self.backgroundVelocity)
                
                // Checks if bg node is completely scrolled off the screen, if yes, then puts it at the end of the other node.
                if bg.position.y <= -bg.size.height {
                    bg.position = CGPointMake(bg.position.x, bg.position.y + bg.size.height * 2)
                }
            }
        })
    }
    
    func resetGame() {
        self.removeAllChildren()
        self.removeAllActions()
        self.createSceneContents()
    }
}

extension GameScene:SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == CategoryType.Projectile.rawValue {
            guard
                let cannonNode = contact.bodyB.node as? CannonNode,
                let projectileNode = contact.bodyA.node as? PlayerNode
                else {
                    return
            }
            
            if (cannonNode.used == false) {
                projectileNode.removeFromParent()
                cannonNode.loadAmmo(projectileNode)
            }
        }
        
        if contact.bodyB.categoryBitMask == CategoryType.Projectile.rawValue {
            guard
                let cannonNode = contact.bodyA.node as? CannonNode,
                let projectileNode = contact.bodyB.node as? PlayerNode
                else {
                    return
            }
            
            if (cannonNode.used == false) {
                projectileNode.removeFromParent()
                cannonNode.loadAmmo(projectileNode)
            }
        }
    }
}


extension GameScene: CannonNodeDelegate {
    
    func cannonStartGame() {
        startGame(false)
    }
}
