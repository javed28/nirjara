//
//  ViharStayCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import JHTAlertController

class ViharStayCntr: UIViewController, CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,GMSMapViewDelegate,UIScrollViewDelegate{

    @IBOutlet weak var headerBackView: UIView!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnPlaceAdded: UIButton!
    @IBOutlet weak var btnAddVihar: UIButton!
    @IBOutlet weak var labelback: UIView!
    @IBOutlet weak var tableViewFromTop: NSLayoutConstraint!
    
    @IBOutlet weak var addViewFromTop: NSLayoutConstraint!
    var viharStayData : NSMutableArray = NSMutableArray()
    var viharStayMarkerData : NSMutableArray = NSMutableArray()
    var scrolledAlready : Bool = false
    
    @IBOutlet weak var lblNoRecordFound: UILabel!
    @IBOutlet weak var mainMapView: GMSMapView!
    
    @IBOutlet weak var btnFullScreen: UIButton!
    
    //     var contactName = ["Test","testing Vihar","Test1111","Test","Test","Test"]
//     var contactNumner = ["1234567890","563998989","23481948","9898976535","1234567890","09673636363"]
//     var Place = ["Mumbai-Agra","Gorgaon-Agra","Malad-Agra","Mumbai-Agra","Borivali-Agra","Chrughtgate-Agra"]
//     var CountOfFamilies = ["JainFamilies - 10","JainFamilies - 15","JainFamilies - 4","JainFamilies - 18","JainFamilies - 20","JainFamilies - 12"]
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    @IBOutlet weak var menuButton: UIBarButtonItem!
let marker = GMSMarker()
    @IBOutlet weak var viharTempleView: UICollectionView!
    
    var noted : String = "न उपयोग मे आने वाले स्थानो को साधु संतो के विहार के समय अस्थाई विश्राम के लिए ADD करे और सय्यातर बनने का सौभाग्य प्राप्त करे"
    var note_color : String = "#001669"
    var note_font_color : String = "#fffd00"
    //var mapView = GMSMapView()
    var loadedOnce : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Vihar Stay"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:8))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:8,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        viharTempleView.delegate = self
        viharTempleView.dataSource = self
        
