//
//  DI.swift
//  SpaceCrew
//
//  Created by Daniel Kouba on 29/12/14.
//  Copyright (c) 2014 Daniel Kouba. All rights reserved.
//

import Foundation
import UIKit

class DI : NSObject {
    
    class var context : DI {
        struct Static {
            static let instance = DI()
        }
        return Static.instance
    }
       
    var application: UIApplication {
        return UIApplication.sharedApplication()
    }
    
    
    var appDelegate: AppDelegate {
        return application.delegate as! AppDelegate!
    }
    
    var viewController: UIViewController? {
        return application.keyWindow?.rootViewController
    }
    
    var screenSize: CGSize  {
        return UIScreen.mainScreen().bounds.size
    }

}