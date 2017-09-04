//
//  DeviceInfo.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-31.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Foundation


struct DeviceInfo {
    
    var strSerial: String
    var strHardwareVersion: String
    var strFirmwareVersion: String
    var strDeviceName: String
    
    init(_ data: [String]) {
        
        
        self.strSerial            = data[0]
        self.strHardwareVersion = data[1]
        self.strFirmwareVersion = data[2]
        self.strDeviceName       = data[3]
        
    }
}