        mainMapView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        mainMapView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
        mainMapView.layer.shadowOpacity = 0.8;
        mainMapView.layer.shadowRadius = 2.5;
        mainMapView.layer.masksToBounds = false
        btnFullScreen.addTarget(self, action: #selector(ViharStayCntr.gotoFullPageMap(_:)), for: UIControlEvents.touchUpInside)
        
         self.addShadowToBarMap()
         sideMenu()
       
        //lblHeader.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
        
        
                    //let lblheight : CGFloat = CGFloat.greatestFiniteMagnitude
        
        
                    //let greet4Height = lblHeader.optimalHeight

                    labelback.frame = CGRect(x:0,y:0,width:view.frame.width-20,height:68)
                    lblHeader.frame = CGRect(x:5,y:0,width:self.labelback.frame.width-10,height:68)
                    lblHeader.lineBreakMode = .byWordWrapping
                    lblHeader.textAlignment = NSTextAlignment.center
                    lblHeader.numberOfLines = 0
                    lblHeader.text = noted
                    labelback.backgroundColor = UIColor.rgb(hexcolor: note_color)
                    lblHeader.textColor = UIColor.rgb(hexcolor: note_font_color)
                    labelback.addSubview(lblHeader)
        
        
                btnAddVihar.frame = CGRect(x:0,y:75,width:self.labelback.frame.width/2-5,height:50)
                btnPlaceAdded.frame = CGRect(x:self.labelback.frame.width/2+5,y:75,width:self.labelback.frame.width/2-5,height:50)
        
        
               btnAddVihar.addTarget(self, action: #selector(ViharStayCntr.gotoAddVihar1(_:)), for: UIControlEvents.touchUpInside)
        
        
                let buttonString = String.fontAwesomeString(name: "fa-plus")+"  "+"AddVihar1".localized1
                let buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: CGFloat(GlobalVariables.ButtonofTable))!])
                buttonStringAttributed.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: CGFloat(GlobalVariables.ButtonofTable)), range: NSRange(location: 0,length: 1))
                buttonStringAttributed.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location: 0,length: 1))
                btnAddVihar.titleLabel?.textAlignment = .center
                btnAddVihar.titleLabel?.textColor = UIColor.white
                btnAddVihar.setAttributedTitle(buttonStringAttributed, for: .normal)
        
        
        
                let buttonString1 = String.fontAwesomeString(name: "fa-filter")+"  "+"PlaceAdded".localized1
                let buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: CGFloat(GlobalVariables.ButtonofTable))!])
        
                buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: CGFloat(GlobalVariables.ButtonofTable)), range: NSRange(location: 0,length: 1))
        
                buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
        
                btnPlaceAdded.titleLabel?.textAlignment = .center
                btnPlaceAdded.titleLabel?.textColor = UIColor.white
                btnPlaceAdded.setAttributedTitle(buttonStringAttributed1, for: .normal)
        
        
        
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gotoAddVihar(_:)))
                   btnPlaceAdded.addGestureRecognizer(tapGesture)

        headerBackView.addSubview(btnAddVihar)
        headerBackView.addSubview(lblHeader)
        headerBackView.addSubview(btnPlaceAdded)
        
        
        
        // Do any additional setup after loading the view.
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
 if isConnectedToNetwork() {
         mainMapView.delegate = self
        
         self.loadedOnce = false
         loadLocation()
 }else{
    
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    func loadLocation(){
        let status  = CLLocationManager.authorizationStatus()
        
        // 2
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // 3
        if status == .denied || status == .restricted {
            
            let alertController = JHTAlertController(title: "Location Services Disabled", message:"In order to be notified, please open this app's settings and set location access to 'Always'.", preferredStyle: .alert)
            
            alertController.titleTextColor = .black
            alertController.titleFont = .systemFont(ofSize: 18)
            alertController.titleViewBackgroundColor = .white
            alertController.messageTextColor = .black
            alertController.alertBackgroundColor = .white
            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
            let cancelAction = JHTAlertAction(title: "Cancel", style: .cancel,  handler: nil)
            alertController.addAction(cancelAction)
            let okAction = JHTAlertAction(title: "Settings", style: .default) { _ in
                
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viharStayData.count
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width
        
        return CGSize(width: collectionViewSize/2-5, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viharTempleView.dequeueReusableCell(withReuseIdentifier: "viharIdentifier", for: indexPath) as! ShowViharStayViewCell
       
        cell.mainView.frame=CGRect(x:0,y:0,width:self.view.frame.width/2,height:150)
        
        
        let viharData = viharStayData[indexPath.row] as! viharStayModel
        
        cell.lblViharstayName.text = viharData.name
        cell.lblViharstayName?.frame = CGRect(x:15,y:10,width:cell.mainView.frame.width-30,height:28)
       
        
        cell.lblContactNumber.setFAText(prefixText: "", icon: .FAMobile, postfixText: " "+viharData.contact, size: 18)
        cell.lblContactNumber?.frame = CGRect(x:15,y:40,width:cell.mainView.frame.width,height:28)
        
        cell.locationImg.frame = CGRect(x:15,y:(cell.lblContactNumber.frame.origin.y)+(cell.lblContactNumber.frame.height)+2,width:12,height:15)
        cell.lblRegion?.text = viharData.vihar_address
       // let greet4Height = cell.lblRegion?.optimalHeight
       // cell.lblRegion?.frame = CGRect(x:28,y:(cell.lblContactNumber.frame.origin.y)+(cell.lblContactNumber.frame.height),width:cell.mainView.frame.width-40,height:greet4Height!)
         cell.lblRegion?.frame = CGRect(x:28,y:(cell.lblContactNumber.frame.origin.y)+(cell.lblContactNumber.frame.height),width:cell.mainView.frame.width-64,height:25)
        
        
        cell.lblCount?.frame = CGRect(x:15,y:(cell.lblRegion.frame.origin.y)+(cell.lblRegion.frame.height)+2,width:cell.mainView.frame.width,height:28)
        
        cell.lblCount.setFAText(prefixText: "", icon: .FAUsers, postfixText: "Jain Families : "+viharData.jain_family_around, size: 12)
        cell.lblDistance?.frame = CGRect(x:15,y:(cell.lblCount.frame.origin.y)+(cell.lblCount.frame.height)+1,width:cell.mainView.frame.width,height:28)
        cell.lblDistance.setFAText(prefixText: "", icon: .FALocationArrow, postfixText:viharData.distance, size: 12)
       // cell.lblCount.text = "Jain Families : "+viharData.jain_family_around
        
        cell.mainView.addSubview(cell.lblViharstayName)
        cell.mainView.addSubview(cell.lblContactNumber)
        cell.mainView.addSubview(cell.lblRegion)
        cell.mainView.addSubview(cell.lblCount)
        cell.mainView.addSubview(cell.lblDistance)
        
        cell.mainView.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let size = CGSize(width: self.view.frame.width, height: 80)
//        return size
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//      //  var reusableView : UICollectionReusableView? = nil
//        // Create header
//       // if (kind == UICollectionElementKindSectionHeader) {
//            // Create Header
//            let headerView : PackCollectionSectionView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! PackCollectionSectionView
//
//            headerView.lblHeader.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
//
//
//            //let lblheight : CGFloat = CGFloat.greatestFiniteMagnitude
//
//
//            let greet4Height = headerView.lblHeader.optimalHeight
//
//
//            headerView.labelback.frame = CGRect(x:-8,y:0,width:self.view.frame.width,height:greet4Height+25)
//            headerView.lblHeader.frame = CGRect(x:10,y:10,width:headerView.labelback.frame.width-20,height:greet4Height+10)
//            headerView.lblHeader.lineBreakMode = .byWordWrapping
//            headerView.lblHeader.textAlignment = NSTextAlignment.center
//            headerView.lblHeader.numberOfLines = 0
//            headerView.lblHeader.textColor = UIColor.rgb(hexcolor: "#fafb00")
//            headerView.lblHeader.text = noted
//            headerView.labelback.addSubview(headerView.lblHeader)
    
        
//        headerView.btnAddVihar.frame = CGRect(x:0,y:greet4Height+30,width:self.view.frame.width/2-16,height:50)
//        headerView.btnPlaceAdded.frame = CGRect(x:self.view.frame.width/2-5,y:greet4Height+30,width:self.view.frame.width/2,height:50)
//
//
//       headerView.btnAddVihar.addTarget(self, action: #selector(ViharStayCntr.gotoAddVihar1(_:)), for: UIControlEvents.touchUpInside)
//
//
//        var buttonString = String.fontAwesomeString(name: "fa-plus") + " Add Vihar"
//        var buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: CGFloat(GlobalVariables.ButtonofTable))!])
//        buttonStringAttributed.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: CGFloat(GlobalVariables.ButtonofTable)), range: NSRange(location: 0,length: 1))
//        buttonStringAttributed.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location: 0,length: 1))
//        headerView.btnAddVihar.titleLabel?.textAlignment = .center
//        headerView.btnAddVihar.titleLabel?.textColor = UIColor.white
//        headerView.btnAddVihar.setAttributedTitle(buttonStringAttributed, for: .normal)
//
//
//
//        var buttonString1 = String.fontAwesomeString(name: "fa-filter") + " Place Added"
//        var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: CGFloat(GlobalVariables.ButtonofTable))!])
//
//        buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: CGFloat(GlobalVariables.ButtonofTable)), range: NSRange(location: 0,length: 1))
//
//        buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
//
//        headerView.btnPlaceAdded.titleLabel?.textAlignment = .center
//        headerView.btnPlaceAdded.titleLabel?.textColor = UIColor.white
//        headerView.btnPlaceAdded.setAttributedTitle(buttonStringAttributed1, for: .normal)
//
//
//
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gotoAddVihar(_:)))
//            headerView.btnPlaceAdded.addGestureRecognizer(tapGesture)
        
            
           // reusableView = headerView
       // }
//        return headerView
//
//    }
    
    @objc func gotoAddVihar(_ sender : UITapGestureRecognizer){
        
        self.performSegue(withIdentifier: "myViharIdentifier", sender: self)
    }
    @objc func gotoAddVihar1(_  sender : UIButton){
        
        self.performSegue(withIdentifier: "goToAddVihar", sender: self)
        
    }
    @objc func gotoFullPageMap(_ sender : UITapGestureRecognizer){
        
        let fullPageMap = storyboard?.instantiateViewController(withIdentifier: "FullPageMapIdentifier") as! ShowFullMapCntr
        fullPageMap.which = "ViharStay"
        fullPageMap.dataOnMap = viharStayMarkerData
        navigationController?.pushViewController(fullPageMap, animated: true)
    }
    

   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locationManager.location != nil {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        lat = locValue.latitude
        lng = locValue.longitude
        GlobalVariables.currentLat = String(lat)
        GlobalVariables.currentLong = String(lng)
        locationManager.stopUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 13.0)
        self.mainMapView.camera = camera
        
//        mapView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
//        mapView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
//        mapView.layer.shadowOpacity = 0.8;
//        mapView.layer.shadowRadius = 2.5;
//        mapView.layer.masksToBounds = false
        //mapView.layer.borderColor = UIColor.black.cgColor
        //mapView.layer.borderWidth = 0.8
        
        do {
            // Set the map style by passing a valid JSON string.
            //mapView.mapStyle = try GMSMapStyle(jsonString: GlobalVariables.kMapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        //self.mainScrollview.addSubview(mapView)
        
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
                let p = CLPlacemark(placemark:p0)
                
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
//                marker.title = String(describing: p.locality)
//                marker.snippet = String(describing: p.country)
//                marker.map = self.mapView
                
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
                    UserDefaults.standard.setLastAddress(value: pm.locality!)
                }
                
                
                self.marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                self.marker.title = String(describing: GlobalVariables.currentAddres)
                //marker.snippet = String(describing: p.country)
                self.marker.map = self.mainMapView
                //self.adsresslabel.text = "\(p.administrativeArea)\(p.postalCode)\(p.country)"
                //self.updatePostion(lat: self.lat.description, lon: self.lng.description)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        if(loadedOnce == false){
           self.viharTempleView.alpha = 1
           self.lblNoRecordFound.alpha = 0
         
            geetViharStayDataNote()
            loadedOnce = true
        }else{
            
        }
        }else{
            print("location manger nilll")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error"+error.localizedDescription)
    }
    func updatePostion(lat : String,lon : String){
        // let parameters = "member_id=\(UserDefaults.standard.getUserID())&latitude=\(26.695694)&longitude=\(76.911005)"
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&latitude=\(lat)&longitude=\(lon)"
        let url = URL(string:ServerUrl.update_position)!
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
    
    func geetViharStayDataNote(){
        //let parameters = "city_english=Mumbai&lang="+GlobalVariables.selectedLanguage
        //let url = URL(string:ServerUrl.get_vihar_stay_location_wise)!
        
         let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
         let url = URL(string:ServerUrl.get_vihar_all)!
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
                                let Status = json?.object(forKey: "data") as? NSDictionary
                                let message : String =  Status!.value(forKey: "message") as! String
                                if (message == "success")
                                {
                                    //self.noted = Status!.value(forKey: "note") as! String
                                    
                                        let viharData = Status!.value(forKey: "result") as? [NSDictionary]
                                        for j in 0..<viharData!.count{
                                            let jsonObject = viharData?[j]
                                            var viharStayMModel = viharStayModel()

                                            viharStayMModel.vihar_stay_id = jsonObject?.object(forKey: "vihar_stay_id") as? String
                                            viharStayMModel.contact = jsonObject?.object(forKey: "contact") as? String
                                            viharStayMModel.vihar_latitude = jsonObject?.object(forKey: "vihar_latitude") as? String
                                            viharStayMModel.member_id = jsonObject?.object(forKey: "member_id") as? String
                                            viharStayMModel.vihar_address = jsonObject?.object(forKey: "vihar_address") as? String
                                            
                                            if(jsonObject?.object(forKey: "distance") as? String == nil){
                                                viharStayMModel.distance = "Not Specified"
                                            }else{
                                                viharStayMModel.distance = jsonObject?.object(forKey: "distance") as? String
                                            }
                                            
                                            if(jsonObject?.object(forKey: "vihar_latitude") as? String == nil || jsonObject?.object(forKey: "vihar_latitude") as? String == "null" || jsonObject?.object(forKey: "vihar_latitude") as? String == ""){
                                                viharStayMModel.lat = 0.0
                                                viharStayMModel.vihar_latitude = "0.0"
                                            }else{
                                                viharStayMModel.lat = jsonObject?.object(forKey: "vihar_latitude") as? CLLocationDegrees
                                                viharStayMModel.vihar_latitude = jsonObject?.object(forKey: "vihar_latitude") as? String
                                            }
                                            if(jsonObject?.object(forKey: "vihar_longitude") as? String == nil || jsonObject?.object(forKey: "vihar_longitude") as? String == "null" || jsonObject?.object(forKey: "vihar_longitude") as? String == ""){
                                                viharStayMModel.long = 0.0
                                                viharStayMModel.vihar_longitude = "0.0"
                                            }else{
                                                viharStayMModel.long = jsonObject?.object(forKey: "vihar_longitude") as? CLLocationDegrees
                                                viharStayMModel.vihar_longitude = jsonObject?.object(forKey: "vihar_longitude") as? String
                                            }
                                            viharStayMModel.name = jsonObject?.object(forKey: "name") as? String
                                            viharStayMModel.jain_family_around = jsonObject?.object(forKey: "jain_family_around") as? String
                                            self.viharStayMarkerData.add(viharStayMModel)

                                        }
                                        DispatchQueue.main.async {
                                            self.hideActivityIndicator()
                                            self.noted = Status!.value(forKey: "note") as! String
                                            self.lblHeader.text = self.noted
                                            
                                            self.note_color = (Status!.object(forKey: "note_color") as? String)!
                                            self.note_font_color = (Status!.object(forKey: "note_font_color") as? String)!
                                            
                                            self.mainMapView.clear()
                                            for i in 0..<self.viharStayMarkerData.count{
                                                
                                                var latAndLong = self.viharStayMarkerData[i] as! viharStayModel
                                                let markerImage = UIImage(named: "d2-blue")!.withRenderingMode(.alwaysOriginal)
                                                let markerView = UIImageView(image: markerImage)
                                                markerView.tintColor = UIColor.red
                                                let position = CLLocationCoordinate2D(latitude: Double(latAndLong.vihar_latitude)!, longitude: Double(latAndLong.vihar_longitude)!)
                                                let london = GMSMarker(position: position)
                                                london.title = "Title".localized1+" : "+latAndLong.name
                                                london.snippet = "\("ContactNumber".localized1+" : "+latAndLong.contact!) \n \("JainFamily".localized1+" : "+latAndLong.jain_family_around!)\n \("Address".localized1+" : "+latAndLong.vihar_address!)\n \("Distance"+" : "+latAndLong.distance!)"
                                                // london.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                                                london.iconView = markerView
                                                //london.icon = UIImage(named: "d2-blue")
                                                london.map = self.mainMapView
                                                
                                            }
                                            
                                            self.viharStayData.removeAllObjects()
                                            self.viharTempleView.reloadData()
                                            self.getViharStayData()
                                        }
                                }
                
               else if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.noted = Status!.value(forKey: "note") as! String
                        self.lblHeader.text = self.noted
                        self.viharTempleView.alpha = 0
                        self.lblNoRecordFound.alpha = 1
                        self.note_color = (Status!.object(forKey: "note_color") as? String)!
                        self.note_font_color = (Status!.object(forKey: "note_font_color") as? String)!
                        
        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func getViharStayData(){
        //let parameters = "city_english=Mumbai&lang="+GlobalVariables.selectedLanguage
       
        let parameters = "city_english=\(GlobalVariables.TempleState)&lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_vihar_stay_location_wise)!
         print("parameters---",parameters)
       // let parameters = "member_id="+UserDefaults.standard.getUserID()+"&lang="+GlobalVariables.selectedLanguage
       // let url = URL(string:ServerUrl.get_vihar_all)!
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

               
                let message : String =  json!.value(forKey: "message") as! String
                if (message == "success")
                {
                    self.noted = json!.value(forKey: "note") as! String
                    self.note_color = (json?.object(forKey: "note_color") as? String)!
                    self.note_font_color = (json?.object(forKey: "note_font_color") as? String)!
                    
                    DispatchQueue.main.async {
                         self.hideActivityIndicator()
                        self.lblHeader.text = self.noted
                    let viharData = json!.value(forKey: "result") as? [NSDictionary]
                    for j in 0..<viharData!.count{
                        let jsonObject = viharData?[j]
                        var viharStayMModel = viharStayModel()
                        
                        viharStayMModel.vihar_stay_id = jsonObject?.object(forKey: "vihar_stay_id") as? String
                        viharStayMModel.contact = jsonObject?.object(forKey: "contact") as? String
                        
                        viharStayMModel.member_id = jsonObject?.object(forKey: "member_id") as? String
                        
                        viharStayMModel.vihar_address = jsonObject?.object(forKey: "vihar_address") as? String
                        viharStayMModel.name = jsonObject?.object(forKey: "name") as? String
                        viharStayMModel.jain_family_around = jsonObject?.object(forKey: "jain_family_around") as? String
                        viharStayMModel.distance = jsonObject?.object(forKey: "distance") as? String
                        
                        if(jsonObject?.object(forKey: "vihar_latitude") as? String == nil || jsonObject?.object(forKey: "vihar_latitude") as? String == "null" || jsonObject?.object(forKey: "vihar_latitude") as? String == ""){
                            viharStayMModel.lat = 0.0
                             viharStayMModel.vihar_latitude = "0.0"
                        }else{
                             viharStayMModel.lat = jsonObject?.object(forKey: "vihar_latitude") as? CLLocationDegrees
                            viharStayMModel.vihar_latitude = jsonObject?.object(forKey: "vihar_latitude") as? String
                        }
                        if(jsonObject?.object(forKey: "vihar_longitude") as? String == nil || jsonObject?.object(forKey: "vihar_longitude") as? String == "null" || jsonObject?.object(forKey: "vihar_longitude") as? String == ""){
                            viharStayMModel.long = 0.0
                            viharStayMModel.vihar_longitude = "0.0"
                        }else{
                            viharStayMModel.long = jsonObject?.object(forKey: "vihar_longitude") as? CLLocationDegrees
                            viharStayMModel.vihar_longitude = jsonObject?.object(forKey: "vihar_longitude") as? String
                        }

                        self.viharStayData.add(viharStayMModel)
                    }
                    
                        
                        self.viharTempleView.reloadData()
                        
                        
                        
                        
                    }
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.noted = json!.value(forKey: "note") as! String
                        self.note_color = (json?.object(forKey: "note_color") as? String)!
                        self.note_font_color = (json?.object(forKey: "note_font_color") as? String)!
                         // self.noted = json!.value(forKey: "note") as! String
                        self.viharTempleView.reloadData()
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                    }
                }
    
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let index = indexPath.row as Int
//        
//        if(index > 4){
//            scrolledAlready = false
//        }else{
//            scrolledAlready = true
//        }
//    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        
//        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
//            if(scrolledAlready == true){
//                if(tableViewFromTop.constant == 295){
//                    
//                }else{
//                    print("bottom----")
//                    self.mainMapView.alpha = 1
//                    tableViewFromTop.constant = 420
//                    addViewFromTop.constant = 290
//                    view.layoutIfNeeded()
//                    scrolledAlready = false
//                }
//            }else{
//                
//            }
//        }
//        else {
//            if(scrolledAlready == false){
//                if(tableViewFromTop.constant == 10){
//                    
//                }else{
//                    print("toppppp----")
//                    self.mainMapView.alpha = 0
//                    addViewFromTop.constant = 10
//                    tableViewFromTop.constant = 140
//                    view.layoutIfNeeded()
//                    scrolledAlready = true
//                }
//            }else{
//                
//            }
//            
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
