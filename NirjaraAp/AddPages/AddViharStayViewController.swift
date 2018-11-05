//
//  AddViharStayViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import JHTAlertController
import IQKeyboardManagerSwift
class AddViharStayViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    
    
    
    @IBOutlet weak var lblAddPlace: UILabel!
    @IBOutlet weak var txtAddPlace: UITextField!
    
    
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var txtContactNo: UITextField!
    
    
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var txtPlace: UITextField!
    
    @IBOutlet weak var lblFamily: UILabel!
    @IBOutlet weak var txtFamily: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    var containerController: ContainerViewController?
    
    @IBOutlet weak var mainMapView: UIView!
    
    
    var mapView = GMSMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Add Vihar Stay"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:12))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:12,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        self.updateBackButton()
        mainMapView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        mainMapView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
        mainMapView.layer.shadowOpacity = 0.8;
        mainMapView.layer.shadowRadius = 2.5;
        mainMapView.layer.masksToBounds = false
        
        self.addShadowToBarMap()
        
        lblAddPlace.frame = CGRect(x:10,y:285,width:self.view.frame.width-20,height:25)
        txtAddPlace.frame = CGRect(x:10,y:lblAddPlace.frame.origin.y+lblAddPlace.frame.height,width:self.view.frame.width-20,height:45)
        lblContactNo.frame = CGRect(x:10,y:txtAddPlace.frame.origin.y+txtAddPlace.frame.height+10,width:self.view.frame.width-20,height:25)
        txtContactNo.frame = CGRect(x:10,y:lblContactNo.frame.origin.y+lblContactNo.frame.height,width:self.view.frame.width-20,height:45)
        
        lblPlace.frame = CGRect(x:10,y:txtContactNo.frame.origin.y+txtContactNo.frame.height+10,width:self.view.frame.width-20,height:25)
        txtPlace.frame = CGRect(x:10,y:lblPlace.frame.origin.y+lblPlace.frame.height,width:self.view.frame.width-20,height:45)
        
        lblFamily.frame = CGRect(x:10,y:txtPlace.frame.origin.y+txtPlace.frame.height+10,width:self.view.frame.width-20,height:25)
        txtFamily.frame = CGRect(x:10,y:lblFamily.frame.origin.y+lblFamily.frame.height,width:self.view.frame.width-20,height:45)
       
        btnSubmit.frame = CGRect(x:10,y:txtFamily.frame.origin.y+txtFamily.frame.height+18,width:self.view.frame.width-20,height:50)
        
    
        lblAddPlace.text = "Add".localized1+" "+"Place".localized1
        border(textname: txtAddPlace,placholderText:"Add".localized1+" "+"Place".localized1)
        
        lblContactNo.text = "ContactNumber".localized1
        border(textname: txtContactNo,placholderText:"ContactNumber".localized1)
        
        lblPlace.text = "PlaceName".localized1
        border(textname: txtPlace,placholderText:"PlaceName".localized1)
        
        lblFamily.text = "JainFamilyAround".localized1
        border(textname: txtFamily,placholderText:"JainFamilyAround".localized1)
        
        
        btnSubmit.setTitle("Add".localized1+" "+"Place".localized1, for: .normal)
        
        loadLocation()
        containerController = revealViewController().frontViewController as? ContainerViewController
        btnSubmit.addTarget(self, action: #selector(AddViharStayViewController.AddVihar(_:)), for: UIControlEvents.touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    
    @objc func AddVihar(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtAddPlace.text == ""){
            self.view.makeToast("Add Place", duration: 2.0, position: .top)
        }else if(!txtContactNo.text!.isPhone()){
            self.view.makeToast("Wrong Mobile No", duration: 2.0, position: .top)
        }else if(!(txtFamily.text?.isNumber)!){
        
        self.view.makeToast("Jain Family Add count", duration: 2.0, position: .top)
    }
        else{
        
        let parameters = "name=\(txtAddPlace.text!)&member_id=\(UserDefaults.standard.getUserID())&contact=\(txtContactNo.text!)&jain_family_around=\(txtFamily.text!)&vihar_address=\(GlobalVariables.currentAddres)&vihar_latitude=\(GlobalVariables.currentLat)&vihar_longitude=\(GlobalVariables.currentLong)&city=\(GlobalVariables.TempleState)"
        let url = URL(string:ServerUrl.post_add_vihar_url)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        self.showActivityIndicator()
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                print("Add Vihar Reponse",json)
                let Success = json?.object(forKey: "message") as? String;
                if (Success == "Success")
                {
  
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        
                            // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                            
                            let alertController = JHTAlertController(title: "Success", message:"Vihar Say Added Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                 self.navigationController?.popViewController(animated: true)
                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[7])
                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.alert(message: "Nirjara Ap", title: "Something Went Wrong")
                        //self.alert(message: "Invalid Credential", title:"Nirjara Ap")
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    }else{
    showAlert(title: "OOp's", message: "No Internet Connection")
    }
}
    
    
    func border(textname : UITextField,placholderText : String){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 4, y : textname.frame.height-1,width:self.view.frame.width-28, height : 1.0)
        let color = UIColor.rgb(hexcolor:"#DCDCDC").cgColor
        bottomLine.backgroundColor = color
        textname.setTextLeftPadding(left: 10)

        textname.attributedPlaceholder = NSAttributedString(string:placholderText, attributes:[NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "DCDCDC"),NSAttributedStringKey.font :UIFont(name: "Helvetica", size: 18)!])
        textname.borderStyle = UITextBorderStyle.none
        textname.layer.addSublayer(bottomLine)
    }
   
    func loadLocation(){
       // GMSServices.provideAPIKey(GlobalVariables.GoogleMapsKey)
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        else{
            print("Location service disabled");
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        lng = locValue.longitude
        GlobalVariables.currentLat = String(lat)
        GlobalVariables.currentLong = String(lng)
        locationManager.stopUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect(x:0,y:0,width:self.view.frame.width,height:self.mainMapView.frame.height), camera: camera)
        
        self.mainMapView.addSubview(mapView)
        
        do {
            // Set the map style by passing a valid JSON string.
            mapView.mapStyle = try GMSMapStyle(jsonString: GlobalVariables.kMapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
        
        let location = CLLocation(latitude: lat, longitude: lng) //changed!!!
        //print(location)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            //print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if let p0 = placemarks?.first
            {
                
                
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
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    GlobalVariables.currentAddres = addressString
                    self.txtPlace.text = GlobalVariables.currentAddres
                }
                
                
                
                
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                marker.title = String(describing: GlobalVariables.currentAddres)
                //marker.snippet = String(describing: p.country)
                marker.map = self.mapView
                //self.adsresslabel.text = "\(p.administrativeArea)\(p.postalCode)\(p.country)"
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error"+error.localizedDescription)
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
