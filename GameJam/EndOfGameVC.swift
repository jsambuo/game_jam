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
    
    @IBOutlet weak var cherubs: UIImageView!
    var cherubsOriginalY: CGFloat = 0
    
    var shouldFloat = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cherubsOriginalY = cherubs.frame.origin.y
        cherubs.frame.origin.y = self.view.frame.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate cherubs onto screen
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.cherubs.frame.origin.y = self.cherubsOriginalY
            }) { (finished) -> Void in
                // Start animate hover
                self.floatCherubs()
        }
    }
    
    func floatCherubs() {
        
        // Forever hover animation
        let hoverAmt = 15
        
        UIView.animateWithDuration(0.8, delay: 0.01, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.cherubs.frame.origin.y = self.cherubs.frame.origin.y - CGFloat(hoverAmt)
            }) { (finished) -> Void in }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}