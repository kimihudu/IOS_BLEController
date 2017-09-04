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
    let ulti = Ultilities.init()
    var actData = ["device":"",
                   "dateTime":"",
                   "steps":"",
                   "dist":"",
                   "cal":"",
                   "hr":""]
    
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
    
    @IBOutlet weak var txtShowDist: UITextField!
    @IBOutlet weak var txtShowCal: UITextField!
    @IBOutlet weak var txtShowSteps: UITextField!
    @IBOutlet weak var txtShowHeart: UITextField!
    
    @IBAction func btnGetData(_ sender: UIButton) {
        let tmp = getAct(dataName: "HistoryAct")
        
        print(tmp)
    }
    @IBAction func btnRefresh(_ sender: Any) {
        txtHR.text = ""
        txtCal.text = ""
        txtDist.text = ""
        txtSteps.text = ""
        txtBattery.text = ""
        actData.updateValue("", forKey: "steps")
        actData.updateValue("", forKey: "dist")
        actData.updateValue("", forKey: "cal")
        actData.updateValue("", forKey: "hr")
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
    
      /*scan devices*/
    @available(iOS 5.0, *)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        var msg = ""
        switch (central.state) {
            
        case .poweredOff:
            msg = "Bluetooth is off"
        case .poweredOn:
            msg = "Bluetooth is on"
            discoverDevices()
//            manager.scanForPeripherals(withServices: nil, options: nil)
        case .unsupported:
            msg = "Bluetooth unsupported"
        default: break
        }
        print("STAT: \(msg)")
    }
    

    
//    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
//        output(description: "", data: "Reconect" as AnyObject)
//    }
    
        /*connect devices*/
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        if(peripheral.name == BLE_NAME) {
            
            output(description: "Device name", data: peripheral.name as AnyObject)
            let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
            actData["device"] = peripheral.name
            actData["dateTime"] = currentTime
            self.BLEBand = peripheral
            self.BLEBand.delegate = self
            manager.stopScan()
            manager.connect(self.BLEBand, options: nil)
            
            print(actData)
            
        }
        
    }
    
    /*get service*/
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
//        print("get service")
        peripheral.discoverServices(nil)
        
    }
    
    /*get characteristics*/
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
    
    /*get data*/
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
    
    /*update display control when data changed*/
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
//        output(description: "cc", data: characteristic.uuid.uuidString as AnyObject)
//        output(description: "cc.value", data: characteristic.value as AnyObject)
//        print("---")
        
//        print(actData["device"] as! String)
//        let tmp = actData["device"] as! String
        
        txtDeviceNm.text  = actData["device"]
        
        switch characteristic.uuid.uuidString {
            
        case strUUID_SERVICE_FEE0_CHARACTERISTIC_STEPS:
            
            guard let data = characteristic.value else { return }
            output(description: "get steps", data: data as AnyObject)
            let stepInfo = StepsInfo.init(data)
            actData.updateValue(String(describing: stepInfo!.steps), forKey: "steps")
            actData.updateValue(String(describing: stepInfo!.dist), forKey: "dist")
            actData.updateValue(String(describing: stepInfo!.cal), forKey: "cal")

            txtSteps.text = String(describing: stepInfo!.steps)
            txtDist.text = String(describing: stepInfo!.dist)
            txtCal.text = String(describing: stepInfo!.cal)
            
        case strUUID_SERVICE_FEE0_CHARACTERISTIC_BATTERY:
            
            guard let data = characteristic.value else {return}
            output(description: "get device battery", data: data as AnyObject)
            txtBattery.text = String(describing: data[1])
            
        case strUUID_SERVICE_HR_CHARACTERISTIC_MUASEMENT:
            
            guard let data = characteristic.value else {return}
            output(description: "get hr muasement", data: data as AnyObject)
            
            let hrInfo = HeartRate.init(data)
            actData.updateValue(String(describing: hrInfo.hrMeasurement), forKey: "hr")
            txtHR.text = String (describing: hrInfo.hrMeasurement)
//        case strUUID_SERVICE_HR_CHARACTERISTIC_CTRLPOINT:
//            
//            guard let data = characteristic.value else {return}
//            output(description: "hr control point", data: data as AnyObject)
//            
//            var rawArray:[UInt8] = [0x01];
//            let wData = NSData(bytes: &rawArray, length: rawArray.count)
//            peripheral.writeValue(wData as Data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
            
        case strUUID_SERVICE_FEE0_CHARACTERISTIC_ACTIVITY:
            
            guard let data = characteristic.value else {return}
            output(description: "get activity", data: data as AnyObject)
            
        case strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_HW:
            
            guard characteristic.value != nil else {return}
            
        case strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_FW:
            
            guard let data = characteristic.value else {return}
            output(description: "get device fw", data: data as AnyObject)
            let fw = ulti.hexStr2Ascci(String(describing: data as AnyObject))
            txtFW.text = fw
            
        case strUUID_SERVICE_DEVICE_INFO_CHARACTERISTIC_SERIAL:
            
            guard let data = characteristic.value else {return}
            output(description: "get device serial", data: data as AnyObject)
            let serial = ulti.hexStr2Ascci(String(describing: data as AnyObject))
            txtSerial.text = serial


        default: break
            
        }
        
