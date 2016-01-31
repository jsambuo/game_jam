//
//  GameViewController.swift
//  GameJam
//
//  Created by Nathan Feldsien on 1/29/16.
//  Copyright (c) 2016 CodeDezyn. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var soundBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        soundToggle(!SoundManager.sharedInstance.isSoundOn)
        
        playMusic()
        buildScene()
    }
    
    func buildScene() {
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func soundBtn(sender: AnyObject) {
        
        // Toggle sound
        let isSoundOn = SoundManager.sharedInstance.isSoundOn
            
        // Save
        SoundManager.sharedInstance.defaults.setBool(!isSoundOn, forKey: "soundOn")
        SoundManager.sharedInstance.defaults.setBool(!isSoundOn, forKey: "musicOn")
        
        soundToggle(isSoundOn)
    }
    
    func soundToggle(isSoundOn: Bool) {
        
        if (isSoundOn) {
            soundBtn.setImage(UIImage(named: "soundOffInactive"), forState: UIControlState.Normal)
            soundBtn.setImage(UIImage(named: "soundOffActive"),   forState: UIControlState.Highlighted)
            stopMusic()
        } else {
            soundBtn.setImage(UIImage(named: "soundOnInactive"), forState: UIControlState.Normal)
            soundBtn.setImage(UIImage(named: "soundOnActive"),   forState: UIControlState.Highlighted)
            playButtonPress()
            playMusic()
        }
    }
    
    @IBAction func backToGame(sender: UIStoryboardSegue) {
        
        dismissViewControllerAnimated(true) {
            self.buildScene()
        }
    }
}
