//
//  Message.swift
//  dppFakeSms
//
//  Created by Daniel Kouba on 18/04/15.
//  Copyright (c) 2015 DéKá Studio. All rights reserved.
//

import Foundation

let min15:Double = 60*15
let min30:Double = 60*30
let min90:Double = 60*90
let hod24:Double = 60*60*24

enum MessageType
{
    case kc24
    case kc32
    case kc110
}

class Message {
    
    var type = MessageType.kc24
    var date = NSDate()
    var dateTo = NSDate()
    
    init(type:MessageType, from:NSDate) {
        date = from.copy() as! NSDate
        dateTo = from.copy() as! NSDate
        setType(type)
    }
    
    init(type:MessageType) {
        date = date.dateByAddingTimeInterval( -min15)
        dateTo = dateTo.dateByAddingTimeInterval( -min15)
        setType(type)
    }
    
    func setType(type:MessageType) {
        self.type = type
        
        switch type {
        case .kc24:
            dateTo = dateTo.dateByAddingTimeInterval(min30)
        case .kc32:
            dateTo = dateTo.dateByAddingTimeInterval(min90)
        case .kc110:
            dateTo = dateTo.dateByAddingTimeInterval(hod24)
        }
    }
    
    func getFromDay()->String {
        let formater = NSDateFormatter()
        formater.dateFormat = "d.M.YY"
        return formater.stringFromDate(date)
    }

    func getToDay()->String {
        let formater = NSDateFormatter()
        formater.dateFormat = "d.M.YY"
        return formater.stringFromDate(dateTo)
    }
    
    func getFromTime()->String {
        let formater = NSDateFormatter()
        formater.dateFormat = "HH:mm"
        return formater.stringFromDate(date)
    }
    
    func getToTime()->String {
        let formater = NSDateFormatter()
        formater.dateFormat = "HH:mm"
        return formater.stringFromDate(dateTo)
    }
    
    func getCodeString()->String    {
        return randomStringWithLength(9) as String
    }
    
    func getCodeInt()->String    {
        return randomIntWithLength(6) as String
    }
    
    func getPrice() ->String    {
        switch type {
        case .kc24:
                return "24"
        case .kc32:
            return "32"
        case .kc110:
            return "110"
        }
    }
    
    func getRecievedAt()->String {
        
       
        let calendar = NSCalendar.currentCalendar()
        
        if #available(iOS 8.0, *) {
            if  calendar.isDateInToday(date) {
                return "Dnes " + getFromTime()
            }
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 8.0, *) {
            if calendar.isDateInYesterday(date)  {
                return "Včera " + getFromTime()
            }
        } else {
            // Fallback on earlier versions
        }
        return getFromDay() + " " + getFromTime()
        
    }
    
    
    
    
    class func generate() -> [Message]
    {
        var array = [Message]()
        
        
        for i in -20..<0 {
            let interval =  Double( (i * 86400) - (random() % 3600) )
            let date = NSDate().dateByAddingTimeInterval( interval )
            
            
            var type = MessageType.kc24
            if ( random() % 10 < 3) {
                type = MessageType.kc32
            }
            let message = Message(type: type, from:date)
            
            array.append(message)
         }
        
        let theMessage = Message(type: .kc24)
        array.append(theMessage)
        
        
        return array
    }
    
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    func randomIntWithLength (len : Int) -> NSString {
        
        let letters : NSString = "0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    
    
}