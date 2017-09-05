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
        
        ulti.output(description: "actData", data: container as AnyObject)
        
        // Customize some properties
        ringHR.animationStyle = kCAMediaTimingFunctionLinear
//        ring1.font = UIFont.systemFont(ofSize: 70)
//        ringSteps.fontColor = UIColor.gray
        ringDist.maxValue = 10
        
        // Set the delegate
        ringHR.delegate = self
        ringSteps.delegate = self
        
        animateRing(container)

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    func animateRing(_ data: [String:String]){
        
        
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
        ringHR.animationStyle = kCAMediaTimingFunctionLinear
        ringHR.setProgress(value: valueHr, animationDuration: 5, completion: nil)
        
        ringSteps.setProgress(value: 100, animationDuration: 2) { [unowned self] in
            // Increase it more, and customize some properties
            self.ringSteps.ringStyle = UICircularProgressRingStyle(rawValue: 2)!
            self.ringSteps.setProgress(value: valueSteps, animationDuration: 3) {
//            self.ringSteps.font = UIFont.systemFont(ofSize: 50)
                print("RingSteps finished")
            }
        }
        
        // This has a max value of 10 so we set this accordingly and the view calculates how the progress should look
        ringDist.setProgress(value: valueDist, animationDuration: 6)
        ringCal.setProgress(value: valueCal, animationDuration: 3)
        
    }
    
    // The delegate method!
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        if ring === ringHR {
            print("From delegate: Ring 1 finished")
        } else if ring === ringSteps {
            print("From delegate: Ring 2 finished")
        }
    }

}
