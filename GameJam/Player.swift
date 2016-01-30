//
//  Player.swift
//  GameJam
//
//  Created by Natasha Martinez on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerVC: UIImageView {

    var cannonsShot = 0
    let SHOTS_PER_AGE = 3
    var curShotsInAge = 0
    
    var isFemale = true
    
    var liniage = []
    
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
    var age = Ages.BABY
    
    func getAssociatedImage() -> UIImage {
        
        switch (age) {
            case Ages.BABY:
                return UIImage.init(named: "sprites_baby")!
                
            case Ages.TWEEN:
                return UIImage.init(named: "sprites_tween")!
                
            case Ages.YOUNG_ADULT:
                return UIImage.init(named: "sprites_YA")!
                
            case Ages.MID_ADULT:
                return UIImage.init(named: "sprites_midadult")!
                
            case Ages.OLD:
                return UIImage.init(named: "sprites_old")!
        }
    }
    
    
    func newPlayer() {
        
        isFemale = Bool(Int(arc4random_uniform(1)))
        age = Ages.BABY
        cannonsShot = 0
        liniage = []
    }
    
    func shootPlayer() {
        
        cannonsShot = cannonsShot + 1
        
        curShotsInAge = curShotsInAge + 1
        if (curShotsInAge > SHOTS_PER_AGE) {
            curShotsInAge = 0
            age = age.next
        }
    }
    
}
