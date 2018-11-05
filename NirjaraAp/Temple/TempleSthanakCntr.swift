//
//  TempleSthanakCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import JHTAlertController
class TempleSthanakCntr: UIViewController, CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,GMSMapViewDelegate,UIScrollViewDelegate  {
    
    
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    var lastContentOffset: CGFloat = 0
    //var secondIsComing : Bool = false
    var templeData : NSMutableArray = NSMutableArray()
    var templeMarkerData : NSMutableArray = NSMutableArray()
    var loadedOnce : Bool = false
    var scrolledAlready : Bool = false
    let marker = GMSMarker()
//    var TempleName = ["Shree Vasupujay","Shree Suprashwan","Shree Porwal Jain","Shre Sumtinath","Shree Vasupujay","Shree Suprashwan","Shree Porwal Jain","Shre Sumtinath"]
//    var TempleImage = ["default-icon","default-icon","default-icon","default-icon","default-icon","default-icon","default-icon","default-icon"]
//    var TempleAddress = ["3B Malwanu Mlad(w)","B Mumbai Kandivali(w)","B Malwanu Mlad(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)"]
//      var TempleDistance = ["4Km","5Km","12Km","20Km","25Km","40Km","100Km","500Km"]
    
    @IBOutlet weak var templeTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    //var mapView = GMSMapView()
    
    @IBOutlet weak var mapMainView: GMSMapView!
    
    @IBOutlet weak var tableViewFromTop: NSLayoutConstraint!
    @IBOutlet weak var btnFullScreen: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Temple And Sthanak"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:13))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:13,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
       
        mapMainView.delegate = self
        mapMainView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        mapMainView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
        mapMainView.layer.shadowOpacity = 0.8;
        mapMainView.layer.shadowRadius = 2.5;
        mapMainView.layer.masksToBounds = false
        
