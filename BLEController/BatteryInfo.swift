//
//  BatteryInfo.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-31.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Foundation


struct BatteryInfo {
    
    //    hexStr = 0f 5c 00 b2 07 01 01 00 00 00 00 b2 07 01 01 04 10 05 80 63
    
    //     miband2
    //    0f --> ?
    //    4f --> level: 79%
    //    00
    //    e1
    //
    //    07
    //    08
    //    18
    //    15
    //
    //    29
    //    19
    //    f0
    //    e1
    //
    //    07
    //    08
    //    18
    //    15
    //
    //    2a
    //    19
    //    f0
    //    64
    //
    //        f			= ?
    //        30		= 48%
    //        00		= 00 = STATUS_NORMAL, 01 = STATUS_CHARGING
    //        e0 07		= 2016
    //        0b		= 11
    //        1a		= 26
    //        12		= 18
    //        23		= 35
    //        2c		= 44
    //        04		= 4 // num charges??
    //
    //        e0 07		= 2016 // last charge time
    //        0b		= 11
    //        1a		= 26
    //        17		= 23
    //        2b		= 43
    //        3b		= 59
    //        04		= 4   // num charges??
    //        64		= 100 // how much was charged
    
    //    miband1
    //    Battery Info:
    //    Level in%: byte[0]
    //    Charges:   0xffff & (0xff & byte[7] | (0xff & byte[8]) << 8)
    //    Status:    byte[9]
    //    where 1 = Battery low
    //    2 = Battery charging
    //    3 = Battery full (charging)
    //    4 = Not charging
    //
    //    Last charged Date Information (Gregorian Calendar):
    //    Year:        byte[1] + 2000
    //    Month:       byte[2]
    //    Day / date:  byte[3]
    //
    //    Hour (0-24): byte[4]
    //    Minute:      byte[5]
    //    Second:      byte[6]
    //
    //    Example response: 33 0E 09 1B 08 03 2E 06 00 04
    //    => 51 % charged
    //    => Not charging
    //    => Last charged 2014\09\27 08:03:46
    //    => 6 Cycles (seems like someone charged it before me 5 times ...)
    
    
    
    var intLevel: Int
    
    init(_ data: Data) {
        
        
        self.intLevel = Int(data[1])
    }
}
