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

    var cannonsShot = 0;
    
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
    var age = Ages.BABY;
    
    func shootPlayer() {
        
        age = age.next
        cannonsShot = cannonsShot + 1;
        
    }
    
}
