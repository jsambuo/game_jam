//
//  Player.swift
//  GameJam
//
//  Created by Natasha Martinez on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerNode: SKSpriteNode {

    var cannonsShot = 0
    let SHOTS_PER_AGE = 3
    
    init() {
        super.init(texture: nil, color: .clearColor(), size: CGSize(width: 40, height: 60))
        name = "player"
        texture = associatedImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    enum Masses: CGFloat {
        case BABY = 8.0
        case TWEEN = 9.0
        case YOUNG_ADULT = 10.0
        case MID_ADULT = 12.0
        case OLD = 15.0
        
        var massArray: [Masses] {
            return [Masses.BABY, Masses.TWEEN, Masses.YOUNG_ADULT, Masses.MID_ADULT, Masses.OLD]
        }
        
        var next: Masses {
            guard let currentIndex = massArray.indexOf(self)
                else {
                    return OLD
            }
            if currentIndex + 1 < massArray.count {
                return massArray[currentIndex + 1]
            } else {
                return BABY
            }
        }
        var previous: Masses {
            guard let currentIndex = massArray.indexOf(self)
                else {
                    return BABY
            }
            if currentIndex - 1 >= 0  {
                return massArray[currentIndex - 1]
            } else {
                return OLD
            }
        }
    }
    
    struct Player {
        
        var isFemale: Bool
        var age: Ages
        var mass: Masses
        var curShotsInAge: Int
        
        init() {
            isFemale = Bool(Int(arc4random_uniform(1)))
            age = Ages.BABY
            mass = Masses.BABY
            curShotsInAge = 0
        }
    }
    var curPlayer: Player = Player.init()
    var liniage: [Player] = []
    
    /// Get the player's new age image
    var associatedImage: SKTexture {
        
        var imageName = ""
        switch (curPlayer.age) {
            
            case Ages.BABY:
                imageName = "sprites_baby"
            
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
        self.texture = associatedImage
        cannonsShot = 0
    }
    
    /// For when player is launched
    func shootPlayer() {
        
        playCannonFire()
        
        cannonsShot = cannonsShot + 1
        
        // Update player image as needed
        curPlayer.curShotsInAge = curPlayer.curShotsInAge + 1
        if (curPlayer.curShotsInAge > SHOTS_PER_AGE) {
            curPlayer.curShotsInAge = 0
            curPlayer.age = curPlayer.age.next
            curPlayer.mass = curPlayer.mass.next
            self.texture = associatedImage
        }
        print(curPlayer.mass)
    }
    
    /// For marriage cannon
    func marryPlayer() {
        
        playRitualWedding()
        
    }
    
    /// For make a baby
    func haveBaby() {
        
        playRitualBirth()
        
        liniage.append(curPlayer)
        curPlayer = Player.init()
    }
    
}
























