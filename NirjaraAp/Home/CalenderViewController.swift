//
//  CalenderViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import FSCalendar
import ImageSlideshow
import CoreLocation
class CalenderViewController: UIViewController,CLLocationManagerDelegate,FSCalendarDataSource,FSCalendarDelegate {

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
      private var currentCalendar: Calendar?
    private var shouldShowDaysOut = true
    private var animationFinished = true
    private var randomNumberOfDotMarkersForDay = [Int]()
    
    @IBOutlet weak var lblTodayTithi: UILabel!
    
    var calenderAds : NSMutableArray = NSMutableArray()
    @IBOutlet weak var adsSlideShow: ImageSlideshow!
    @IBOutlet weak var SunriseSunsetView: UIView!
    
    @IBOutlet weak var lblSunsetTime: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    
    var checkOnce : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMenu()
        
        
       adsSlideShow.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 4, scale: true)
        calender.layer.borderColor = UIColor.black.cgColor
        calender.layer.borderWidth = 0.8
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDate = formatter.string(from: date)
        self.calender.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.calender.select(self.formatter.date(from: currentDate)!)
 SunriseSunsetView.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 4, scale: true)
        self.addShadowToBarMap()
        getTithi()
        getAdvertiseMent()
        
        if(GlobalVariables.currentLong == "0.0" || GlobalVariables.currentLat == "0.0"){
            loadLocation()
        }else{
             getSunriSet()
        }
        
    
        
        //let scopeGesture = UIPanGestureRecognizer(target: self.selectDate, action: #selector(self.selectDate.handleScopeGesture(_:)))
       // self.calender.addGestureRecognizer(scopeGesture)
        
        // For UITest
//        self.selectDate.scrollDirection = .vertical
//        self.selectDate.pagingEnabled = false
        self.calender.accessibilityIdentifier = "calendar"
        // Do any additional setup after loading the view.
    }
    func setTopMenu(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        if(UserDefaults.standard.getLanguage() == "en"){
            
            let myString:NSString = "  Calender"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
            
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
            
        }else if(UserDefaults.standard.getLanguage() == "hi"){
            let myString:NSString = "  कैलेंडर"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
            
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            let myString:NSString = "  કૅલેન્ડર"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points".localized1, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
        
    }
    
    func loadLocation(){
        //GMSServices.provideAPIKey(GlobalVariables.GoogleMapsKey)
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
        
        lat = locValue.latitude
        lng = locValue.longitude
        GlobalVariables.currentLong = String(lng)
        GlobalVariables.currentLat = String(lat)
        
        locationManager.stopUpdatingLocation()
        
        
        let location = CLLocation(latitude: lat, longitude: lng) //changed!!!
        
        
        
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
                        
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    GlobalVariables.currentAddres = addressString
                    
                    if(self.checkOnce == false){
                         self.checkOnce = true
                         self.getSunriSet()
                    }else{
                        
                    }
                   
                }
                

            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error"+error.localizedDescription)
    }
    
    
    
    func getTithi(){
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let parameters = "dd=\(day!)&mm=\(month!)&yyyy=\(year!)&hour=\(hour)&min=\(minutes)"
        let url = URL(string:ServerUrl.get_pachang_new)!
        print("url=----",parameters)
        print("url=----",url)
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
                
                let tithi = json?.object(forKey: "new") as? String;
                
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblTodayTithi.text = "TodayTithi".localized1+" : "+tithi!
                }
               
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func getSunriSet(){

        let parameters = "latitude=\(GlobalVariables.currentLat)&longitude=\(GlobalVariables.currentLong)"
        let url = URL(string:ServerUrl.getTimeZone)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       print("locaiton",parameters)
       
        
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

                //print("Googl response",json)
                let status = json?.object(forKey: "status") as? String;
                
                if(status == "OK"){
                    let timeZoneId = json?.object(forKey: "timeZoneId") as? String;
                    DispatchQueue.main.async {
                        
                        self.getVrathPachkan(timeZone: timeZoneId!)
                        
                    }
                }else if(status == "INVALID_REQUEST"){
                    print("falsee")
                }
                
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    func getVrathPachkan(timeZone : String){
        let parameters = "latitude=\(GlobalVariables.currentLat)&longitude=\(GlobalVariables.currentLong)&timezone=\(timeZone)&city=\(GlobalVariables.TempleState)"
        let url = URL(string:ServerUrl.get_vrath_pachkan)!
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
                    let result = json?.object(forKey: "result") as? [NSDictionary]
                    
                    
                    DispatchQueue.main.async {
                        for i in 0..<result!.count{
                            let jsonObject = result?[i]
                            
                            let Title = jsonObject?.object(forKey: "Title") as? String
                            
                            if(Title == "Sunrise"){
                                self.lblSunriseTime.text = jsonObject?.object(forKey: "Time") as? String
                            }else if(Title == "Sunset"){
                                self.lblSunsetTime.text = jsonObject?.object(forKey: "Time") as? String
                            }
                            
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
    
    func getAdvertiseMent(){
        //let parameters = "adv_location=calender"
        var parameters = String()
        if(UserDefaults.standard.isKeyPresentInUserDefaults(key : "lastAddress")){
            parameters = "adv_location=calender&location=\(UserDefaults.standard.getLastAddress())"
        }else{
            parameters = "adv_location=calender&location="
        }
        let url = URL(string:ServerUrl.get_advertisement_calender)!
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<recommendData!.count{
                        let jsonObject = recommendData?[i]
                        var bottomhome = bottomBanner()
                        bottomhome.id = jsonObject?.object(forKey: "advertisement_id") as? String
                        bottomhome.imageSrc = jsonObject?.object(forKey: "adv_banner") as? String
                        bottomhome.name = jsonObject?.object(forKey: "adv_title") as? String
                        self.calenderAds.add(bottomhome)
                     
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        var images = [InputSource]()
                        for i in 0..<self.calenderAds.count{
                            var bannerData  = self.calenderAds[i] as! bottomBanner
                            var bannerImage : String = bannerData.imageSrc
                            let alamofireSource = AlamofireSource(urlString: bannerImage)!
                            images.append(alamofireSource)
                        }
                        
                        self.adsSlideShow.setImageInputs(images)
                        self.adsSlideShow.backgroundColor = UIColor.white
                        self.adsSlideShow.slideshowInterval = 3.5

                        self.adsSlideShow.pageControl.isHidden = true
                        self.adsSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
                        
                        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTap))
                        self.adsSlideShow.addGestureRecognizer(gestureRecognizer)
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
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

    }
    
   
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        sideMenu()
    }
    func sideMenu(){
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            // menuButton.image  = UIImage(named:"hamburger")?.withRenderingMode(.alwaysOriginal);
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 180
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "31-12-2020")!
    }
    
    public func minimumDate(for calendar: FSCalendar) -> Date {
        return Date() // crash!
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




