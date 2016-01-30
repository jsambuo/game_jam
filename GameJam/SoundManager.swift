//
//  SoundManager.swift
//  GameJam
//
//  Created by Natasha Martinez on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

final class SoundManager: NSObject, AVAudioPlayerDelegate {
    
    static let sharedInstance = SoundManager()
    
    var defaults: NSUserDefaults
    
    var musicPlayer: AVAudioPlayer?
    var sfxPlayer:   AVAudioPlayer?
    
    var audioSession: AVAudioSession!
    
    var interruptedOnPlayback: Bool
    var currentBackgroundTrack: NSString
    
    let trackMaxVolume:  Float = 0.15
    let volumeIncrement: Float = 0.02
    
    var isSoundOn: Bool {
        return self.defaults.boolForKey("soundOn")
    }
    
    var isMusicOn: Bool {
        return self.defaults.boolForKey("musicOn")
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // pragma mark    -   NSObject
    
    override init() {
        currentBackgroundTrack = ""
        
        defaults = NSUserDefaults.standardUserDefaults()
        
        audioSession = AVAudioSession.sharedInstance()
        
        //set session to allow mixing
        do {
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch {
            print("ERROR: -- UNABLE TO CHANGE AUDIO SESSION")
        }
        
        interruptedOnPlayback = false
        
        super.init()
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // pragma mark    -   Music Instance Methods
    
    func playTrack(trackName: NSString) {
        
        //let isMusicOn = defaults.boolForKey("musicOn")
        let isOtherAudioPlaying: Bool = audioSession.secondaryAudioShouldBeSilencedHint
        
        if( isMusicOn && !isOtherAudioPlaying ) {
            
            if( trackName != currentBackgroundTrack ) {
                
                if( musicPlayer != nil && musicPlayer!.playing ) {
                    
                    //self.fadeTrackOut()
                    musicPlayer!.stop()
                    musicPlayer = nil
                }
                
                createTrack(trackName as String)
            }
            else if ( musicPlayer == nil ) {
                createTrack(trackName as String)
            }
            else if ( !musicPlayer!.playing ) {
                createTrack(trackName as String)
            }
        }
        
        currentBackgroundTrack = trackName
    }
    
    private func createTrack(trackName: String) {
        guard let alertSound = NSBundle.mainBundle().URLForResource(trackName as String, withExtension: "mp3") else {
            return
        }
        
        do {
            let musicPlayer = try AVAudioPlayer.init(contentsOfURL: alertSound)
            
            musicPlayer.delegate = self
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0
            if musicPlayer.prepareToPlay() {
                musicPlayer.play()
            }
            
            self.musicPlayer = musicPlayer
            
            self.fadeTrackIn()
            
        } catch {
            print("ERROR: -- UNABLE TO PLAY AUDIO FROM URL")
        }
    }
    
    func playSound(soundName: NSString) {
        
        print("Sound effect")
        //let isSoundOn = defaults.boolForKey("soundOn")
        
        guard isSoundOn else {
            return
        }
        
        if let sfxPlayer = self.sfxPlayer where sfxPlayer.playing {
            //self.fadeMusicOut()
            sfxPlayer.stop()
            self.sfxPlayer = nil
        }
        //play new track
        guard let alertSound = NSBundle.mainBundle().URLForResource(soundName as String, withExtension: "caf") else {
            return
        }
        
        
        do {
            let sfxPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
            sfxPlayer.delegate = self
            sfxPlayer.numberOfLoops = 0
            sfxPlayer.volume = 1
            if sfxPlayer.prepareToPlay() {
                sfxPlayer.play()
            }
            
            self.sfxPlayer = sfxPlayer
            
        } catch {
            print("ERROR: -- UNABLE TO PLAY AUDIO FROM URL")
        }
    }
    
    func fadeTrackIn() {
        musicPlayer!.volume = musicPlayer!.volume + volumeIncrement
        
        if (musicPlayer!.volume < self.trackMaxVolume) {
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("fadeTrackIn"), userInfo: nil, repeats: false)
        }
    }
    
    func fadeTrackOut() {
        musicPlayer!.volume = musicPlayer!.volume - volumeIncrement
        
        if (musicPlayer!.volume < volumeIncrement) {
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("fadeTrackOut"), userInfo: nil, repeats: false)
        }
    }
    
    func toggleMute(musicOn: Bool) {
        
        if( !musicOn ) {
            
            if (musicPlayer != nil)
            {
                //self.fadeTrackOut()
                musicPlayer!.stop()
                musicPlayer = nil
            }
        }
        else
        {
            self.playTrack(currentBackgroundTrack)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // pragma mark    -   AVAudioPlayerDelegate Methods
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        
        interruptedOnPlayback = true
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer) {
        
        if( interruptedOnPlayback ) {
            
            player.play()
            interruptedOnPlayback = false
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // pragma mark    -   Audio Session Methods
    
    func checkExternalAudio() {
        
        let isMusicOn: Bool = defaults.objectForKey("musicOn") as! Bool
        
        if( audioSession.secondaryAudioShouldBeSilencedHint && isMusicOn ) {
            
            defaults.setBool(false, forKey: "musicOn")
        }
    }
    
    
}

