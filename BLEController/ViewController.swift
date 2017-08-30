//
//  ViewController.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-21.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreData

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var manager:CBCentralManager!
    var BLEBand:CBPeripheral!
    
    let BLE_NAME                                     = "MI Band 2"

    //    UUID services
    
    let strUUID_SERVICE_DEVICE_INFO                     = "180A"  // --> "Device Information"
    let strUUID_SERVICE_UNKNOWN                         = "00001530-0000-3512-2118-0009AF100700"
    let strUUID_SERVICE_ALERT_NOTIFICATION              = "1811"
    let strUUID_SERVICE_ALERT_IMEDIATE                  = "1802"
    let strUUID_SERVICE_HEART_RATE                      = "180D" // --> "Heart Rate"
    let strUUID_SERVICE_FEE0                            = "FEE0"
    let strUUID_SERVICE_FEE1                            = "FEE1"
    
    let strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_SERIAL   = "2A25"
    let strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_HW       = "2A27"
    let strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_FW       = "2A28"
    let strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_SYSTEMID = "2A23"
    let strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_PnPID    = "2A50"
    
    let strUUID_SERVICE_HR_CHARACTERISTIC_MUASEMENT = "2A37"
    let strUUID_SERVICE_HR_CHARACTERISTIC_CTRLPOINT = "2A39"
    
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_9      = "00000009-0000-3512-2118-0009AF100700"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FEDD   = "FEDD"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FEDE   = "FEDE"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FEDF   = "FEDF"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FED0   = "FED0"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FED1   = "FED1"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FED2   = "FED2"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FED3   = "FED3"
    let strUUID_SERVICE_FEE1_CHARACTERISTIC_UNKNOWN_FEC1   = "0000FEC1-0000-3512-2118-0009AF100700"
    
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 2A2B
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 00000001-0000-3512-2118-0009AF100700
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 00000002-0000-3512-2118-0009AF100700
    let strUUID_SERVICE_FEE0_CHARACTERISTIC_CONFIGURATION = "00000003-0000-3512-2118-0009AF100700"
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 2A04
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 00000004-0000-3512-2118-0009AF100700
    let strUUID_SERVICE_FEE0_CHARACTERISTIC_ACTIVITY      = "00000005-0000-3512-2118-0009AF100700"
    let strUUID_SERVICE_FEE0_CHARACTERISTIC_BATTERY       = "00000006-0000-3512-2118-0009AF100700"
    let strUUID_SERVICE_FEE0_CHARACTERISTIC_STEPS         = "00000007-0000-3512-2118-0009AF100700"
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 00000008-0000-3512-2118-0009AF100700
//    UUID_SERVICE_FEE0_CHARACTERISTIC: : 00000010-0000-3512-2118-0009AF100700
    
    
    
    @IBOutlet weak var txtDeviceNm: UITextField!
    @IBOutlet weak var txtFW: UITextField!
    @IBOutlet weak var txtBattery: UITextField!
    @IBOutlet weak var txtSerial: UITextField!
    
    @IBOutlet weak var txtDist: UITextField!
    @IBOutlet weak var txtCal: UITextField!
    @IBOutlet weak var txtSteps: UITextField!
    @IBOutlet weak var txtHR: UITextField!
    
    @IBAction func btnRefresh(_ sender: Any) {
        discoverDevices()
//        showAlert(msg: "scanning...",view: self)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        instant manager
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    scan devices
    @available(iOS 5.0, *)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var msg = ""
        switch (central.state) {
            
        case .poweredOff:
            msg = "Bluetooth is off"
        case .poweredOn:
            msg = "Bluetooth is on"
            manager.scanForPeripherals(withServices: nil, options: nil)
        case .unsupported:
            msg = "Bluetooth unsupported"
        default: break
        }
        print("STAT: \(msg)")
    }
    

    
//    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
//        output(description: "", data: "Reconect" as AnyObject)
//    }
    
    //    connect devices
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        if(peripheral.name == BLE_NAME) {
            
            output(description: "Device name", data: peripheral.name as AnyObject)
            self.BLEBand = peripheral
            self.BLEBand.delegate = self
            manager.stopScan()
            manager.connect(self.BLEBand, options: nil)
            
        }
        
    }
    
    //    get service
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
//        print("get service")
        peripheral.discoverServices(nil)
        
    }
    
    //    get characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if (error != nil) {
            output(description: "Error discovering services:", data: error as AnyObject)
            return
        }
        
        if let servicePeripherals = peripheral.services as [CBService]!
        {
            for service in servicePeripherals
            {
                peripheral.discoverCharacteristics(nil, for: service)
//                print("get services \(service.uuid.uuidString)")
            }
        }
    }
    
    //    get data
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if error != nil {
            output(description: "Error discovering characteristic:", data: error as AnyObject)
            return
        }

            if let characterArray = service.characteristics as [CBCharacteristic]!
            {
                
                for cc in characterArray
                {
                    peripheral.setNotifyValue(true, for: cc)
                    peripheral.readValue(for: cc)
                    
//                    switch service.uuid.uuidString {
//                        
//                    case strUUID_SERVICE_HEART_RATE:
//                        
//
//                        if cc.uuid.uuidString == strUUID_SERVICE_HR_CHARACTERISTIC_MUASEMENT{
//                            
//                            // Set notification on heart rate measurement
//                            print("Found a Heart Rate Measurement Characteristic")
//                            peripheral.setNotifyValue(true, for: cc)
//                        
//                        }else if cc.uuid.uuidString == strUUID_SERVICE_HR_CHARACTERISTIC_CTRLPOINT{
//
//                            // Write heart rate control point
//                            print("Found a Heart Rate Control Point Characteristic")
//                            
//                            var rawArray:[UInt8] = [0x01];
//                            let data = NSData(bytes: &rawArray, length: rawArray.count)
//                            peripheral.writeValue(data as Data, for: cc, type: CBCharacteristicWriteType.withResponse)
//
//                        }
//                            
////                        peripheral.readValue(for: cc)
//                        output(description: "UUID_SERVICE_HR_CHARACTERISTIC: ", data: cc.uuid.uuidString as AnyObject)
//                        
//                    case strUUID_SERVICE_FEE0:
//                        
//                        peripheral.readValue(for: cc)
//                        output(description: "UUID_SERVICE_FEE0_CHARACTERISTIC: ", data: cc.uuid.uuidString as AnyObject)
//                        
//                    case strUUID_SERVICE_FEE1:
//                        
//                        peripheral.readValue(for: cc)
//                        output(description: "UUID_SERVICE_FEE1_CHARACTERISTIC: ", data: cc.uuid.uuidString as AnyObject)
//                        
//                    case strUUID_SERVICE_DEVICE_INFO:
//                        
//                        peripheral.readValue(for: cc)
//                        output(description: "UUID_SERVICE_DEVICE_INFO_CHARACTERISTIC: ", data: cc.uuid.uuidString as AnyObject)
//                        
//                    default: break
//                        
//                    }
                    
                }
                
            }
        
    }
    