       self.addShadowToBarMap()
            sideMenu()
        btnFullScreen.addTarget(self, action: #selector(gotoFullPageMap(_:)), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func addTapped(){
        
    }
    @objc func gotoFullPageMap(_ sender : UITapGestureRecognizer){
        
        let fullPageMap = storyboard?.instantiateViewController(withIdentifier: "FullPageMapIdentifier") as! ShowFullMapCntr
        fullPageMap.which = "TempleSthanak"
        fullPageMap.dataOnMap = templeMarkerData
        navigationController?.pushViewController(fullPageMap, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
    
       // self.loadedOnce = false
         if isConnectedToNetwork() {
        loadLocation()
        self.templeData.removeAllObjects()
        
        self.templeTableView.reloadData()
        self.getTempleData(strOffSet: templeData.count)
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "templeHeaderIdentifier") as! TempleHeaderCell
        headerCell.headerMainView.frame = CGRect(x:10,y:0,width:self.view.frame.width-20,height:60)
        
       // headerCell.btnAddTemple.frame = CGRect(x:0,y:0,width:headerCell.headerMainView.frame.width/2-10,height:50)
       // headerCell.btnMyTemple.frame = CGRect(x:headerCell.headerMainView.frame.width/2+10,y:0,width:headerCell.headerMainView.frame.width/2-10,height:50)
        
        headerCell.btnAddTemple.frame = CGRect(x:0,y:0,width:headerCell.headerMainView.frame.width/2-5,height:50)
        headerCell.btnMyTemple.frame = CGRect(x:headerCell.headerMainView.frame.width/2+5,y:0,width:headerCell.headerMainView.frame.width/2,height:50)
        
        
        //headerCell.btnAddTemple.setFAText(prefixText: "", icon: .FAPlus, postfixText: " Add Temple/Sthanak", size: 15, forState: .normal)
        //headerCell.btnAddTemple.setFATitleColor(color: UIColor.rgb(hexcolor: "FF9800"), forState: .normal)
        
        var buttonString = String.fontAwesomeString(name: "fa-plus") + "  " + "AddTemple".localized1
        var buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: CGFloat(GlobalVariables.ButtonofTable))!])
        
        buttonStringAttributed.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: CGFloat(GlobalVariables.ButtonofTable)), range: NSRange(location: 0,length: 1))
        
        buttonStringAttributed.addAttribute(
            NSAttributedStringKey.foregroundColor,
            value: UIColor.rgb(hexcolor: "FF9800"),
            range: NSRange(location: 0,length: 1)
        )
        
        headerCell.btnAddTemple.titleLabel?.textAlignment = .center
        headerCell.btnAddTemple.titleLabel?.textColor = UIColor.white
        headerCell.btnAddTemple.setAttributedTitle(buttonStringAttributed, for: .normal)
        
    
        var buttonString1 = String.fontAwesomeString(name: "fa-filter") + "  " + "PlaceAdded".localized1
        var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: CGFloat(GlobalVariables.ButtonofTable))!])
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: CGFloat(GlobalVariables.ButtonofTable)), range: NSRange(location: 0,length: 1))
        
        buttonStringAttributed1.addAttribute(
            NSAttributedStringKey.foregroundColor,
            value: UIColor.rgb(hexcolor: "FF9800"),
            range: NSRange(location: 0,length: 1)
        )
        
        headerCell.btnMyTemple.titleLabel?.textAlignment = .center
        headerCell.btnMyTemple.titleLabel?.textColor = UIColor.white
        headerCell.btnMyTemple.setAttributedTitle(buttonStringAttributed1, for: .normal)

        
        
        headerCell.headerMainView.addSubview(headerCell.btnAddTemple)
        headerCell.headerMainView.addSubview(headerCell.btnMyTemple)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return templeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = templeTableView.dequeueReusableCell(withIdentifier: "showTempleIdentifer", for: indexPath) as? ShowTempleViewCell
        
        
        
        var templeDate = templeData[indexPath.row] as? templeSthanakModel
        
         cell?.selectionStyle = .none
         cell?.lblTempleName.text = templeDate?.temple_name
         //cell?.lblTempleAddress.text = templeDate?.location
         //cell?.lblTempleDistance.text = templeDate?.distance
        //var image : UIImage = UIImage(named: (templeDate?.temple_photo)!)!
         //cell?.imgTemple.image = image
        
        
        if(templeDate?.temple_photo == nil || templeDate?.temple_photo == ""){

            let placeholderImage = UIImage(named: "default-icon")!
            
            cell?.imgTemple.image = placeholderImage
        }else{
            //let imageView = UIImageView()
            let url = URL(string:(templeDate?.temple_photo)!)
            let placeholderImage = UIImage(named: "default-icon")!
            
            cell?.imgTemple.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }
        
        cell?.templeMainView.frame = CGRect(x:10,y:0,width:self.view.frame.width-20,height:135)
        cell?.imgTemple.frame = CGRect(x:(cell?.templeMainView.frame.origin.x)!-10,y:(cell?.templeMainView.frame.origin.y)!,width:125,height:(cell?.templeMainView.frame.height)!)
        cell?.lblTempleName.frame = CGRect(x:140,y:10,width:(cell?.templeMainView.frame.width)!-145,height:25)

        cell?.locationIcon.frame = CGRect(x:140,y:45,width:12,height:15)
        cell?.lblTempleAddress.text = templeDate?.location
        //let greet4Height = cell?.lblTempleAddress.optimalHeight
        cell?.lblTempleAddress.frame = CGRect(x:155,y:40,width:(cell?.templeMainView.frame.width)!-165,height:25)
        
        cell?.lblTempleDistance.frame = CGRect(x:140,y:(cell?.lblTempleAddress.frame.origin.y)!+(cell?.lblTempleAddress.frame.height)!,width:(cell?.templeMainView.frame.width)!-145,height:30)
        
        cell?.btnEditTemple.frame = CGRect(x:(cell?.templeMainView.frame.width)!-35,y:(cell?.lblTempleDistance.frame.origin.y)!+(cell?.lblTempleDistance.frame.height)!+5,width:20,height:20)
        if(templeDate?.distance == nil){
            cell?.lblTempleDistance.setFAText(prefixText: "", icon: .FALocationArrow, postfixText: " "+("Not Specified"), size: 15)
        }else{
            cell?.lblTempleDistance.setFAText(prefixText: "", icon: .FALocationArrow, postfixText: " "+(templeDate?.distance)!, size: 15)
        }
        cell?.imgFood.frame = CGRect(x:140,y:(cell?.lblTempleDistance.frame.origin.y)!+(cell?.lblTempleDistance.frame.height)!+5,width:27,height:27)
        cell?.imgStay.frame = CGRect(x:180,y:(cell?.lblTempleDistance.frame.origin.y)!+(cell?.lblTempleDistance.frame.height)!+5,width:27,height:27)
        
