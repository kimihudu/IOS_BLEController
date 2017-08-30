//
//  String+HexConverter.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-27.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Swift
import CoreData

extension String{
//    func dataFromHexString() -> NSData? {
//        
//        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
//        // return nil for all other input characters
//        func decodeNibble(u: UInt16) -> UInt8? {
//            switch(u) {
//            case 0x30 ... 0x39:
//                return UInt8(u - 0x30)
//            case 0x41 ... 0x46:
//                return UInt8(u - 0x41 + 10)
//            case 0x61 ... 0x66:
//                return UInt8(u - 0x61 + 10)
//            default:
//                return nil
//            }
//        }
//        
//        let utf16 = self.utf16
//        guard let data = NSMutableData(capacity: utf16.count/2) else {
//            return nil
//        }
//        
//        var i = utf16.startIndex
//        while i != utf16.endIndex {
//            guard let
//                hi = decodeNibble(u: utf16[i]), let lo = decodeNibble(utf16[i.advancedBy(1, limit: utf16.endIndex)])
//                else {
//                    return nil
//            }
//            var value = hi << 4 + lo
//            data.appendBytes(&value, length: 1)
//            i = i.advancedBy(2, limit: utf16.endIndex)
//        }
//        return data
//    }
    


}


