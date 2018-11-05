//
//  GurutrakingCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import JHTAlertController

class GurutrakingCntr: UIViewController, CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,GMSMapViewDelegate  {
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var guruTrackingTable: UITableView!
    @IBOutlet weak var btnFullScreen: UIButton!
    
    @IBOutlet weak var noteBackground: UIView!
    var note : String = "जीन रिजस्टर जैन साधु संतो के निकट आने पर आपको ऑटो नोटिफिकेशन द्वारा सूचित किया जाना चाइये, ताकि आप को गुरु दर्शन, गोचरी आदि का लाभ मिले उन्हें ON रखे वरना OFF रखे"
    var note_color : String = "#001669"
    var note_font_color : String = "#fff400"
    var sections = [String]()
    
    var subGroupNameitems = [[String]]()
    var subGroupitemsId = [[String]]()
    
    //var mapView = GMSMapView()
    @IBOutlet weak var lblNote: UILabel!
    
    var userDataOfGuru1 : NSMutableArray = NSMutableArray()
    var userDataOfGuru2 : NSMutableArray = NSMutableArray()
    var userDataOfGuru3 : NSMutableArray = NSMutableArray()
    var userDataOfGuru4 : NSMutableArray = NSMutableArray()
    var userDataOfGuru5 : NSMutableArray = NSMutableArray()
    
    var markerData : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var mainMapView: GMSMapView!
    