//        var agetext = templeDate?.food_available
//        agetext = agetext?.replacingOccurrences(of: "Optional", with: "")
//        agetext = agetext?.replacingOccurrences(of: "(", with: "")
//        agetext = agetext?.replacingOccurrences(of: ")", with: "")
//        print("age--",agetext)
        
        if(templeDate?.food_available == "No"){
            cell?.imgFood.alpha = 0
        }else{
            cell?.imgFood.alpha = 1
        }
        
        if(templeDate?.stay_available == "No"){
            cell?.imgStay.alpha = 0
        }else{
            cell?.imgStay.alpha = 1
        }
        
        
        
        
        cell?.btnEditTemple.tag = indexPath.row
        cell?.btnEditTemple.addTarget(self, action: #selector(editTemple(_:)), for: UIControlEvents.touchUpInside)
        
        cell?.templeMainView.addSubview((cell?.lblTempleName)!)
        cell?.templeMainView.addSubview((cell?.lblTempleAddress)!)
        cell?.templeMainView.addSubview((cell?.lblTempleDistance)!)
        cell?.templeMainView.addSubview((cell?.imgTemple)!)
        cell?.templeMainView.addSubview((cell?.imgFood)!)
        cell?.templeMainView.addSubview((cell?.imgStay)!)
        cell?.templeMainView.addSubview((cell?.locationIcon)!)
        
        cell?.templeMainView.dropShadow(color: UIColor.rgb(hexcolor: "#A8A8A8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        return cell!
    }
    
    @objc func editTemple(_ sender : UIButton){
        let editTemple = storyboard?.instantiateViewController(withIdentifier: "editTempleStoryIdentifier") as! EditTempleSthanakCntr
        var templeImageData = templeData[sender.tag] as! templeSthanakModel
        GlobalVariables.editTempleImage = templeImageData.temple_photo
        editTemple.templeData = templeData[sender.tag] as! templeSthanakModel
        self.navigationController?.pushViewController(editTemple, animated: true)
    }
    
    func loadLocation(){
       // GMSServices.provideAPIKey(GlobalVariables.GoogleMapsKey)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "editTempleIdentifier", sender: self)
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let templeDetails = storyboard?.instantiateViewController(withIdentifier: "templeDetailIdentifier") as! TempleDetailViewCntr
        var templeImageData = templeData[indexPath.row] as! templeSthanakModel
        GlobalVariables.editTempleImage = templeImageData.temple_photo
        templeDetails.templeData = templeData[indexPath.row] as! templeSthanakModel
        self.navigationController?.pushViewController(templeDetails, animated:true)
        
        //self.performSegue(withIdentifier: "detailsIdentifier", sender: self)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locationManager.location != nil {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        lat = locValue.latitude
        lng = locValue.longitude
        locationManager.stopUpdatingLocation()
        GlobalVariables.currentLat = String(lat)
        GlobalVariables.currentLong = String(lng)
       
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 13.0)
        self.mapMainView.camera = camera
        
        
        do {
            // Set the map style by passing a valid JSON string.
            //mapView.mapStyle = try GMSMapStyle(jsonString: GlobalVariables.kMapStyle)
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
                }
                
                self.marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                self.marker.title = String(describing: GlobalVariables.currentAddres)
                //marker.snippet = String(describing: p.country)
                self.marker.map = self.mapMainView
                //self.updatePostion(lat: self.lat.description, lon: self.lng.description)
               if(self.loadedOnce == false){
                self.templeMarkerData.removeAllObjects()
                self.getAllTempleMarker()
                self.loadedOnce = true
                }else{
                    
                }
                
                //self.adsresslabel.text = "\(p.administrativeArea)\(p.postalCode)\(p.country)"
            }
                
                
            else {
                print("Problem with the data received from geocoder")
            }
        })
        }else{
            print("location is nill")
        }
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error"+error.localizedDescription)
    }

    
    
    func getAllTempleMarker(){
        
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_all_temple_marker)!
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
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    
                    DispatchQueue.main.async {
                        
                        let jobData = json?.object(forKey: "result") as? [NSDictionary]
                        for i in 0..<jobData!.count{
                            let jsonObject = jobData?[i]
                            var templeMModel = templeSthanakModel()
                            templeMModel.type = jsonObject?.object(forKey: "type") as? String
                            templeMModel.temple_name = jsonObject?.object(forKey: "temple_name") as? String
                            templeMModel.location = jsonObject?.object(forKey: "location") as? String
                            if(jsonObject?.object(forKey: "distance") as? String == nil){
                                templeMModel.distance = "Not Specified"
                            }else{
                                templeMModel.distance = jsonObject?.object(forKey: "distance") as? String
                            }
                            
                            
                            if(jsonObject?.object(forKey: "latitude") as? String == nil || jsonObject?.object(forKey: "latitude") as? String == "null" || jsonObject?.object(forKey: "latitude") as? String == "" || jsonObject?.object(forKey: "latitude") as? String == "No"){
                                
                                templeMModel.latitude = "0.0"
                            }else{
                                
                                templeMModel.latitude = jsonObject?.object(forKey: "latitude") as? String
                            }
                            if(jsonObject?.object(forKey: "longitude") as? String == nil || jsonObject?.object(forKey: "longitude") as? String == "null" || jsonObject?.object(forKey: "longitude") as? String == "" || jsonObject?.object(forKey: "longitude") as? String == "No"){
                                
                                templeMModel.longitude = "0.0"
                            }else{
                                
                                templeMModel.longitude = jsonObject?.object(forKey: "longitude") as? String
                            }
                            self.templeMarkerData.add(templeMModel)
                            
                        }
                        
                        for i in 0..<self.templeMarkerData.count{
                            
                            var latAndLong = self.templeMarkerData[i] as! templeSthanakModel
                            let markerImage = UIImage(named: "d3-blue")!.withRenderingMode(.alwaysOriginal)
                            let markerView = UIImageView(image: markerImage)
                            markerView.tintColor = UIColor.red
                            let position = CLLocationCoordinate2D(latitude: Double(latAndLong.latitude)!, longitude: Double(latAndLong.longitude)!)
                            let london = GMSMarker(position: position)
                            london.title = "Title".localized1+" : "+latAndLong.temple_name
                            //london.snippet = "Address".localized1+" : "+latAndLong.location
                            london.snippet = "\("Address".localized1+" : "+latAndLong.location!) \n \("Distance"+" : "+latAndLong.distance)"
                            
                            // london.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                            london.iconView = markerView
                            //london.icon = UIImage(named: "d2-blue")
                            london.map = self.mapMainView
                        }
                        
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func getTempleData(strOffSet : Int){
        
        //let parameters = "location=Mumbai&lang="+GlobalVariables.selectedLanguage+"&member_id="+(UserDefaults.standard.getUserID())
       // let parameters = "location=jalgaon&lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let parameters = "location=\(GlobalVariables.TempleState)&lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())&offset=\(strOffSet)"
        //let url = URL(string:ServerUrl.get_temples_by_location_wise)!
        let url = URL(string:ServerUrl.get_latest_ten_temple)!
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
               
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    
                    DispatchQueue.main.async {
                        
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var templeMModel = templeSthanakModel()
                        
                        templeMModel.temple_id = jsonObject?.object(forKey: "temple_id") as? String
                        templeMModel.temple_name = jsonObject?.object(forKey: "temple_name") as? String
                        templeMModel.temple_info = jsonObject?.object(forKey: "temple_info") as? String
                        templeMModel.member_id = jsonObject?.object(forKey: "member_id") as? String
                        templeMModel.location = jsonObject?.object(forKey: "location") as? String
                        templeMModel.food_available = jsonObject?.object(forKey: "food_available") as? String
                        templeMModel.stay_available = jsonObject?.object(forKey: "stay_available") as? String
                        templeMModel.temple_photo = jsonObject?.object(forKey: "temple_photo") as? String
                        //templeMModel.distance = jsonObject?.object(forKey: "distance") as? String
                        
                        
                        if(jsonObject?.object(forKey: "distance") as? String == nil){
                            templeMModel.distance = "Not Specified"
                        }else{
                            templeMModel.distance = jsonObject?.object(forKey: "distance") as? String
                        }
                        
                        templeMModel.contact = jsonObject?.object(forKey: "contact") as? String
                        templeMModel.type = jsonObject?.object(forKey: "type") as? String
                        if(jsonObject?.object(forKey: "latitude") as? String == nil || jsonObject?.object(forKey: "latitude") as? String == "null" || jsonObject?.object(forKey: "latitude") as? String == ""){
                            
                            templeMModel.latitude = "0.0"
                        }else{
                            
                            templeMModel.latitude = jsonObject?.object(forKey: "latitude") as? String
                        }
                        if(jsonObject?.object(forKey: "longitude") as? String == nil || jsonObject?.object(forKey: "longitude") as? String == "null" || jsonObject?.object(forKey: "longitude") as? String == ""){
                            
                            templeMModel.longitude = "0.0"
                        }else{
                            
                            templeMModel.longitude = jsonObject?.object(forKey: "longitude") as? String
                        }
                        self.templeData.add(templeMModel)
                        
                    }
                    

                        self.templeTableView.reloadData()
                        self.hideActivityIndicator()
                        
                        
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = templeData.count - 1
        if(indexPath.row) == index{
            if isConnectedToNetwork() {
            getTempleData(strOffSet: templeData.count)
            }else{
                showAlert(title: "OOp's", message: "No Internet Connection")
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//       /// let indexPath1 = IndexPath(row: 4, section: 0)
//        let index = indexPath.row as Int
//        
//        if(index > 4){
//            scrolledAlready = false
//        }else{
//            scrolledAlready = true
//        }
//    }
//    
//    
//    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//       
//        
//        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
//            if(scrolledAlready == true){
//                if(tableViewFromTop.constant == 295){
//                    
//                }else{
//                print("bottom----")
//                self.mapMainView.alpha = 1
//                tableViewFromTop.constant = 295
//                view.layoutIfNeeded()
//                scrolledAlready = false
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
//                print("toppppp----")
//                self.mapMainView.alpha = 0
//                tableViewFromTop.constant = 10
//                view.layoutIfNeeded()
//                scrolledAlready = true
//                }
//            }else{
//                
//            }
//
//        }
//
////        if (self.lastContentOffset < scrollView.contentOffset.y) {
////
////            // self.mapMainView.isHidden = true
////            self.mapMainView.alpha = 0
////            tableViewFromTop.constant = 10
////            view.layoutIfNeeded()
////
////        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
////
////
////            if(secondIsComing == true){
////            self.mapMainView.alpha = 1
////
////            //self.mapMainView.isHidden = false
////            tableViewFromTop.constant = 295
////            view.layoutIfNeeded()
////            }else{
////
////            }
////        } else {
////            // didn't move
////        }
//    }
    

    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//         self.lastContentOffset = scrollView.contentOffset.y
//    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