//    update notificationstate for characteristic
//    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
//        
//        if error != nil {
//            output(description: "Error discovering services:", data: error as AnyObject)
//            return
//        }
//        
//        // Notification has started
//        if (characteristic.isNotifying) {
//            output(description: "Notification began on", data: characteristic as AnyObject)
//        }
//    }
    
    //    update value data changed
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
//        output(description: "cc", data: characteristic.uuid.uuidString as AnyObject)
//        output(description: "cc.value", data: characteristic.value as AnyObject)
//        print("---")
        txtDeviceNm.text  = peripheral.name
        
        switch characteristic.uuid.uuidString {
            
        case strUUID_SERVICE_FEE0_CHARACTERISTIC_STEPS:
            
            guard let data = characteristic.value else { return }
            txtSteps.text = String(describing: (data[1] | data[2]))
            txtDist.text = String(describing: (data[5] | data[6] | data[7] | data[8]))
            txtCal.text = String(describing: (data[9] | data[10] | data[11] | data[12]))
            
        case strUUID_SERVICE_FEE0_CHARACTERISTIC_BATTERY:
            
            guard let data = characteristic.value else {return}
            txtBattery.text = String(describing: data[1])
            
        case strUUID_SERVICE_HR_CHARACTERISTIC_MUASEMENT:
            
            guard let data = characteristic.value else {return}
            updateHR(heartRateData: data as NSData)
            output(description: "hr muasement", data: data as AnyObject)
            
            
        case strUUID_SERVICE_HR_CHARACTERISTIC_CTRLPOINT:
            
            guard let data = characteristic.value else {return}
            output(description: "hr control point", data: data as AnyObject)
            
            var rawArray:[UInt8] = [0x01];
            let wData = NSData(bytes: &rawArray, length: rawArray.count)
            peripheral.writeValue(wData as Data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
            
        case strUUID_SERVICE_FEE0_CHARACTERISTIC_ACTIVITY:
            
            guard let data = characteristic.value else {return}
            output(description: "activity", data: data as AnyObject)
            
        case strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_HW:
            
            guard characteristic.value != nil else {return}
            
        case strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_FW:
            
            guard let data = characteristic.value else {return}
            let fw = hexStr2Ascci(String(describing: data as AnyObject))
            txtFW.text = fw
            
        case strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_SERIAL:
            
            guard let data = characteristic.value else {return}
            let serial = hexStr2Ascci(String(describing: data as AnyObject))
            txtSerial.text = serial


        default: break
            
        }
        
    }
    
    //    connect fail
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        output(description: "failed to connect", data: peripheral as AnyObject)
        output(description: "error", data: error as AnyObject)
    }
    
    //    disconnect devices
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        manager.cancelPeripheralConnection(BLEBand)
//        central.scanForPeripherals(withServices: nil, options: nil)
        print("disconnect device")
    }
    
    func output(description: String, data: AnyObject){
        print("\(description): \(data)")
//        print("\(description): \(data)",terminator: "")

    }
    

    
    func discoverDevices() {
        
        if(BLEBand != nil) {
            manager.cancelPeripheralConnection(BLEBand)
        }
        
        output(description: "", data: "Searching..." as AnyObject)
        manager.scanForPeripherals(withServices: nil, options: nil)
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
    
    func updateHR(heartRateData: NSData){
        
        var buffer = [UInt8](repeating: 0x00, count: heartRateData.length)
        heartRateData.getBytes(&buffer, length: buffer.count)
        
        var bpm: UInt16?
        if (buffer.count >= 2){
            if (buffer[0] & 0x01 == 0){
                bpm = UInt16(buffer[1]);
            }else {
                bpm = UInt16(buffer[1]) << 8
                bpm =  bpm! | UInt16(buffer[2])
            }
        }
        
        if let actualBpm = bpm{
            print(actualBpm)
            txtHR.text = String(describing: actualBpm as AnyObject)
        }else {
            print(bpm as Any)
//            txtHR.text = actualBpm
        }
    }
    
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
    
    
    
}

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
    var dist:   Int
    var cal:    Int
    
    
    init?(_ _data: Data) {
        
        self.steps = (Int(_data[1] | _data[2]))
        self.dist = (Int(_data[5] | _data[6] | _data[7] | _data[8]))
        self.cal = (Int(_data[9] | _data[10] | _data[11] | _data[12]))
        
    }
    
}

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

struct HeartRate{


}


