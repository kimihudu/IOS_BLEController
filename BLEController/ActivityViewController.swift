//
//  ActivityViewController.swift
//  BLEController
//
//  Created by kimiboo on 2017-08-30.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import UIKit
import UICircularProgressRing

class ActivityViewController: UIViewController,UICircularProgressRingDelegate {

    @IBOutlet weak var ringHR: UICircularProgressRingView!
    @IBOutlet weak var ringSteps: UICircularProgressRingView!
    @IBOutlet weak var ringDist: UICircularProgressRingView!
    @IBOutlet weak var ringCal: UICircularProgressRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ulti.output(description: "[Activities]actData", data: container as AnyObject)
//        
//        // Customize some properties
//        ringHR.animationStyle = kCAMediaTimingFunctionLinear
//        
//        // Set the delegate
//        ringHR.delegate = self
//        ringSteps.delegate = self
//        ringCal.delegate = self
//        ringDist.delegate = self
//        
//        animateRing(container)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func animateRing(_ data: [String:String]){
        
        
        if(data.count <= 0){ return }
        
        guard let hr = NumberFormatter().number(from: data["hr"]!) else { return }
        let valueHr = CGFloat(hr)
        guard let steps = NumberFormatter().number(from: data["steps"]!) else { return }
        let valueSteps = CGFloat(steps)
        guard let dist = NumberFormatter().number(from: data["dist"]!) else { return }
        let valueDist = CGFloat(dist)
        guard let cal = NumberFormatter().number(from: data["cal"]!) else { return }
        let valueCal = CGFloat(cal)
        
         
        // Animate the views
        /*
         Send in the value you would like to update the view with.
         animationDuration when set to 0 causes view to not be animated.
         Optionally you can also supply a completion handler
         */
        
        // You can set the animationStyle like this
//        ringHR.animationStyle = kCAMediaTimingFunctionLinear
//        ringHR.setProgress(value: valueHr, animationDuration: 5, completion: nil)
        
        ringHR.setProgress(value: 0, animationDuration: 3){
            [unowned self] in
            self.ringHR.ringStyle = UICircularProgressRingStyle(rawValue: 4)!
            self.ringHR.setProgress(value: valueHr, animationDuration: 3)
        }
        
        ringSteps.setProgress(value: 0, animationDuration: 3) { [unowned self] in
            // Increase it more, and customize some properties
            self.ringSteps.ringStyle = UICircularProgressRingStyle(rawValue: 1)!
            self.ringSteps.setProgress(value: valueSteps, animationDuration: 3)
        }
        
        // This has a max value of 10 so we set this accordingly and the view calculates how the progress should look
        ringDist.setProgress(value: 0, animationDuration: 3) {
            [unowned self] in
            self.ringDist.ringStyle = UICircularProgressRingStyle(rawValue: 2)!
            self.ringDist.setProgress(value: valueDist, animationDuration: 3)

        }
        
        ringCal.setProgress(value: 0, animationDuration: 3) {
            [unowned self] in
            self.ringCal.ringStyle = UICircularProgressRingStyle(rawValue: 3)!
            self.ringCal.setProgress(value: valueCal, animationDuration: 3)
            
        }
        
        
    }
    
    // The delegate method!
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        if ring === ringHR {
            print("From delegate: Ring 1 finished")
        } else if ring === ringSteps {
            print("From delegate: Ring 2 finished")
        }else if ring === ringDist {
            print("From delegate: Ring 3 finished")
        }else if ring === ringCal {
            print("From delegate: Ring 4 finished")
        }
    }

}
