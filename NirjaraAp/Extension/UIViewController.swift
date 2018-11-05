//
//  UIViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/14/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation
import JHTAlertController
import SystemConfiguration

extension UIViewController{
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
     func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func showAlert(title: String,message: String){
               // If you add an image to the title block, you may need to set restrictTitleViewHeight to true, depending on the image size
        // let alertController = JHTAlertController(title: "Wow!", message: "You can even set an icon for the alert.", preferredStyle: .alert, iconImage: UIImage(named: "alertIcon"))
        let alertController = JHTAlertController(title: title, message:message, preferredStyle: .alert)
      
        alertController.titleTextColor = .black
        alertController.titleFont = .systemFont(ofSize: 18)
        alertController.titleViewBackgroundColor = .white
        alertController.messageTextColor = .black
        alertController.alertBackgroundColor = .white
        alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
        
       
        let okAction = JHTAlertAction(title: "Ok", style: .cancel,  handler: nil)
        alertController.setButtonTextColorFor(.cancel, to: .white)
        //alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        
        activityIndicator.tag = 100 // 100 for example
        
        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }
        
        view.addSubview(activityIndicator)
    }
    
    func addShadowToBar() {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    func addShadowToBarMap() {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    func stringToDate(takeDate : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+5:30") //Current time zone
        let date = dateFormatter.date(from: takeDate)
        return date!
    }
    
   @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        
        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()
        
        //UIApplication.shared.endIgnoringInteractionEvents()
    }
    func updateBackButton(){
        if self.navigationController != nil {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            navigationController?.navigationBar.tintColor = UIColor.rgb(hexcolor: GlobalVariables.titleColor)
        }
    }
}
