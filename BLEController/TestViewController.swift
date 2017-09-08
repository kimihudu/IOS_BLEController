//
//  TestViewController.swift
//  BLEController
//
//  Created by kimiboo on 2017-09-03.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import UIKit
import UICircularProgressRing
import CoreLocation

class TestViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var ring1: UICircularProgressRingView!
    @IBOutlet weak var ring2: UICircularProgressRingView!
    @IBOutlet weak var ring3: UICircularProgressRingView!
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmp: LocationServices = LocationServices()
//LocationServices.init().getAdress(completion: <#T##(JSONDictionary?, Error?) -> ()#>)
        tmp.getAdress { address, error in
            
                if let a = address, let city = a["City"] as? String {
                    //
                    print(city)
                }
            
            }
    

        // Do any additional setup after loading the view.
//        isAuthorizedtoGetUserLocation()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.distanceFilter = kCLDistanceFilterNone
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//       self.view.makeToast("test", duration: 3.0, position: .bottom)
        
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

//    
//    //if we have no permission to access user location, then ask user for permission.
//    func isAuthorizedtoGetUserLocation() {
//        
//        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//    
//    
//    
//    
//    
//    //this method will be called each time when a user change his location access preference.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            print("User allowed us to access location")
//            
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
//            
//            let k: CLLocationDistance = (manager.location?.altitude)!
//            let tmp: CLLocation = manager.location!
//            
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
//            print(tmp)
//
//            //do whatever init activities here.
//            getPlacemark(forLocation: tmp) {
//                (tmp, error) in
//                if let err = error {
//                    print(err)
//                } else if let placemark = tmp {
//                    // Do something with the placemark
////                    print(placemark.locality ? placemark.locality : "")
////                    print(placemark.postalCode ? placemark.postalCode : "")
////                    print(placemark.administrativeArea ? placemark.administrativeArea : "")
////                    print(placemark.country ? placemark.country : "")
//
//                    
//                    print(placemark.locality!)
////                    print(placemark.subLocality!)
//                    print(placemark.postalCode!)
//                    print(placemark.administrativeArea!)
////                    print(placemark.subAdministrativeArea!)
//                    print(placemark.country!)
//                    print(placemark.thoroughfare!)
//                    
//                }
//            }
//        
//        }
//    }
//    
//    func getPlacemark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
//        let geocoder = CLGeocoder()
//        
//        geocoder.reverseGeocodeLocation(location, completionHandler: {
//            placemarks, error in
//            
//            if let err = error {
//                completionHandler(nil, err.localizedDescription)
//            } else if let placemarkArray = placemarks {
//                if let placemark = placemarkArray.first {
//                    completionHandler(placemark, nil)
//                } else {
//                    completionHandler(nil, "Placemark was nil")
//                }
//            } else {
//                completionHandler(nil, "Unknown error")
//            }
//        })
//        
//    }
//    //this method is called by the framework on         locationManager.requestLocation();
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("Did location updates is called")
//        //store the user location here to firebase or somewhere
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Did location updates is called but failed getting location \(error)")
//    }
}
