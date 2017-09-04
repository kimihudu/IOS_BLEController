//
//  Ultilities.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-31.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Foundation
import UIKit

class Ultilities{
    
    
    
    func showAlert(msg: String, view: UIViewController){
        let alertCtrl = UIAlertController(title: "notify",
                                          message:  msg,
                                          preferredStyle: .alert)
        
        let okAct = UIAlertAction(title: "ok", style: UIAlertActionStyle.default){
            UIAlertAction in
            NSLog("pressed ok")
        }
        
        alertCtrl.addAction(okAct)
        view.present(alertCtrl, animated: true, completion: nil)
        
    }
    
    func hexStr2Bytes(_ hexStr: String) -> [UInt8]? {
        
        let string = hexStr.replacingOccurrences(of: " ", with: "")
        let length = string.characters.count
        if (length & 1 != 0 ){
            return nil
        }
        var bytes = [UInt8]()
        bytes.reserveCapacity(length/2)
        var index = string.startIndex
        for _ in 0..<length/2 {
            let nextIndex = string.index(index, offsetBy: 2)
            if let b = UInt8(string[index..<nextIndex], radix: 16) {
                bytes.append(b)
            } else {
                return nil
            }
            index = nextIndex
        }
        return bytes
    }
    
    func hexStr2Ascci(_ hexStr: String) -> String{
        
        let hexString = hexStr.replacingOccurrences(of: " ", with: "")
        let pattern = "(0x)?([0-9a-f]{2})"
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let nsString = hexString as NSString
        let matches = regex.matches(in: hexString, options: [], range: NSMakeRange(0, nsString.length))
        let characters = matches.map {
            Character(UnicodeScalar(UInt32(nsString.substring(with: $0.rangeAt(2)), radix: 16)!)!)
        }
        return String(characters)
    }
    
    func string2Date(strDate: String, dateFormat: String) -> Date{
        
        //String to Date Convert
        
        let dateString = strDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat =  dateFormat//"yyyy-MM-dd"
        let s = dateFormatter.date(from:dateString)
        print("String2Date: \(s!)")
        return s!
        
    }
    
    func date2String(date: Date,dateFormat: String) -> String{
        
        //CONVERT FROM NSDate to String
        
        let _date = date as NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat//"yyyy-MM-dd"
        let dateString = dateFormatter.string(from:_date as Date)
        print("date2String:\(dateString)")
        return dateString
    }
    
    

}
