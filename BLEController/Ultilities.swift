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
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
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
    
    func output(description: String, data: AnyObject){
        print("\(description): \(data)")
        
    }
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        //        let tmp1 = loadingView.frame.size.width / 2
        //        let tmp2 = loadingView.frame.size.height / 2
        //        activityIndicator.center = CGRectMake(0.0,0.0 ,0.0,0.0)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    //// In order to show the activity indicator, call the function from your view controller
    //// ViewControllerUtils().showActivityIndicator(self.view)
    //// In order to hide the activity indicator, call the function from your view controller
    //// ViewControllerUtils().hideActivityIndicator(self.view)
    


}
