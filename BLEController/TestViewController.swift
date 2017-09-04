//
//  TestViewController.swift
//  BLEController
//
//  Created by kimiboo on 2017-09-03.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import UIKit
import UICircularProgressRing

class TestViewController: UIViewController {
    
    @IBOutlet weak var ring1: UICircularProgressRingView!
    @IBOutlet weak var ring2: UICircularProgressRingView!
    @IBOutlet weak var ring3: UICircularProgressRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let progressRing = UICircularProgressRingView(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
        // Change any of the properties you'd like
        progressRing.maxValue = 50
        progressRing.innerRingColor = UIColor.blue
        progressRing.setProgress(value: 49, animationDuration: 8.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
        
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

}
