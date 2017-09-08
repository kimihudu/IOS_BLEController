//
//  HistoryViewController.swift
//  BLEController
//
//  Created by kimiboo on 2017-09-08.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {


    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ulti.output(description: "[History View] dataHistory", data: dataHistory as AnyObject)
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    // MARK: - Table View
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataHistory.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataHistory[section]["Date"] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRow = dataHistory[section]["listAct"] as? [String:String]
        return (numRow?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellHR = tableView.dequeueReusableCell(withIdentifier: "HR")!
        let list = dataHistory[indexPath.section]["listAct"] as! [String:String]
        let value = Array(list)[indexPath.row].value //---> get value from dict via index
        let key = Array(list)[indexPath.row].key //---> get key from dict via index
        
        cellHR.textLabel?.text = "\(key) : \(value)"
        
        return cellHR
    }
    
}
