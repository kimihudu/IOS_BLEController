//
//  ProfileViewController.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-30.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var txtGoalSteps: UITextField!
    @IBOutlet weak var txtWeigth: UITextField!
    @IBOutlet weak var txtBattery: UITextField!
    @IBOutlet weak var txtDeviceName: UITextField!
    @IBOutlet weak var txtDeviceSerial: UITextField!
    @IBOutlet weak var txtDeviceFW: UITextField!
    @IBOutlet weak var txtDeviceHW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ulti.output(description: "[profile]actData", data: container as AnyObject)
//        displayInfo(container)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayInfo(_ data: [String:String]){
        
        if (data.count < 0)  { return }
        
        print(data["serial"]!)
        
        txtDeviceSerial.text =  String(describing: data["serial"]!)
        txtDeviceName.text =  String(describing: data["device"]!)
        txtDeviceFW.text =  String(describing: data["fw"]!)
        txtDeviceHW.text =  String(describing: data["hw"]!)
        txtBattery.text =  String(describing: data["battery"]! + "%")
//        txtGoalSteps.text =  String(describing: data["steps"])
//        txtWeigth.text =  String(describing: data["battery"])
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

}
