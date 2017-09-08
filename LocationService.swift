//
//  Map.swift
//  BLEController
//
//  Created by kimiboo on 2017-09-06.
//  Copyright © 2017 kimiboo. All rights reserved.
//

import Foundation
import MapKit

typealias JSONDictionary = [String:Any]

class LocationServices {
    
//    let shared = LocationServices()
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var returnLocation:String = ""
    
    let authStatus = CLLocationManager.authorizationStatus()
    let inUse = CLAuthorizationStatus.authorizedWhenInUse
    let always = CLAuthorizationStatus.authorizedAlways
    
    func getLocation() {
        var _location: String = ""
        self.locManager.requestWhenInUseAuthorization()
        if self.authStatus == inUse || self.authStatus == always{
            
            self.currentLocation = locManager.location
            let geoCoder = CLGeocoder()
            let locValue: CLLocationCoordinate2D = (locManager.location?.coordinate)!
            let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                
                // Print each key-value pair in a new row
                //                addressDict.forEach { print($0) }
                
                //                 Print fully formatted address
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
//                    print(formattedAddress.joined(separator: ", "))
                    _location = formattedAddress.joined(separator: ", ")
                    self.returnLocation = _location
                }
                //
                //                // Access each element manually
                //                if let locationName = addressDict["Name"] as? String {
                //                    print(locationName)
                //                }
                //                if let street = addressDict["Thoroughfare"] as? String {
                //                    print(street)
                //                }
                //                if let city = addressDict["City"] as? String {
                //                    print(city)
                //                }
                //                if let zip = addressDict["ZIP"] as? String {
                //                    print(zip)
                //                }
                //                if let country = addressDict["Country"] as? String {
                //                    print(country)
                //                }
            })

            
        
        
        }
        
    }
    
    func getAdress(completion: @escaping (_ address: JSONDictionary?, _ error: Error?) -> ()) {
        
        self.locManager.requestWhenInUseAuthorization()
        
        if self.authStatus == inUse || self.authStatus == always {
            
            self.currentLocation = locManager.location
            let locValue: CLLocationCoordinate2D = (locManager.location?.coordinate)!
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                
                // Print each key-value pair in a new row
//                addressDict.forEach { print($0) }
                
//                 Print fully formatted address
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    print(formattedAddress.joined(separator: ", "))
                    self.returnLocation = formattedAddress.joined(separator: ", ")
                }
//
                // Access each element manually
                if let locationName = addressDict["Name"] as? String {
                    print(locationName)
                }
                if let street = addressDict["Thoroughfare"] as? String {
                    print(street)
                }
                if let city = addressDict["City"] as? String {
                    print(city)
                }
                if let zip = addressDict["ZIP"] as? String {
                    print(zip)
                }
                if let country = addressDict["Country"] as? String {
                    print(country)
                }
            })
            
        }
    }
    
}

///LocationServices.shared.getAdress { address, error in
///
///    if let a = address, let city = a["City"] as? String {
///        //
///    }
///
///}
