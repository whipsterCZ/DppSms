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
        date = from.copy() as NSDate
        dateTo = from.copy() as NSDate
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
        var formater = NSDateFormatter()
        formater.dateFormat = "d.M.YY"
        return formater.stringFromDate(date)
    }

    func getToDay()->String {
        var formater = NSDateFormatter()
        formater.dateFormat = "d.M.YY"
        return formater.stringFromDate(dateTo)
    }
    
    func getFromTime()->String {
        var formater = NSDateFormatter()
        formater.dateFormat = "HH:mm"
        return formater.stringFromDate(date)
    }
    
    func getToTime()->String {
        var formater = NSDateFormatter()
        formater.dateFormat = "HH:mm"
        return formater.stringFromDate(dateTo)
    }
    
    func getCodeString()->String    {
        return randomStringWithLength(9)
    }
    
    func getCodeInt()->String    {
        return randomIntWithLength(6)
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
        
        if  calendar.isDateInToday(date) {
            return "Dnes " + getFromTime()
        }
        if calendar.isDateInYesterday(date)  {
            return "Včera " + getFromTime()
        }
        return getFromDay() + " " + getFromTime()
        
    }
    
    
    
    
    class func generate() -> [Message]
    {
        var array = [Message]()
        
        
        for i in -30..<0 {
            var interval =  Double( (i * 86400) - (random() % 3600) )
            var date = NSDate().dateByAddingTimeInterval( interval )
            
            
            var type = MessageType.kc24
            if ( random() % 10 < 3) {
                type = MessageType.kc32
            }
            var message = Message(type: type, from:date)
            
            array.append(message)
         }
        
        var theMessage = Message(type: .kc24)
        array.append(theMessage)
        
        
        return array
    }
    
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    func randomIntWithLength (len : Int) -> NSString {
        
        let letters : NSString = "0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    
    
}