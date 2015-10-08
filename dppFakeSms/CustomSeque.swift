//
//  CustomSeque.swift
//  dppFakeSms
//
//  Created by Daniel Kouba on 18/04/15.
//  Copyright (c) 2015 DéKá Studio. All rights reserved.
//

import UIKit

class CustomSeque: UIStoryboardSegue {
    
    
    override func perform() {
        sourceViewController.navigationController!.pushViewController(destinationViewController as UIViewController, animated: false)
    }
    
}
