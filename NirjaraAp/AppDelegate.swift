//
//  AppDelegate.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications
import CoreLocation
import KKStatusBarService
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var pos : Int =  0
    var LatitudeGPS = NSString()
    var LongitudeGPS = NSString()
    var speedGPS = NSString()
    var Course = NSString()
    var Altitude = NSString()
    var bgtimer = Timer()
    
    //var settings : UNNotificationSetting?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(GlobalVariables.GoogleMapsKey)
        GMSPlacesClient.provideAPIKey(GlobalVariables.GoogleMapsKey)
        // Instamojo.setup()
       // FirebaseApp.configure()
        /*setting = UNNotificationSetting(forTypes : [.alert,.badge,.sound],categories = nil)
        UIApplication.shared.registerUserNotificationSettings(setting)
        UIApplication.shared.registerForRemoteNotifications()
        settings = UNNotificationSetting.enabled
        UIApplication.shared.registerUserNotificationSettings(settings!)
        UIApplication.shared.registerForRemoteNotifications()*/
       UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
            if (error == nil){
                print("Successfull")
            }else{
                print("Error")
            }
        }
        application.registerForRemoteNotifications()
        
        
        if(UserDefaults.standard.getLoggedIn()){
           BackgroundLocationManager.instance.start()
        }
        else{
        }
        if KKStatusBarService.isServiceRunning == false {
            KKStatusBarService.startMonitoring()
        }
        /*IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true*/
         /*NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)*/
        
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        /*if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }*/
        
        print("Device Token\(deviceToken)")
        //let newSet = CharacterSet(charactersIn: "<>")
        //let deviceTokenString : String = (deviceToken.description as NSString).trimmingCharacters(in: newSet).replacingOccurrences(of: " ", with: "") as String
       // print("deviceTokenString----\(deviceTokenString)")
        let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
        //let pushBadge = settings
        
        if(UserDefaults.standard.getLoggedIn()){
             registerDevice(token: token)
        }
        else{
        }
    }
    
    func registerDevice(token : String){
        
       let userId = UserDefaults.standard.getUserID()
        
        let myDevice = UIDevice()
        let deviceName = myDevice.name
        let deviceModel = myDevice.model
        let systemVersion = myDevice.systemVersion
        let deviceId = myDevice.identifierForVendor?.uuidString
        var appName : String?
        if let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName"){
            appName = appDisplayName as? String
        }else{
            appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        }
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        
        
        let parameters = "task=register&appname=\(appName!)&appversion=\(appVersion!)&deviceuid=\(deviceId!)&devicetoken=\(token)&devicename=\(deviceName)&devicemodel=\(deviceModel)&deviceversion=\(systemVersion)&pushbadge=enabled&pushalert=enabled&pushsound=enabled&userId=\(userId)"
        print("parameters---\(parameters)")
        let url = URL(string:ServerUrl.register_fcm)!
        print("urll--\(url)")
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
                let responstring = NSString(data : data,encoding : String.Encoding.utf8.rawValue)
                print("reponseee----\(responstring)")
                //let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                //print("Json----",json)
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    /*func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Message Recived-11111-\(userInfo)")
        completionHandler(.newData)
    }*/
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Message Recived--\(userInfo)")
        
        if let aps = userInfo as? NSDictionary{
            let alertMessage = aps["alert"] as? String
           // var fullNameArr = alertMessage?.components(separatedBy: "::")
            //var firstName: String = fullNameArr![0]
            //var lastName: String? = fullNameArr![1]=="" ? fullNameArr![1] : nil
            //let detailMessage = aps["loc-key"] as? String
            //let detailMessage1 = aps["loc-args"] as? String
            let myAlert = UIAlertController(title : "Message",message : alertMessage,preferredStyle : UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title :"Ok",style:UIAlertActionStyle.default,handler:nil)
            myAlert.addAction(okAction)
            self.window?.rootViewController?.present(myAlert, animated: true, completion: nil)
        }
    }


   /* func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }*/

    

    /*func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }*/

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //FBHandler()
        KKStatusBarService.startMonitoring()
        
    }

    /*func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }*/
    @objc func refreshToken(notification : NSNotification){
        let refereshToken = InstanceID.instanceID().token()!
        print("***\(refereshToken)")
        FBHandler()
    }
    
    func FBHandler(){
        Messaging.messaging().shouldEstablishDirectChannel = true
        
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = false
        KKStatusBarService.stopMonitoring()
       
    }
    
    
    
    
    

    // MARK: - Split view

  

}

