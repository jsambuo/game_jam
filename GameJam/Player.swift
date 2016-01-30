//
//  Player.swift
//  GameJam
//
//  Created by Natasha Martinez on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerVC: SKSpriteNode {

    var cannonsShot = 0
    let SHOTS_PER_AGE = 3
    
    enum Ages: Int {
        case BABY = 0
        case TWEEN
        case YOUNG_ADULT
        case MID_ADULT
        case OLD
        
        var next: Ages {
            
            guard let newAge = Ages(rawValue: self.rawValue + 1) else {
                return Ages.BABY
            }
            return newAge
        }
        var previous: Ages {
            
            guard let newAge = Ages(rawValue: self.rawValue - 1) else {
                return Ages.OLD
            }
            return newAge
        }
    }
    
    struct Player {
        
        var isFemale: Bool
        var age: Ages
        var curShotsInAge: Int
        
        init() {
            isFemale = Bool(Int(arc4random_uniform(1)))
            age = Ages.BABY
            curShotsInAge = 0
        }
    }
    var curPlayer: Player = Player.init()
    var liniage: [Player] = []
    
    /// Get the player's new age image
    func getAssociatedImage() -> SKTexture {
        
        var imageName = ""
        switch (curPlayer.age) {
            
            case Ages.BABY:
                imageName = "sprite_baby"
            
            case Ages.TWEEN:
                imageName = (curPlayer.isFemale) ? "female_tween" : "male_tween"
                
            case Ages.YOUNG_ADULT:
                imageName = (curPlayer.isFemale) ? "female_youngAdult" : "male_youngAdult"
                
            case Ages.MID_ADULT:
                imageName = (curPlayer.isFemale) ? "female_midAdult" : "male_midAdult"
                
            case Ages.OLD:
                imageName = (curPlayer.isFemale) ? "female_old" : "male_old"
        }
        
        return SKTexture.init(imageNamed: imageName)
    }
    
    /// For new game
    func newGame() {
        
        curPlayer = Player.init()
        self.texture = getAssociatedImage()
        cannonsShot = 0
    }
    
    /// For when player is launched
    func shootPlayer() {
        
        cannonsShot = cannonsShot + 1
        
        // Update player image as needed
        curPlayer.curShotsInAge = curPlayer.curShotsInAge + 1
        if (curPlayer.curShotsInAge > SHOTS_PER_AGE) {
            curPlayer.curShotsInAge = 0
            curPlayer.age = curPlayer.age.next
            self.texture = getAssociatedImage()
        }
    }
    
    /// For marriage cannon
    func marryPlayer() {
        
    }
    
    /// For make a baby
    func haveBaby() {
        
        liniage.append(curPlayer)
        curPlayer = Player.init()
    }
    
}
























