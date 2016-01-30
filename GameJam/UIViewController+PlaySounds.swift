//
//  UIViewController+PlaySounds.swift
//  GameJam
//
//  Created by Natasha Martinez on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    
    ////////////////////////////////////////////  Controls  ////////////////////////////////////////////
    
    /// For stoping background music
    func stopMusic() {
        SoundManager.sharedInstance.toggleMute(false)
    }
    
    /// For starting up background music
    func restartMusic() {
        SoundManager.sharedInstance.toggleMute(true)
    }
    
    ////////////////////////////////////////////  Music  ////////////////////////////////////////////
    
    /// The game theme
    func playMusic() {
        SoundManager.sharedInstance.playTrack("gameTheme")
    }
    
    ////////////////////////////////////////////  UI / Generic  ////////////////////////////////////////////
    
    /// When pressing a UI button (generic)
    func playButtonPress() {
        SoundManager.sharedInstance.playSound("Tap2")
    }
    
    ////////////////////////////////////////////  Rituals  ////////////////////////////////////////////
    
    /// When hitting a cannon - birth
    func playRitualBirth() {
        SoundManager.sharedInstance.playSound("happyBaby")
        //SoundManager.sharedInstance.playSound("sadBaby")
    }
    
    /// When hitting a cannon - birthday
    func playRitualParty() {
        SoundManager.sharedInstance.playSound("birthdayParty")
    }
    
    /// When hitting a cannon - wedding
    func playRitualWedding() {
        SoundManager.sharedInstance.playSound("weddingBells")
    }
    
    /// When hitting a cannon - turkey
    func playRitualFood() {
        SoundManager.sharedInstance.playSound("weddingBells")
    }
    
    /// When hitting a cannon - retirement
    func playRitualRetirement() {
        SoundManager.sharedInstance.playSound("weddingBells")
    }
    
    /// When hitting a cannon - travel
    func playRitualTravel() {
        SoundManager.sharedInstance.playSound("weddingBells")
    }
    
    ////////////////////////////////////////////  Cannon  ////////////////////////////////////////////
    
    /// When firing cannon
    func playCannonFire() {
        SoundManager.sharedInstance.playSound("cannonFire")
    }
    
    /// When player collides with cannon
    func playCannonLoad() {
        SoundManager.sharedInstance.playSound("cannonLoad")
    }
    
    ////////////////////////////////////////////  Lose  ////////////////////////////////////////////
    
    /// When losing game
    func playLoseGame() {
        SoundManager.sharedInstance.playSound("deathGong")
    }
}









