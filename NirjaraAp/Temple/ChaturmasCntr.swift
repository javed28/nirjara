//
//  ChaturmasCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ChaturmasCntr: UIViewController,UITableViewDelegate,UITableViewDataSource,citySelected,UISearchBarDelegate{
    func searchCityResult(searchSelectedResult: String, which: String) {
        DispatchQueue.main.async { () -> Void in
            
                let buttonString1 = String.fontAwesomeString(name: "fa-search") + " "+searchSelectedResult
                let buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
            
                buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
            
                buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
            
                self.btnSearch.titleLabel?.textAlignment = .left
                self.btnSearch.titleLabel?.textColor = UIColor.black
                self.btnSearch.setAttributedTitle(buttonStringAttributed1, for: .normal)
            
            if(self.btnSearch.currentTitle==""){
                
            }else if(self.btnSearch.currentTitle=="No Location"){
                
            }
            else{
                self.chaturmasData.removeAllObjects()
                self.chaturmasTable.reloadData()
                   var parameters = "location=\(self.btnSearch.currentTitle)&lang=\(GlobalVariables.selectedLanguage)"
                   self.getChaturmasData(location: parameters)
            }
        }
    }
    
   
    @IBOutlet weak var chaturmasTable: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var chaturmasData : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    var seacrhCity : CityResultCntr!
    var autocompleteUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Chaturmas 2018"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:12))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:12,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        chaturmasTable.separatorStyle = .none
       /* if isConnectedToNetwork() {
        if(GlobalVariables.cityName.count > 0){
            
        }else{
            getCity()
        }
        }else{
            
        }*/
        seacrhCity = CityResultCntr()
        seacrhCity.delegate = self
        addShadowToBar()
        sideMenu()
        // Do any additional setup after loading the view.
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchAutocompleteEntriesWithSubstring(substring: searchText)
        self.seacrhCity.reloadDataWithArray(self.autocompleteUrls,which: "1")
    }
    func searchAutocompleteEntriesWithSubstring(substring: String)
    {
        autocompleteUrls.removeAll(keepingCapacity: false)
        for curString in GlobalVariables.cityName
        {
            var myString:NSString! = curString as NSString
            
            var substringRange :NSRange! = myString.range(of: substring)
            
            if (substringRange.location  == 0)
            {
                autocompleteUrls.append(curString)
            }
        }
    }
    
    @objc func btnSearchBusinessClicked(_ sender: UIButton) {
        let controller = UISearchController(searchResultsController: seacrhCity)
        controller.searchBar.delegate = self
        controller.searchBar.tag = 0
        self.present(controller, animated:true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
    
        if isConnectedToNetwork() {
            
            chaturmasData.removeAllObjects()
            chaturmasTable.reloadData()
            self.lblNoRecord.alpha = 0
            self.chaturmasTable.alpha = 0
            var buttonString2 = String()
            if(UserDefaults.standard.isKeyPresentInUserDefaults(key : "lastAddress")){
                buttonString2 = String.fontAwesomeString(name: "fa-search")+" "+UserDefaults.standard.getLastAddress()
            }else{
                buttonString2 = String.fontAwesomeString(name: "fa-search")+" No Location"
            }
            let buttonStringAttributed2 = NSMutableAttributedString(string: buttonString2, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
            
            buttonStringAttributed2.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
            
            buttonStringAttributed2.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
            
            btnSearch.titleLabel?.textAlignment = .left
            btnSearch.titleLabel?.textColor = UIColor.black
            btnSearch.setAttributedTitle(buttonStringAttributed2, for: .normal)
            btnSearch.addTarget(self, action: #selector(btnSearchBusinessClicked(_:)), for: UIControlEvents.touchUpInside)
            
            
        
            var parameters = String()
            if(UserDefaults.standard.isKeyPresentInUserDefaults(key : "lastAddress")){
                parameters = "location=\(UserDefaults.standard.getLastAddress())&lang=\(GlobalVariables.selectedLanguage)"
                getChaturmasData(location: parameters)
            }else{
               
            }
        }else{
            
        }
           /* if(self.btnSearch.currentTitle==""){
         
            }else if(self.btnSearch.currentTitle=="No Location"){
         
            }
            else{
                chaturmasData.removeAllObjects()
                chaturmasTable.reloadData()
                var parameters = String()
                if(UserDefaults.standard.isKeyPresentInUserDefaults(key : "lastAddress")){
                    parameters = "location=\(UserDefaults.standard.getLastAddress())&lang=\(GlobalVariables.selectedLanguage)"
                    self.btnSearch.setTitle(UserDefaults.standard.getLastAddress(), for: .normal)
                    getChaturmasData(location: parameters)
                }else{
                    parameters = "location=NoData&lang=\(GlobalVariables.selectedLanguage)"
                    self.btnSearch.setTitle("No Location", for: .normal)
                }
            }
        */
    }
    func getCity(){
        let parameters = "key=city&state_id="
        let url = URL(string:ServerUrl.commen_function)!
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
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        let city_id = jsonObject?.object(forKey: "city_id") as? String
                        let city_name = jsonObject?.object(forKey: "city_name") as? String
                        GlobalVariables.cityId.append(city_id!)
                        GlobalVariables.cityName.append(city_name!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        //self.txtCity.filterStrings(self.cityName)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chaturmasData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chaturmasTable.dequeueReusableCell(withIdentifier: "chaturmasIdentifier", for:indexPath) as? ShowChaturmasTableViewCell
        
    
        var chaturmasMModel = chaturmasData[indexPath.row] as! chaturmasModel
        cell?.selectionStyle = .none
        cell?.lblChaturName.text = chaturmasMModel.sub_group
        cell?.lblChaturDetail.text = chaturmasMModel.guru_name
        cell?.lblChaturMobile.text = chaturmasMModel.contact_number
        cell?.lblChaturAddress.text = chaturmasMModel.location
        /*cell?.lblChaturMobile.setFAText(prefixText: "", icon: .FAMobile, postfixText: " "+chaturmasMModel.contact_number, size: 15)
        cell?.lblChaturAddress.setFAText(prefixText: "", icon: .FALocationArrow, postfixText: " "+chaturmasMModel.location, size: 15)
        cell?.lblChaturMobile.setFAColor(color: UIColor.rgb(hexcolor: "#FF9800"))
        cell?.lblChaturMobile.setFAColor(color: UIColor.rgb(hexcolor: "#FF9800"))*/
        
        cell?.mainView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:158)
        
        cell?.mainView.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell?.lblChaturName.frame = CGRect(x:10,y:10,width:self.view.frame.width-40,height:25)
        cell?.lblChaturDetail.numberOfLines = 2
        cell?.lblChaturDetail.lineBreakMode = .byWordWrapping;
        cell?.lblChaturDetail.frame = CGRect(x:10,y:40,width:self.view.frame.width-45,height:40)
        cell?.imgMobile.frame = CGRect(x:10,y:90,width:12,height:15)
        cell?.imgLocation.frame = CGRect(x:10,y:120,width:12,height:15)
        cell?.lblChaturMobile.frame = CGRect(x:30,y:85,width:self.view.frame.width-40,height:25)
        cell?.lblChaturAddress.frame = CGRect(x:30,y:115,width:self.view.frame.width-40,height:25)
        
        
        cell?.mainView.addSubview((cell?.lblChaturName)!)
        cell?.mainView.addSubview((cell?.lblChaturDetail)!)
        cell?.mainView.addSubview((cell?.imgMobile)!)
        cell?.mainView.addSubview((cell?.imgLocation)!)
        cell?.mainView.addSubview((cell?.lblChaturMobile)!)
        cell?.mainView.addSubview((cell?.lblChaturAddress)!)
        cell?.mainView.dropShadow(color: UIColor.rgb(hexcolor: "#A8A8A8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "ChaturmasDetailIdentifier", sender: self)
        var chaturData = self.chaturmasData[indexPath.row] as? chaturmasModel
        showAlert(title: (chaturData?.sub_group)!, message: (chaturData?.guru_name)!)
    }
    
    func getChaturmasData(location : String){
        let parameters = location
        let url = URL(string:ServerUrl.get_chaturmas_location_wise)!
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
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var chaturmasMModel = chaturmasModel()
                        
                        chaturmasMModel.guru_name = jsonObject?.object(forKey: "guru_name") as? String
                        chaturmasMModel.sub_group = jsonObject?.object(forKey: "sub_group") as? String
                        if(jsonObject?.object(forKey: "contact_number") as? String == ""){
                             chaturmasMModel.contact_number = "Number Not Available"
                        }else{
                            chaturmasMModel.contact_number = jsonObject?.object(forKey: "contact_number") as? String
                        }
                       
                        chaturmasMModel.location = jsonObject?.object(forKey: "location") as? String
                        self.chaturmasData.add(chaturmasMModel)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chaturmasTable.reloadData()
                        self.lblNoRecord.alpha = 0
                        self.chaturmasTable.alpha = 1
                        
                    }
                }else if(Status == "fail"){
                     DispatchQueue.main.async {
                         self.hideActivityIndicator()
                    self.lblNoRecord.alpha = 1
                    self.chaturmasTable.alpha = 0
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 0
                        self.chaturmasTable.alpha = 0
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
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
