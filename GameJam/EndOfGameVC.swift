//
//  EndOfGameVC.swift
//  GameJam
//
//  Created by Natasha Martinez on 1/30/16.
//  Copyright © 2016 CodeDezyn. All rights reserved.
//

import UIKit
import SpriteKit

class EndOfGameVC: UIViewController {
    
    @IBOutlet weak var frameSKView: SKView!
    @IBOutlet weak var cherubs: UIImageView!
    
    var cherubsOriginalY: CGFloat = 0
    var shouldFloat = true
    
    var textureArray:[SKTexture]?
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildScene()
        cherubsOriginalY = cherubs.frame.origin.y
        cherubs.frame.origin.y = self.view.frame.height
        
        print(textureArray)
    }
    
    func buildScene() {
        if let scene = FrameScene(fileNamed:"FrameScene") {
            // Configure the view.
            frameSKView.showsFPS = true
            frameSKView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            frameSKView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            scene.textureArray = textureArray
            
            frameSKView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animate cherubs onto screen
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.cherubs.frame.origin.y = self.cherubsOriginalY
            }) { (finished) -> Void in
                // Start animate hover
                self.floatCherubs()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        playLoseGame()
    }
    
    /// Forever hover animation
    func floatCherubs() {
        
        let hoverAmt = 15
        
        UIView.animateWithDuration(0.8, delay: 0.01, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.cherubs.frame.origin.y = self.cherubs.frame.origin.y - CGFloat(hoverAmt)
            }) { (finished) -> Void in }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        playButtonPress()
        
        performSegueWithIdentifier("backToGame", sender: nil)
    }
}
