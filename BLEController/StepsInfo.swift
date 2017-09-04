//
//  StepsInfo.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-31.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Foundation

struct StepsInfo{
    
    //    hexData =
    //    0c --> ?
    //    57 --> steps: 87
    //    00
    //    00
    //
    //    00
    //    35 --> dist: 53 m
    //    00
    //    00
    //
    //    00
    //    02 --> cal: 2
    //    00
    //    00
    //
    //    00
    //    info.steps =    ((((data[1] & 255) | ((data[2] & 255) << 8))) );
    //    info.distanza = ((((data[5] & 255) | ((data[6] & 255) << 8)) | (data[7] & 16711680)) | ((data[8] & 255) << 24));
    //    info.calorie = ((((data[9] & 255) | ((data[10] & 255) << 8)) | (data[11] & 16711680)) | ((data[12] & 255) << 24));
    //
    
    
    //    input = hex string
    //    convert to bytes[]
    //    convert to string from bytes[position]
    //    output = join after convert
    
    var steps:  Int
    var dist:   Decimal
    var cal:    Decimal
    
    
    init?(_ _data: Data) {
        
        self.steps = (Int(_data[1] | _data[2]))
        self.dist = (Decimal(_data[5] | _data[6] | _data[7] | _data[8]))
        self.cal = (Decimal(_data[9] | _data[10] | _data[11] | _data[12]))
        
    }
    
}

