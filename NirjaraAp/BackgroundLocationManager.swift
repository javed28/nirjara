//
//  BackgroundLocationManager.swift
//  NirjaraAp
//
//  Created by gadgetzone on 6/29/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation
import CoreLocation

class BackgroundLocationManager :NSObject, CLLocationManagerDelegate {
    
    static let instance = BackgroundLocationManager()
    static let BACKGROUND_TIMER = 300.0 // restart location manager every 150 seconds
    static let UPDATE_SERVER_INTERVAL = 1 * 1 // 1 hour - once every 1 hour send location to server
    
    let locationManager = CLLocationManager()
    var timer:Timer?
    var currentBgTaskId : UIBackgroundTaskIdentifier?
    var lastLocationDate : NSDate = NSDate()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    private override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.activityType = .other;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        if #available(iOS 9, *){
            locationManager.allowsBackgroundLocationUpdates = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func applicationEnterBackground(){
        //FileLogger.log("applicationEnterBackground")
        start()
    }
    func start(){
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            if #available(iOS 9, *){
                locationManager.requestLocation()
            } else {
                locationManager.startUpdatingLocation()
            }
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    @objc func restart (){
        timer?.invalidate()
        timer = nil
        start()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            
            break
        //log("Restricted Access to location")
        case CLAuthorizationStatus.denied:
            
            break
        //log("User denied access to location")
        case CLAuthorizationStatus.notDetermined:
            break
        //log("Status not determined")
        default:
            //log("startUpdatintLocation")
            if #available(iOS 9, *){
                locationManager.requestLocation()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if(timer==nil){
            // The locations array is sorted in chronologically ascending order, so the
            // last element is the most recent
            guard let location = locations.last else {
                return
                
            }
            beginNewBackgroundTask()
            locationManager.stopUpdatingLocation()
            let now = NSDate()
            if(isItTime(now: now)){
                if locationManager.location != nil {
                let locValue:CLLocationCoordinate2D = manager.location!.coordinate
                
                self.latitude = locValue.latitude
                self.longitude = locValue.longitude
               
                print("New Coordinates:")
                print(self.latitude)
                print(self.longitude)
                    
                    let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
                    CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                        //print(location)
                        
                        if error != nil {
                            print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                            return
                        }
                        print("how many Time---on background---")
                        
                        if let p0 = placemarks?.first
                        {
                            let p = CLPlacemark(placemark:p0)
                            
                            let pm = placemarks! as [CLPlacemark]
                            if pm.count > 0 {
                                let pm = placemarks![0]
                                
                                var addressString : String = ""
                                if pm.subLocality != nil {
                                    addressString = addressString + pm.subLocality! + ", "
                                }
                                if pm.thoroughfare != nil {
                                    addressString = addressString + pm.thoroughfare! + ", "
                                }
                                if pm.locality != nil {
                                    addressString = addressString + pm.locality! + ", "
                                    GlobalVariables.TempleState = pm.locality!
                                    UserDefaults.standard.setLastAddress(value: pm.locality!)
                                }
                                if pm.country != nil {
                                    addressString = addressString + pm.country! + ", "
                                }
                                if pm.postalCode != nil {
                                    addressString = addressString + pm.postalCode! + " "
                                }
                                GlobalVariables.currentAddres = addressString
                                print("current Address--"+GlobalVariables.currentAddres)
                            }
                            
                        }
                        else {
                            print("Problem with the data received from geocoder")
                        }
                    })
                    
                    
                    self.updatePostion(lat: self.latitude.description, lon: self.longitude.description)
                }
                //TODO: Every n minutes do whatever you want with the new location. Like for example sendLocationToServer(location, now:now)
            }
        }
    }
    func updatePostion(lat : String,lon : String){
        // let parameters = "member_id=\(UserDefaults.standard.getUserID())&latitude=\(26.695694)&longitude=\(76.911005)"
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&latitude=\(lat)&longitude=\(lon)"
        let url = URL(string:ServerUrl.update_position)!
        print("updateing   location-----\(url)?\(parameters)")
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = parameters.data(using: String.Encoding.utf8)
        }
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        beginNewBackgroundTask()
        locationManager.stopUpdatingLocation()
    }
    
    
    func isItTime(now:NSDate) -> Bool {
        let timePast = now.timeIntervalSince(lastLocationDate as Date)
        let intervalExceeded = Int(timePast) > BackgroundLocationManager.UPDATE_SERVER_INTERVAL
        return intervalExceeded;
    }
    
    func sendLocationToServer(location:CLLocation, now:NSDate){
        //TODO
    }
    
    func beginNewBackgroundTask(){
        var previousTaskId = currentBgTaskId;
        currentBgTaskId = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            //FileLogger.log("task expired: ")
        })
        if let taskId = previousTaskId{
            UIApplication.shared.endBackgroundTask(taskId)
            previousTaskId = UIBackgroundTaskInvalid
        }
        
        timer = Timer.scheduledTimer(timeInterval: BackgroundLocationManager.BACKGROUND_TIMER, target: self, selector: #selector(self.restart),userInfo: nil, repeats: false)
    }
}