    var scrolledAlready : Bool = false
    @IBOutlet weak var noteTopHeight: NSLayoutConstraint!
    @IBOutlet weak var tableTopHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Guru Bhagwant Tracking"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:16))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:16,length:8))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        guruTrackingTable.separatorStyle = .none;
        guruTrackingTable.layer.borderColor = UIColor.gray.cgColor
        guruTrackingTable.layer.borderWidth = 2
        mainMapView.delegate = self
        mainMapView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        mainMapView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
        mainMapView.layer.shadowOpacity = 0.8;
        mainMapView.layer.shadowRadius = 2.5;
        mainMapView.layer.masksToBounds = false
        btnFullScreen.addTarget(self, action: #selector(ViharStayCntr.gotoFullPageMap(_:)), for: UIControlEvents.touchUpInside)
        self.addShadowToBarMap()
        
        sideMenu()
        loadLocation()
        
        // Do any additional setup after loading the view.
    }
    @objc func addTapped(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         print("Wiill Appear")
         if isConnectedToNetwork() {
        sections.removeAll()
        subGroupNameitems.removeAll()
        subGroupitemsId.removeAll()
        markerData.removeAllObjects()
        guruTrackingTable.reloadData()
        getMarkerData()
        getSwitchUserOnData()
         }else{
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Did Appear")
        if isConnectedToNetwork() {
            
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
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
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subGroupitemsId[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var returnedView = UIView(frame: CGRect(x:0, y:10, width:self.view.frame.width, height:40)) //set these values as necessary
        returnedView.backgroundColor = UIColor.white
        returnedView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        let label = UILabel(frame: CGRect(x:20, y:0, width:returnedView.frame.width-20, height:40))
        label.text = sections[section].uppercased()
        label.textColor = UIColor.rgb(hexcolor: "#002866")
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        returnedView.addSubview(label)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = guruTrackingTable.dequeueReusableCell(withIdentifier: "guruTrackingIdentifier", for: indexPath) as! GuruTrackingTableViewCell
 
       // if(UserDefaults.standard.getMemberType() == "guru" || UserDefaults.standard.getMemberType() == "Guru"){
        if(subGroupitemsId.count == 0){
            
            cell.switchOnOff.alpha = 0 // the "off" color
            cell.imgNamaskar.alpha = 0
            cell.lblGuruName.alpha = 0
            cell.switchOnOff.alpha = 0
            cell.bottomBorder.alpha = 0
            cell.switchOnOff.isOn = false
            return cell
        }else{
            let itemidSub = subGroupitemsId[indexPath.section][indexPath.row]
            cell.lblGuruName.text = subGroupNameitems[indexPath.section][indexPath.row].capitalized
        
            if(indexPath.section == 0){
                if(userDataOfGuru1.count == 0){
                    cell.switchOnOff.isOn = false
                }else{
                    if(subGroupitemsId[indexPath.section].count > userDataOfGuru1.count){
                        for i in 0..<subGroupitemsId[indexPath.section].count{
                            for j in 0..<userDataOfGuru1.count{
                             var userSwitchOnData = userDataOfGuru1[j] as! guruTrackingModel
                                if(userSwitchOnData.sub_group_id ==  itemidSub ){
                                    if(userSwitchOnData.mod == "on"){
                                        cell.switchOnOff.isOn = true
                                        break
                                    }else{
                                        cell.switchOnOff.isOn = false
                                    }
                                }
                            }
                        }
                    }else{
                    for i in 0..<userDataOfGuru1.count{
                        var userSwitchOnData = userDataOfGuru1[i] as! guruTrackingModel
                        if(userSwitchOnData.sub_group_id ==  itemidSub ){
                            if(userSwitchOnData.mod == "on"){
                                cell.switchOnOff.isOn = true
                                break
                            }else{
                                cell.switchOnOff.isOn = false
                            }
                        }
                    }
                }
              }
            }else if(indexPath.section == 1){
                if(userDataOfGuru2.count == 0){
                    cell.switchOnOff.isOn = false
                }else{
                    if(subGroupitemsId[indexPath.section].count > userDataOfGuru2.count){
                        for i in 0..<subGroupitemsId[indexPath.section].count{
                            for j in 0..<userDataOfGuru2.count{
                                var userSwitchOnData = userDataOfGuru2[j] as! guruTrackingModel
                                if(userSwitchOnData.sub_group_id ==  itemidSub ){
                                    if(userSwitchOnData.mod == "on"){
                                        cell.switchOnOff.isOn = true
                                        break
                                    }else{
                                        cell.switchOnOff.isOn = false
                                    }
                                }
                            }
                        }
                    }else{
                    for i in 0..<userDataOfGuru2.count{
                        var userSwitchOnData = userDataOfGuru2[i] as! guruTrackingModel
                        if(userSwitchOnData.sub_group_id ==  itemidSub ){
                            if(userSwitchOnData.mod == "on"){
                                cell.switchOnOff.isOn = true
                                break
                            }else{
                                cell.switchOnOff.isOn = false
                            }
                        }
                    }
                }
                }
            }else if(indexPath.section == 2){
                if(userDataOfGuru3.count == 0){
                    cell.switchOnOff.isOn = false
                }else{
                    if(subGroupitemsId[indexPath.section].count > userDataOfGuru3.count){
                        for i in 0..<subGroupitemsId[indexPath.section].count{
                            for j in 0..<userDataOfGuru3.count{
                                var userSwitchOnData = userDataOfGuru3[j] as! guruTrackingModel
                                if(userSwitchOnData.sub_group_id ==  itemidSub ){
                                    if(userSwitchOnData.mod == "on"){
                                        cell.switchOnOff.isOn = true
                                        break
                                    }else{
                                        cell.switchOnOff.isOn = false
                                    }
                                }
                            }
                        }
                    }else{
                    
                    for i in 0..<userDataOfGuru3.count{
                        var userSwitchOnData = userDataOfGuru3[i] as! guruTrackingModel
                        if(userSwitchOnData.sub_group_id ==  itemidSub ){
                            if(userSwitchOnData.mod == "on"){
                                cell.switchOnOff.isOn = true
                                break
                            }else{
                                cell.switchOnOff.isOn = false
                            }
                        }
                    }
                }
                }
            }else if(indexPath.section == 3){
                if(userDataOfGuru4.count == 0){
                    cell.switchOnOff.isOn = false
                }else{
                    if(subGroupitemsId[indexPath.section].count > userDataOfGuru4.count){
                        for i in 0..<subGroupitemsId[indexPath.section].count{
                            for j in 0..<userDataOfGuru4.count{
                                var userSwitchOnData = userDataOfGuru4[j] as! guruTrackingModel
                                if(userSwitchOnData.sub_group_id ==  itemidSub ){
                                    if(userSwitchOnData.mod == "on"){
                                        cell.switchOnOff.isOn = true
                                        break
                                    }else{
                                        cell.switchOnOff.isOn = false
                                    }
                                }
                            }
                        }
                    }else{
                    for i in 0..<userDataOfGuru4.count{
                        var userSwitchOnData = userDataOfGuru4[i] as! guruTrackingModel
                        if(userSwitchOnData.sub_group_id ==  itemidSub ){
                            if(userSwitchOnData.mod == "on"){
                                cell.switchOnOff.isOn = true
                                break
                            }else{
                                cell.switchOnOff.isOn = false
                            }
                        }
                        }
                    }
                }
            }else if(indexPath.section == 4){
                if(userDataOfGuru5.count == 0){
                    cell.switchOnOff.isOn = false
                }else{
                    
                    if(subGroupitemsId[indexPath.section].count > userDataOfGuru5.count){
                        for i in 0..<subGroupitemsId[indexPath.section].count{
                            for j in 0..<userDataOfGuru5.count{
                                var userSwitchOnData = userDataOfGuru5[j] as! guruTrackingModel
                                if(userSwitchOnData.sub_group_id ==  itemidSub ){
                                    if(userSwitchOnData.mod == "on"){
                                        cell.switchOnOff.isOn = true
                                        break
                                    }else{
                                        cell.switchOnOff.isOn = false
                                    }
                                }
                            }
                        }
                    }else{
                    for i in 0..<userDataOfGuru5.count{
                        var userSwitchOnData = userDataOfGuru5[i] as! guruTrackingModel
                        if(userSwitchOnData.sub_group_id ==  itemidSub ){
                            if(userSwitchOnData.mod == "on"){
                                cell.switchOnOff.isOn = true
                                break
                            }else{
                                cell.switchOnOff.isOn = false
                            }
                        }
                        }
                    }
                }
            }
            
            cell.switchOnOff.accessibilityLabel = itemidSub+"::"+String(indexPath.section)+"::"+String(indexPath.row)
            if(indexPath.section == 0){
                cell.switchOnOff.tag = 1
            }else if(indexPath.section == 1){
                cell.switchOnOff.tag = 2
            }
            else if(indexPath.section == 2){
                cell.switchOnOff.tag = 3
            }
            else if(indexPath.section == 3){
                cell.switchOnOff.tag = 4
            }
            else if(indexPath.section == 4){
                cell.switchOnOff.tag = 5
            }
         cell.switchOnOff.tintColor = UIColor.red // the "off" color
         cell.imgNamaskar.frame = CGRect(x:10,y:5,width:36,height:36)
         cell.lblGuruName.frame = CGRect(x:45,y:0,width:view.frame.width-100,height:45)
         cell.switchOnOff.frame = CGRect(x:view.frame.width-80,y:5,width:40,height:40)
         cell.bottomBorder.frame = CGRect(x:10,y:50,width:view.frame.width-70,height:1)
        
        
        cell.switchOnOff.addTarget(self, action: #selector(ChangeSwicthValue(_:)), for: UIControlEvents.valueChanged)
        return cell
        }
    }
    
    @objc func ChangeSwicthValue(_ sender : UISwitch){
        if isConnectedToNetwork(){
        print("subgroupId--",sender.accessibilityLabel)
        print("mainGroupId--",sender.tag)
        let subGroupPath = sender.accessibilityLabel?.components(separatedBy: "::")
        var subGroupIId: String = subGroupPath![0]
        if(sender.isOn){
            postWhichGuru(subGrouId:subGroupIId,mainGrouId:sender.tag,mod:"on",indexpathOfSection: Int(subGroupPath![1])!,indexpathRow: Int(subGroupPath![2])!)
        }else{
            postWhichGuru(subGrouId:subGroupIId,mainGrouId:sender.tag,mod:"off",indexpathOfSection: Int(subGroupPath![1])!,indexpathRow: Int(subGroupPath![2])!)
        }
       }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
     }
  }
    
    func postWhichGuru(subGrouId : String,mainGrouId : Int,mod : String,indexpathOfSection : Int,indexpathRow : Int){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&sub_group_id=\(subGrouId)&main_group_id=\(mainGrouId)&mod=\(mod)"
        print("parameters---",parameters)
        let url = URL(string:ServerUrl.post_guru_tracking)!
        print("urllll---",url)
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
                print("json00000--",json)
                if (Status == "Success")
                {
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        
                        let jobData = json?.object(forKey: "data") as? [NSDictionary]
                        self.userDataOfGuru1.removeAllObjects()
                        self.userDataOfGuru2.removeAllObjects()
                        self.userDataOfGuru3.removeAllObjects()
                        self.userDataOfGuru4.removeAllObjects()
                        self.userDataOfGuru5.removeAllObjects()
                        for i in 0..<jobData!.count{
                            let jsonObject = jobData?[i]
                            if(jsonObject?.object(forKey: "main_group_id") as? String == "1"){
                                var guruTrackingMModel = guruTrackingModel()
                                guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                                guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                                guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                                guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                                self.userDataOfGuru1.add(guruTrackingMModel)
                            }else if(jsonObject?.object(forKey: "main_group_id") as? String == "2"){
                                var guruTrackingMModel = guruTrackingModel()
                                guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                                guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                                guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                                guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                                self.userDataOfGuru2.add(guruTrackingMModel)
                            }else if(jsonObject?.object(forKey: "main_group_id") as? String == "3"){
                                var guruTrackingMModel = guruTrackingModel()
                                guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                                guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                                guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                                guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                                self.userDataOfGuru3.add(guruTrackingMModel)
                            }else if(jsonObject?.object(forKey: "main_group_id") as? String == "4"){
                                var guruTrackingMModel = guruTrackingModel()
                                guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                                guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                                guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                                guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                                self.userDataOfGuru4.add(guruTrackingMModel)
                            }else if(jsonObject?.object(forKey: "main_group_id") as? String == "5"){
                                var guruTrackingMModel = guruTrackingModel()
                                guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                                guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                                guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                                guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                                self.userDataOfGuru5.add(guruTrackingMModel)
                            }
                        }
                        
                        
                        
                        /*if(indexpathOfSection == 0){
                            var userSwitchOnData = self.userDataOfGuru1[indexpathRow] as! guruTrackingModel
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = userSwitchOnData.mem_guru_id
                            guruTrackingMModel.main_group_id = userSwitchOnData.main_group_id
                            guruTrackingMModel.sub_group_id = userSwitchOnData.sub_group_id
                            guruTrackingMModel.mod = mod
                            
                            self.userDataOfGuru1.removeObject(at: indexpathRow)
                            self.userDataOfGuru1.insert(guruTrackingMModel, at:indexpathRow)
                        }else if(indexpathOfSection == 1){
                            var userSwitchOnData = self.userDataOfGuru2[indexpathRow] as! guruTrackingModel
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = userSwitchOnData.mem_guru_id
                            guruTrackingMModel.main_group_id = userSwitchOnData.main_group_id
                            guruTrackingMModel.sub_group_id = userSwitchOnData.sub_group_id
                            guruTrackingMModel.mod = mod
                            self.userDataOfGuru2.removeObject(at: indexpathRow)
                            self.userDataOfGuru2.insert(guruTrackingMModel, at:indexpathRow)
                            
                        }else if(indexpathOfSection == 2){
                            var userSwitchOnData = self.userDataOfGuru3[indexpathRow] as! guruTrackingModel
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = userSwitchOnData.mem_guru_id
                            guruTrackingMModel.main_group_id = userSwitchOnData.main_group_id
                            guruTrackingMModel.sub_group_id = userSwitchOnData.sub_group_id
                            guruTrackingMModel.mod = mod
                            self.userDataOfGuru3.removeObject(at: indexpathRow)
                            self.userDataOfGuru3.insert(guruTrackingMModel, at:indexpathRow)
                            
                        }else if(indexpathOfSection == 3){
                            var userSwitchOnData = self.userDataOfGuru4[indexpathRow] as! guruTrackingModel
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = userSwitchOnData.mem_guru_id
                            guruTrackingMModel.main_group_id = userSwitchOnData.main_group_id
                            guruTrackingMModel.sub_group_id = userSwitchOnData.sub_group_id
                            guruTrackingMModel.mod = mod
                            self.userDataOfGuru4.removeObject(at: indexpathRow)
                            self.userDataOfGuru4.insert(guruTrackingMModel, at:indexpathRow)
                            
                        }else if(indexpathOfSection == 4){
                            print("helloo---",mod)
                            var userSwitchOnData = self.userDataOfGuru5[indexpathRow] as! guruTrackingModel
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = userSwitchOnData.mem_guru_id
                            guruTrackingMModel.main_group_id = userSwitchOnData.main_group_id
                            guruTrackingMModel.sub_group_id = userSwitchOnData.sub_group_id
                            guruTrackingMModel.mod = mod
                            self.userDataOfGuru5.removeObject(at: indexpathRow)
                            self.userDataOfGuru5.insert(guruTrackingMModel, at:indexpathRow)
                            
                        }*/
                        
                        
                    let mapYes = json?.object(forKey: "mapYes") as? String;
                    if(mapYes == "no"){
                        
                    }else{
                        let jobData = json?.object(forKey: "map") as? [NSDictionary]
                        
                            self.markerData.removeAllObjects()
                            self.mainMapView.clear()
                        
                        for i in 0..<jobData!.count{
                            let jsonObject = jobData?[i]
                            var guruMarkModel = guruMarkerModel()
                            guruMarkModel.guru_name = jsonObject?.object(forKey: "guru_name") as? String
                            guruMarkModel.guru_contact = jsonObject?.object(forKey: "guru_contact") as? String
                            guruMarkModel.adithana = jsonObject?.object(forKey: "adithana") as? String
                            if(jsonObject?.object(forKey: "guru_latitude") as? String == nil || jsonObject?.object(forKey: "guru_latitude") as? String == "null" || jsonObject?.object(forKey: "guru_latitude") as? String == ""){
                                
                                guruMarkModel.guru_latitude = "0.0"
                            }else{
                                
                                guruMarkModel.guru_latitude = jsonObject?.object(forKey: "guru_latitude") as? String
                            }
                            
                            if(jsonObject?.object(forKey: "guru_longitude") as? String == nil || jsonObject?.object(forKey: "guru_longitude") as? String == "null" || jsonObject?.object(forKey: "guru_longitude") as? String == ""){
                                
                                guruMarkModel.guru_longitude = "0.0"
                            }else{
                                
                                guruMarkModel.guru_longitude = jsonObject?.object(forKey: "guru_longitude") as? String
                            }
                            self.markerData.add(guruMarkModel)
                            
                        }
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: Double(GlobalVariables.currentLat)!, longitude: Double(GlobalVariables.currentLong)!)
                        marker.title = String(describing: GlobalVariables.currentAddres)
                        marker.map = self.mainMapView
                        
                            for i in 0..<self.markerData.count{
                                var latAndLong = self.markerData[i] as! guruMarkerModel
                                let markerImage = UIImage(named: "d1-blue")!.withRenderingMode(.alwaysOriginal)
                                let markerView = UIImageView(image: markerImage)
                                markerView.tintColor = UIColor.red
                                let position = CLLocationCoordinate2D(latitude: Double(latAndLong.guru_latitude)!, longitude: Double(latAndLong.guru_longitude)!)
                                let london = GMSMarker(position: position)
                               // london.title = latAndLong.guru_name
                                // london.snippet = "\("Contact No. : "+latAndLong.guru_contact!)"
                                london.snippet = "\("GuruName".localized1+" : "+latAndLong.guru_name!) \n \("Adithana".localized1+" : "+latAndLong.adithana!)"
                                london.iconView = markerView
                                london.map = self.mainMapView
                            }
                    
                    }
                }
                }else{
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
    
    func loadLocation(){
        //GMSServices.provideAPIKey(GlobalVariables.GoogleMapsKey)
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
    
    @objc func gotoFullPageMap(_ sender : UITapGestureRecognizer){
        
        let fullPageMap = storyboard?.instantiateViewController(withIdentifier: "FullPageMapIdentifier") as! ShowFullMapCntr
        fullPageMap.which = "GuruTracking"
        fullPageMap.dataOnMap = markerData
        navigationController?.pushViewController(fullPageMap, animated: true)
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
        self.mainMapView.camera = camera
        
        
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
                //let p = CLPlacemark(placemark:p0)
                
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
                        print("locality---",pm.locality!)
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print("current Addre---",addressString)
                    
                    GlobalVariables.currentAddres = addressString
                }
                
                
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                marker.title = String(describing: GlobalVariables.currentAddres)
                //marker.snippet = String(describing: p.country)
                marker.map = self.mainMapView
                
                //self.updatePostion(lat: self.lat.description, lon: self.lng.description)
                //self.adsresslabel.text = "\(p.administrativeArea)\(p.postalCode)\(p.country)"
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        }else{
            print("Locaiton manager nilll")
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
    
    
    func getSwitchUserOnData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.post_guru_tracking)!
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
                if (Status == "Success")
                {
                    
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
                        if(jsonObject?.object(forKey: "main_group_id") as? String == "1"){
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                            guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                            guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                            guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                            self.userDataOfGuru1.add(guruTrackingMModel)
                        }else if(jsonObject?.object(forKey: "main_group_id") as? String == "2"){
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                            guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                            guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                            guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                            self.userDataOfGuru2.add(guruTrackingMModel)
                        }else if(jsonObject?.object(forKey: "main_group_id") as? String == "3"){
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                            guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                            guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                            guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                            self.userDataOfGuru3.add(guruTrackingMModel)
                        }else if(jsonObject?.object(forKey: "main_group_id") as? String == "4"){
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                            guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                            guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                            guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                            self.userDataOfGuru4.add(guruTrackingMModel)
                        }else if(jsonObject?.object(forKey: "main_group_id") as? String == "5"){
                            var guruTrackingMModel = guruTrackingModel()
                            guruTrackingMModel.mem_guru_id = jsonObject?.object(forKey: "mem_guru_id") as? String
                            guruTrackingMModel.main_group_id = jsonObject?.object(forKey: "main_group_id") as? String
                            guruTrackingMModel.sub_group_id = jsonObject?.object(forKey: "sub_group_id") as? String
                            guruTrackingMModel.mod = jsonObject?.object(forKey: "mod") as? String
                            self.userDataOfGuru5.add(guruTrackingMModel)
                        }
                    }
                    
                    DispatchQueue.main.async {
                       
                        self.getGuruData()
                    }
                }else if(Status == "fail"){
                    DispatchQueue.main.async {
                         self.hideActivityIndicator()
                        self.getGuruData()
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
    
    
    func getMarkerData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.guru_tracking)!
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
//                let Status = json?.object(forKey: "message") as? String;
//                if (Status == "Success")
//                {
                print("guru json--",json)
                let message : String =  json?.object(forKey: "message") as! String
                if (message == "success")
                {
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
                        var guruMarkModel = guruMarkerModel()

                        guruMarkModel.guru_name = jsonObject?.object(forKey: "guru_name") as? String
                        guruMarkModel.guru_contact = jsonObject?.object(forKey: "guru_contact") as? String
                        guruMarkModel.adithana = jsonObject?.object(forKey: "adithana") as? String
                        
                        
                        if(jsonObject?.object(forKey: "guru_latitude") as? String == nil || jsonObject?.object(forKey: "guru_latitude") as? String == "null" || jsonObject?.object(forKey: "guru_latitude") as? String == ""){
                            
                            guruMarkModel.guru_latitude = "0.0"
                        }else{
                            
                            guruMarkModel.guru_latitude = jsonObject?.object(forKey: "guru_latitude") as? String
                        }
                        
                        if(jsonObject?.object(forKey: "guru_longitude") as? String == nil || jsonObject?.object(forKey: "guru_longitude") as? String == "null" || jsonObject?.object(forKey: "guru_longitude") as? String == ""){
                            
                            guruMarkModel.guru_longitude = "0.0"
                        }else{
                            
                            guruMarkModel.guru_longitude = jsonObject?.object(forKey: "guru_longitude") as? String
                        }
                        
                        self.markerData.add(guruMarkModel)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        for i in 0..<self.markerData.count{
                            
                            var latAndLong = self.markerData[i] as! guruMarkerModel
                            let markerImage = UIImage(named: "d1-blue")!.withRenderingMode(.alwaysOriginal)
                            let markerView = UIImageView(image: markerImage)
                            markerView.tintColor = UIColor.red
                            let position = CLLocationCoordinate2D(latitude: Double(latAndLong.guru_latitude)!, longitude: Double(latAndLong.guru_longitude)!)
                            let london = GMSMarker(position: position)
                            //london.title = latAndLong.guru_name
                            // london.snippet = "\("Contact No. : "+latAndLong.guru_contact!)"
                           // london.snippet = "\("ContactNumber".localized1+" : "+latAndLong.guru_contact!) \n \("Adithana".localized1+" : "+latAndLong.adithana!)"
                            london.snippet = "\("GuruName".localized1+" : "+latAndLong.guru_name!) \n \("Adithana".localized1+" : "+latAndLong.adithana!)"
                            // london.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                            london.iconView = markerView
                            //london.icon = UIImage(named: "d2-blue")
                            london.map = self.mainMapView
                            
                        }
                        
                    }
                }else{
                    
                }
                
                
                    
                    
               // }
//                else{
//                    DispatchQueue.main.async {
//                        self.hideActivityIndicator()
//
//                    }
//                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getGuruData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_guru_data)!
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
                        self.hideActivityIndicator()
                    self.note = (json?.object(forKey: "note") as? String)!
                    self.note_color = (json?.object(forKey: "note_color") as? String)!
                    self.note_font_color = (json?.object(forKey: "note_font_color") as? String)!
                        
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        let groupName = jsonObject?.object(forKey: "group_name") as? String
                        self.sections.append(groupName!)
                        var subgroupName = [String]()
                        var subgroupId = [String]()
                        let sub_group_data = jsonObject?.object(forKey: "sub_group_data") as? [NSDictionary]
                        
                        for j in 0..<sub_group_data!.count{
                             let subGroupData = sub_group_data?[j]
                             let sub_group_name = subGroupData?.object(forKey: "sub_group_name") as? String
                             subgroupName.append(sub_group_name!)
                             let sub_group_id = subGroupData?.object(forKey: "sub_group_id") as? String
                             subgroupId.append(sub_group_id!)
                        }
                        self.subGroupNameitems.append(subgroupName)
                        self.subGroupitemsId.append(subgroupId)
                    }
                    
                        self.lblNote.text = self.note
                        let greet4Height = self.lblNote.optimalHeight
                        self.lblNote.frame = CGRect(x:8,y:8,width:self.noteBackground.frame.width-16,height:greet4Height)
                        self.lblNote.lineBreakMode = .byWordWrapping
                        self.lblNote.numberOfLines = 0
                        self.noteBackground.backgroundColor = UIColor.rgb(hexcolor: self.note_color)
                        self.lblNote.textColor = UIColor.rgb(hexcolor: self.note_font_color)
                        self.noteBackground.addSubview(self.lblNote)
                        self.guruTrackingTable.reloadData()
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
    
 
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//         let indexPath1 = IndexPath(row: 5, section: 0)
//        let index = indexPath1.row as Int
//
//        if(index > 5){
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
//                if(noteTopHeight.constant == 285){
//
//                }else{
//                    print("bottom----")
//                    self.mainMapView.alpha = 1
//                    noteTopHeight.constant = 285
//                    tableTopHeight.constant = 350
//                    view.layoutIfNeeded()
//                    scrolledAlready = false
//                }
//            }else{
//
//            }
//        }
//        else {
//            if(scrolledAlready == false){
//                if(noteTopHeight.constant == 10){
//
//                }else{
//                    print("toppppp----")
//                    self.mainMapView.alpha = 0
//                    noteTopHeight.constant = 10
//                    tableTopHeight.constant = 10
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