//        saveAct(data: actData)
        
    }
    
    /*connect fail*/
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        output(description: "failed to connect", data: peripheral as AnyObject)
        output(description: "error", data: error as AnyObject)
    }
    
    /*disconnect devices*/
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        manager.cancelPeripheralConnection(BLEBand)
        print(actData)
        saveAct(data: actData)
//        central.scanForPeripherals(withServices: nil, options: nil)
        print("disconnect device")
    }
    
    func output(description: String, data: AnyObject){
        print("\(description): \(data)")

    }
    

    
    func discoverDevices() {
        
        if(BLEBand != nil) {
            manager.cancelPeripheralConnection(BLEBand)
        }
        
        output(description: "", data: "Searching..." as AnyObject)
        manager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    /*save data*/
    /*data:
     deviceName
     dataTime
     heartRate
     steps
     distance
     calories
     */
    
    func saveAct(data: [String:String]){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //**Note:** Here we are providing the entityName **`Entity`** that we have added in the model

        // long way
//        let entity = NSEntityDescription.entity(forEntityName: "HistoryAct", in: context)
//        let myItem = NSManagedObject(entity: entity!, insertInto: context)

        //        short way
        let activity = NSEntityDescription.insertNewObject(forEntityName: "HistoryAct", into: context)
        
        
//            let dateTime = ulti.string2Date(strDate: data["dateTime"]!,dateFormat: "yyyy-MM-dd, hh:mm:ss a")
            activity.setValue(data["dateTime"], forKey: "dateTime")
            activity.setValue(data["device"], forKey: "device")
            activity.setValue(data["steps"], forKey: "steps")
            activity.setValue(data["dist"], forKey: "dist")
            activity.setValue(data["cal"], forKey: "cal")
            activity.setValue(data["hr"], forKey: "hr")
        
        
        do {
            try context.save()
            print("saved")
        }
        catch{
            print("There was an error in saving data")
        }
    }
    
    /*Retrieving Data*/
    func getAct(dataName: String) -> [[String:String]]{
        
        var historyData = [[String:String]]()
        var dailyData = [String:String]()
        
        // Obtaining data from model
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: dataName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)
//            return results
            
            if results.count > 0{

                for result in results as! [NSManagedObject]{
                    
                    dailyData["dateTime"] = String(describing: result.value(forKey: "dateTime")!)
                    dailyData["device"] = String(describing: result.value(forKey: "device")!)
                    dailyData["steps"] = String(describing: result.value(forKey: "steps")!)
                    dailyData["dist"] = String(describing: result.value(forKey: "dist")!)
                    dailyData["cal"] = String(describing: result.value(forKey: "cal")!)
                    dailyData["hr"] = String(describing: result.value(forKey: "hr")!)
                    
                    historyData.append(dailyData)
                    
                }
            
            }
            
        } catch {
            print("Error")
        }
        output(description: "history data", data: historyData as AnyObject)
        return historyData
        
    }
    
    
}



