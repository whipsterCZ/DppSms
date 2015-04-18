//
//  InitViewController.swift
//  dppFakeSms
//
//  Created by Daniel Kouba on 18/04/15.
//  Copyright (c) 2015 DéKá Studio. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {
    
    @IBOutlet weak var logo: UIButton!
    
    override func viewWillAppear(animated: Bool) {

        if ( DI.context.appDelegate.firstRun ) {
            DI.context.appDelegate.firstRun = false
            fakeAction(self)
        }
        
        
        logo.layer.transform = CATransform3DRotate(CATransform3DMakeRotation(1.57, 1.57, 1, 0), 0, 1, 1,0)
        logo.alpha = 0;
        
        //Define the final state (After the animation) and commit the animation
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(1)
        logo.layer.transform = CATransform3DIdentity;
        logo.alpha = 1;
        UIView.commitAnimations()
        
        
        
    }

    @IBAction func fakeAction(sender: AnyObject) {
        
        DI.context.appDelegate.messages = Message.generate()
        performSegueWithIdentifier("messages", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
