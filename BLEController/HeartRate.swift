//
//  HeartRate.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-31.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Foundation



struct HeartRate{
    
    var hrMeasurement : Int
    var hrCtrlPoint   : Int
    
    init(_ data: Data) {
        
        
//        func updateHR(heartRateData: NSData) -> UInt16{
//            
//            var buffer = [UInt8](repeating: 0x00, count: heartRateData.length)
//            heartRateData.getBytes(&buffer, length: buffer.count)
//            
//            var bpm: UInt16?
//            if (buffer.count >= 2){
//                if (buffer[0] & 0x01 == 0){
//                    bpm = UInt16(buffer[1]);
//                }else {
//                    bpm = UInt16(buffer[1]) << 8
//                    bpm =  bpm! | UInt16(buffer[2])
//                }
//            }
//            
//            if let actualBpm = bpm{
//                return actualBpm
//                //            print(actualBpm)
//                
//            }else {
//                
//                return bpm!
//                //            print(bpm as Any)
//                
//            }
//        }
        
        self.hrMeasurement = Int(data[1])
        self.hrCtrlPoint = 0
        
        
        
    }
    
}
