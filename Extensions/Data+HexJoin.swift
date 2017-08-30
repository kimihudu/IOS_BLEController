//
//  Data+HexJoin.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-27.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Swift
import CoreData


extension Data {
    
    /// Create hexadecimal string representation of `Data` object.
    
    /// - returns: `String` representation of this `Data` object.
    
//    func hexadecimal() -> String {
//        return map { String(format: "%02x", $0) }
//            .joined(separator: "")
//    }
    
    var bytes : [UInt8]{
        return [UInt8](self)
    }
}
