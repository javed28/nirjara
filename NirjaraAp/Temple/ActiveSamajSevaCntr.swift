//
//  ActiveSamajSevaCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import JHTAlertController

class ActiveSamajSevaCntr: UIViewController , CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,GMSMapViewDelegate,UIScrollViewDelegate {
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var activeCollection: UICollectionView!
    
    @IBOutlet weak var btnFullScreen: UIButton!
    
    @IBOutlet weak var mainMapView: GMSMapView!
    var ActiveSamajSevaData : NSMutableArray = NSMutableArray()
    private let kCellheaderReuse : String = "activeHeader"
    
    var noted : String = "अगर आप FREE बैठे हैं तो क्यों न समाज सेवा हो जाये , यहां दो पल के लिए ही सही अपने आप को समाज सेवा के लिए एक्टिव (ACTIVE ) करे , न जाने कब कहा और किस निम्मित से हम्मारी ये ज़िन्दगी किसी जरुरत मंद के काम आजाये।"
    var note_color : String = "#001669"
    var note_font_color : String = "#ffef00"
    @IBOutlet weak var btnActiveSamajSeva: UIButton!
    
    var loadedOnce : Bool = false
    var scrolledAlready : Bool = false
    @IBOutlet weak var lblNoRecord: UILabel!
    
    
    @IBOutlet weak var btnActiveFromTop: NSLayoutConstraint!
    @IBOutlet weak var collectionViewFromTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Active Samaj Seva"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:15))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:15,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points : 0", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
       // btnActiveSamajSeva.frame = CGRect(x:40,y:300,width:self.view.frame.width-80,height:50)
        sideMenu()
        mainMapView.delegate = self
        mainMapView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        mainMapView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
        mainMapView.layer.shadowOpacity = 0.8;
        mainMapView.layer.shadowRadius = 2.5;
        mainMapView.layer.masksToBounds = false
        btnFullScreen.addTarget(self, action: #selector(gotoFullPageMap(_:)), for: UIControlEvents.touchUpInside)
        self.addShadowToBarMap()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if(isConnectedToNetwork()){
        self.loadedOnce = false
        loadLocation()
        }else{
            
        }
        
    }
    @objc func addTapped(){
    
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
//        mapView = GMSMapView.map(withFrame: CGRect(x:0,y:0,width:self.view.frame.width,height:self.mainMapView.frame.height), camera: camera)
//        self.mainMapView.addSubview(mapView)
        do {
            // Set the map style by passing a valid JSON string.
           // mapView.mapStyle = try GMSMapStyle(jsonString: GlobalVariables.kMapStyle)
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
                        print("locality---",pm.locality!)
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print("current Addre---111111",addressString)
                    
                    GlobalVariables.currentAddres = addressString
                }
                
                
                self.mainMapView.clear()
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                marker.title = String(describing: GlobalVariables.currentAddres)
                //marker.snippet = String(describing: p.country)
                marker.map = self.mainMapView
               // self.updatePostion(lat: self.lat.description, lon: self.lng.description)
//                self.ActiveSamajSevaData.removeAllObjects()
//                self.activeCollection.reloadData()
//                self.getActiveSamajSeva()

                            if(self.loadedOnce == false){
                                self.ActiveSamajSevaData.removeAllObjects()
                                self.activeCollection.reloadData()
                                self.lblNoRecord.alpha = 0
                                self.getActiveSamajSeva()
                                self.loadedOnce = true
                            }else{
                
                            }
                
            }
            else {
                print("Problem with the data received from geocoder")
            }
           
  
        })
        }else{
            print("location manager nullll")
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
    @objc func gotoFullPageMap(_ sender : UITapGestureRecognizer){
        
        let fullPageMap = storyboard?.instantiateViewController(withIdentifier: "FullPageMapIdentifier") as! ShowFullMapCntr
        fullPageMap.which = "ActiveSamajSeva"
        fullPageMap.dataOnMap = ActiveSamajSevaData
        navigationController?.pushViewController(fullPageMap, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error"+error.localizedDescription)
    }
    
    func getActiveSamajSeva(){
        let parameters = "location=\(GlobalVariables.TempleState)&lang\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        //let parameters = "location=Mumbai&lang="+GlobalVariables.selectedLanguage
        
        let url = URL(string:ServerUrl.get_nearby_active_samaj_sewak)!
       
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

                self.noted = json!.value(forKey: "note") as! String
                self.note_color = json!.object(forKey: "note_color") as! String
                self.note_font_color = json!.object(forKey: "note_font_color") as! String
                
                let message : String =  json!.value(forKey: "message") as! String
                if (message == "success")
                {
                   DispatchQueue.main.async {
                    self.lblNoRecord.alpha = 0
                    let viharData = json!.value(forKey: "result") as? [NSDictionary]
                    for j in 0..<viharData!.count{
                        let jsonObject = viharData?[j]
                        var activeSamajModel = activeSamajSevaModel()
                        
                        activeSamajModel.name = jsonObject?.object(forKey: "name") as? String
                        activeSamajModel.contact = jsonObject?.object(forKey: "contact") as? String
                        activeSamajModel.address = jsonObject?.object(forKey: "address") as? String
                        activeSamajModel.time_from = jsonObject?.object(forKey: "address") as? String
                        activeSamajModel.time_to = jsonObject?.object(forKey: "address") as? String
                        if(jsonObject?.object(forKey: "distance") as? String == nil){
                             activeSamajModel.distance = "Not Specified"
                        }else{
                             activeSamajModel.distance = jsonObject?.object(forKey: "distance") as? String
                        }
                       
                      //  activeSamajModel.latitude = jsonObject?.object(forKey: "latitude") as? String
                        
                        
                        if(jsonObject?.object(forKey: "latitude") as? String == nil || jsonObject?.object(forKey: "latitude") as? String == "null" || jsonObject?.object(forKey: "latitude") as? String == ""){
                            
                            activeSamajModel.latitude = "0.0"
                        }else{
                           
                            activeSamajModel.latitude = jsonObject?.object(forKey: "latitude") as? String
                        }
                        if(jsonObject?.object(forKey: "longitude") as? String == nil || jsonObject?.object(forKey: "longitude") as? String == "null" || jsonObject?.object(forKey: "longitude") as? String == ""){
                            
                            activeSamajModel.longitude = "0.0"
                        }else{
                            
                            activeSamajModel.longitude = jsonObject?.object(forKey: "longitude") as? String
                        }
                        
                        self.ActiveSamajSevaData.add(activeSamajModel)
                        
                    }
                    
                        self.hideActivityIndicator()
                        self.activeCollection.reloadData()
                    
                    for i in 0..<self.ActiveSamajSevaData.count{
                        
                        var latAndLong = self.ActiveSamajSevaData[i] as! activeSamajSevaModel

                        let markerImage = UIImage(named: "d11-blue")!.withRenderingMode(.alwaysOriginal)
                        let markerView = UIImageView(image: markerImage)
                        markerView.tintColor = UIColor.red
                        let position = CLLocationCoordinate2D(latitude: Double(latAndLong.latitude)!, longitude: Double(latAndLong.longitude)!)
                        let london = GMSMarker(position: position)
                        london.title = "Title".localized1+" : "+latAndLong.name
                        //london.snippet = latAndLong.contact
                        london.snippet = "\("ContactNumber".localized1+" : "+latAndLong.contact!) \n \("Time".localized1+" : "+latAndLong.time_from!+" - "+latAndLong.time_to)\n \("Address".localized1+" : "+latAndLong.address!)\n \("Distance"+" : "+latAndLong.distance!)"
                        // london.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                        london.iconView = markerView
                        //london.icon = UIImage(named: "d2-blue")
                        london.map = self.mainMapView
                        
                    }

                    
                    
                    }
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.activeCollection.reloadData()
                        self.lblNoRecord.alpha = 1
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ActiveSamajSevaData.count
    }
    
    
    //    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    //
    //        let screenWidth = (self.view.frame.size.width - 12 * 3) / 3
    //        return CGSize(width: screenWidth, height: 250);
    //    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding: CGFloat =  10
        // let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionView.frame.size.width/2-5, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = activeCollection.dequeueReusableCell(withReuseIdentifier: "activeIdentifier", for: indexPath) as! activeSamajSevaCollectionViewCell
    
        
        var activeSamajData = ActiveSamajSevaData[indexPath.row] as! activeSamajSevaModel
        
        cell.mainView?.frame = CGRect(x:0,y:15,width:view.frame.width/2,height:110)
        cell.lblName.text = activeSamajData.name

        cell.lblName?.frame = CGRect(x:15,y:10,width:(cell.mainView?.frame.width)!,height:20)
        cell.imgLocation?.frame = CGRect(x:15,y:38,width:10,height:10)
        cell.lblAddress?.frame = CGRect(x:28,y:33,width:(cell.mainView?.frame.width)!-35,height:20)
        cell.imgMobile?.frame = CGRect(x:15,y:58,width:10,height:10)
        cell.lblContactNo?.frame = CGRect(x:28,y:53,width:(cell.mainView?.frame.width)!,height:20)
        cell.lblDistance?.frame = CGRect(x:15,y:73,width:(cell.mainView?.frame.width)!,height:20)
        cell.lblDistance.setFAText(prefixText: "", icon: .FALocationArrow, postfixText:activeSamajData.distance, size: 12)
        cell.lblAddress.text = activeSamajData.address
        cell.lblContactNo.text = activeSamajData.contact
        
        cell.mainView.addSubview(cell.lblName)
        cell.mainView.addSubview(cell.lblAddress)
        cell.mainView.addSubview(cell.lblContactNo)
        cell.mainView.addSubview(cell.imgLocation)
        cell.mainView.addSubview(cell.imgMobile)
        cell.mainView.addSubview(cell.lblDistance)
        cell.mainView.dropShadow(color: UIColor.rgb(hexcolor: "#A8A8A8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = CGSize(width: self.view.frame.width, height: 93)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
       
        let headerView : ActiveSamajHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCellheaderReuse, for: indexPath) as! ActiveSamajHeaderCell
        //headerView.lblNote.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
        
        //let lblheight : CGFloat = CGFloat.greatestFiniteMagnitude
        
        //let greet4Height = headerView.lblNote.optimalHeight
        headerView.lblNote.lineBreakMode = .byWordWrapping
        headerView.lblNote.numberOfLines = 0
        headerView.lblNote.text = noted
        headerView.lblNote.frame = CGRect(x:10,y:5,width:self.view.frame.width-30,height:88)
        headerView.backgroundColor = UIColor.rgb(hexcolor: note_color)
        headerView.lblNote.textColor = UIColor.rgb(hexcolor: note_font_color)
        
        // reusableView = headerView
        // }
        return headerView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  /*  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.row as Int

        if(index > 4){
            scrolledAlready = false
        }else{
            scrolledAlready = true
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            if(scrolledAlready == true){
                if(btnActiveFromTop.constant == 295){
                    
                }else{
                    print("bottom----")
                    self.mainMapView.alpha = 1
                    btnActiveFromTop.constant = 290
                    collectionViewFromTop.constant = 345
                    view.layoutIfNeeded()
                    scrolledAlready = false
                }
            }else{
                
            }
        }
        else {
            if(scrolledAlready == false){
                if(btnActiveFromTop.constant == 10){
                    
                }else{
                    print("toppppp----")
                    self.mainMapView.alpha = 0
                    btnActiveFromTop.constant = 10
                    collectionViewFromTop.constant = 65
                    view.layoutIfNeeded()
                    scrolledAlready = true
                }
            }else{
                
            }
            
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
