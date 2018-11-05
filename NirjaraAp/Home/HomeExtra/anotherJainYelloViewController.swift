//
//  anotherJainYelloViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/13/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit


class anotherJainYelloViewController: UIViewController,UISearchBarDelegate,citySelected,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    

    //var searchResultController: SearchResultsController!
    var seacrhCity : CityResultCntr!
   // var searchResultBusinessCntr: SearchResultCntrForBusiness!
    var resultsArray = [String]()
    let uisearchBar = UISearchBar()
    @IBOutlet weak var btnsearchicon: UIButton!
    @IBOutlet weak var SearchView: UIView!
    
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var txtWhich: UITextField!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    @IBOutlet weak var btnSearchBusiness: UIButton!
    @IBOutlet weak var SearchBusinessTableView: UITableView!
    var whichSearch = String()
    var businessId = String()
    var newAddress = String()
    var businessFullDetail : NSMutableArray = NSMutableArray()
    //var businessCatDetail : NSMutableArray = NSMutableArray()
    
       // var charturmasName = ["Sadhumargi smapraday","Sri Gondil Paksh Sampraday","Sri Gondil Paksh Sampraday","Sri Gondil Paksh Sampraday","Sri Gondil Paksh Sampraday","Sri Gondil Paksh Sampraday"]

   //var pastUrls = ["Men", "Women", "Cats", "Dogs", "Children"]
   var autocompleteUrls = [String]()
   var autocompleteForCatgeory = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jain Yellow Pages(Business)"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:14))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:14,length:15))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
       
        
        seacrhCity = CityResultCntr()
        seacrhCity.delegate = self
        
        //searchResultBusinessCntr = SearchResultCntrForBusiness()
        //searchResultBusinessCntr.delegate = self
        
        //txtWhich.delegate = self
        
        //GMSPlacesClient.provideAPIKey(GlobalVariables.GoogleMapsKey)
        
        //SearchView.frame = CGRect(x:0,y:75,width:self.view.frame.width,height:70)
        SearchView.backgroundColor = UIColor.white
        SearchView.layer.borderColor = UIColor.rgb(hexcolor: "#5c2d91").cgColor
        //btnsearchicon.frame = CGRect(x:10,y:10,width:self.SearchView.frame.width-20,height:50)
        
        var buttonString1 = String.fontAwesomeString(name: "fa-search")+" "+GlobalVariables.TempleState
        var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
        
        btnsearchicon.titleLabel?.textAlignment = .left
        btnsearchicon.titleLabel?.textColor = UIColor.black
        btnsearchicon.setAttributedTitle(buttonStringAttributed1, for: .normal)
        
       // SearchView.addSubview(btnsearchicon)
        
        //txtWhich.placeholder = whichSearch
        /*textView.frame = CGRect(x:0,y:SearchView.frame.origin.y+SearchView.frame.height+10,width:self.view.frame.width,height:70)
        txtWhich.frame = CGRect(x:10,y:15,width:self.textView.frame.width-20,height:50)
        textView.addSubview(txtWhich)
        txtWhich.alpha = 0*/
        //btnSearchBusiness.frame = CGRect(x:10,y:10,width:self.textView.frame.width-20,height:50)
        
        var buttonString2 = String.fontAwesomeString(name: "fa-search")+" "+whichSearch
        var buttonStringAttributed2 = NSMutableAttributedString(string: buttonString2, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
        
        buttonStringAttributed2.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
        
        buttonStringAttributed2.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
        
        btnSearchBusiness.titleLabel?.textAlignment = .left
        btnSearchBusiness.titleLabel?.textColor = UIColor.black
        btnSearchBusiness.setAttributedTitle(buttonStringAttributed2, for: .normal)
        btnSearchBusiness.addTarget(self, action: #selector(btnSearchBusinessClicked(_:)), for: UIControlEvents.touchUpInside)
        SearchBusinessTableView.separatorStyle = .none
        //textView.addSubview(btnSearchBusiness)
        //lblNoRecord.frame = CGRect(x:0,y:textView.frame.origin.y+textView.frame.height+10,width:self.view.frame.width,height:25)
        
        /*SearchBusinessTableView.translatesAutoresizingMaskIntoConstraints = false
        SearchBusinessTableView.separatorStyle = .none
        view.addConstraint(NSLayoutConstraint(item: SearchBusinessTableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10))
        
        view.addConstraint(NSLayoutConstraint(item: SearchBusinessTableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: SearchBusinessTableView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .top, multiplier: 1, constant: textView.frame.origin.y+textView.frame.height+15))
        
        view.addConstraint(NSLayoutConstraint(item: SearchBusinessTableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom,multiplier: 1, constant: -50))
        
        self.SearchBusinessTableView.delegate = self
        self.SearchBusinessTableView.dataSource = self
        
        self.view.addSubview(SearchBusinessTableView)*/
    

        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //view.addGestureRecognizer(tap)
        
        
        self.SearchBusinessTableView.alpha = 0
        self.lblNoRecord.alpha = 0
        
       
        self.newAddress = GlobalVariables.TempleState
        businessFullDetail.removeAllObjects()
        
        if isConnectedToNetwork() {
            if(GlobalVariables.cityName.count > 0){
                
            }else{
                getCity()
            }
            if(GlobalVariables.business_cat_id.count > 0){
                
            }else{
                getBusinessCategory()
            }
            
            if(self.btnsearchicon.currentTitle==""){
                
            }else if(self.btnSearchBusiness.currentTitle==""){
                
            }
            else{
            getBusinessData(strBusinessId: businessId)
            }
        }else{
            
        }
        
        // Do any additional setup after loading the view.
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
    
    func getBusinessCategory(){
        
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_business_cat)!
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
                        
                        
                        let busCatId = jsonObject?.object(forKey: "business_cat_id") as? String
                        let busCatName = jsonObject?.object(forKey: "business_category") as? String
                       
                        GlobalVariables.business_cat_id.append(busCatId!)
                        GlobalVariables.business_category.append(busCatName!)
                        
                    }
                    
                    DispatchQueue.main.async {
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
    
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        SearchBusinessTableView.isHidden = false
        var substring = (textField.text as! NSString).replacingCharacters(in: range, with: string)

        searchAutocompleteEntriesWithSubstring(substring: substring)
        print("substring--",substring)
        return true     // not sure about this - could be false
    }*/

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
        //SearchBusinessTableView.reloadData()
    }
    func searchAutocompleteCategory(substring: String)
    {
        autocompleteForCatgeory.removeAll(keepingCapacity: false)
        for curString in GlobalVariables.business_category
        {
            var myString:NSString! = curString as NSString
            
            var substringRange :NSRange! = myString.range(of: substring)
            
            if (substringRange.location  == 0)
            {
                autocompleteForCatgeory.append(curString)
            }
        }
        //SearchBusinessTableView.reloadData()
    }
    
   /* func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async { () -> Void in
            
            print("Hellooooo--",title)
            
            var delimiter = " "
            var newstr = title
            var token = newstr.components(separatedBy: delimiter)
            var agetext = String(describing: token[0])
            agetext = agetext.replacingOccurrences(of: ",", with: "")
            
            self.newAddress = agetext
            var buttonString1 = String.fontAwesomeString(name: "fa-search") + " "+title
            var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
            
            buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
            
            buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
            
            self.btnsearchicon.titleLabel?.textAlignment = .left
            self.btnsearchicon.titleLabel?.textColor = UIColor.black
            self.btnsearchicon.setAttributedTitle(buttonStringAttributed1, for: .normal)
            //self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }

    }*/
    
    
    func searchCityResult(searchSelectedResult: String,which : String) {
        DispatchQueue.main.async { () -> Void in
            if(which == "0"){
                self.whichSearch = searchSelectedResult
                var buttonString1 = String.fontAwesomeString(name: "fa-search") + " "+searchSelectedResult
                var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
                
                buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
                
                buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
                
                self.btnSearchBusiness.titleLabel?.textAlignment = .left
                self.btnSearchBusiness.titleLabel?.textColor = UIColor.black
                self.btnSearchBusiness.setAttributedTitle(buttonStringAttributed1, for: .normal)
                
                
                if(self.btnsearchicon.currentTitle==""){
                    
                }else{
                    if(searchSelectedResult == "See More"){
                        self.view.makeToast("Please search for Business", duration: 2.0, position: .top)
                    }else{
                let indexofdesName = GlobalVariables.business_category.index(of: searchSelectedResult)
                let businesSelectId  =  GlobalVariables.business_cat_id[indexofdesName!]
                self.getBusinessData(strBusinessId: businesSelectId)
                    }
                }
            }else{
            self.newAddress = searchSelectedResult
            var buttonString1 = String.fontAwesomeString(name: "fa-search") + " "+searchSelectedResult
            var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
            
            buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
            
            buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
            
            self.btnsearchicon.titleLabel?.textAlignment = .left
            self.btnsearchicon.titleLabel?.textColor = UIColor.black
            self.btnsearchicon.setAttributedTitle(buttonStringAttributed1, for: .normal)
                print("currentitl---"+self.whichSearch)
                if(self.whichSearch==""){
                    
                }else{
                    if(self.whichSearch == "See More"){
                        self.view.makeToast("Please search for Business", duration: 2.0, position: .top)
                    }else{
                let indexofdesName = GlobalVariables.business_category.index(of: self.whichSearch)
                let businesSelectId  =  GlobalVariables.business_cat_id[indexofdesName!]
                self.getBusinessData(strBusinessId: businesSelectId)
                    }
                }
            }
        }
    }
    
    
  /*  func locateWithAddress(searchSelectedResult: String,searchCatId : String) {
        
        var buttonString1 = String.fontAwesomeString(name: "fa-search") + " "+searchSelectedResult
        var buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16)!])
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 20), range: NSRange(location: 0,length: 1))
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
        
        self.btnSearchBusiness.titleLabel?.textAlignment = .left
        self.btnSearchBusiness.titleLabel?.textColor = UIColor.black
        self.btnSearchBusiness.setAttributedTitle(buttonStringAttributed1, for: .normal)
    
        getBusinessData(strBusinessId: searchCatId)
    }*/
    
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessFullDetail.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchBusinessTableView.dequeueReusableCell(withIdentifier: "searchBusinesIdentifier") as! SearchBusinessCell
        
        let index = indexPath.row as Int
        
        let businessDat = businessFullDetail[index] as! businessDetailModel
        
        cell.mainView.frame = CGRect(x:SearchBusinessTableView.frame.origin.x+5,y:10,width:self.SearchBusinessTableView.frame.width-30,height:174)
        cell.imgUserIcon.frame = CGRect(x:10,y:10,width:30,height:30)
        cell.mainView.layer.borderColor = UIColor.rgb(hexcolor: GlobalVariables.orangeColor).cgColor
        cell.mainView.layer.borderWidth = 0.5
        cell.selectionStyle = .none
        
        cell.imgPackageIcon.frame = CGRect(x:cell.mainView.frame.width-45,y:10,width:40,height:40)
        
        if(businessDat.package_id == "3"){
            let image : UIImage = UIImage(named: "gold")!
            cell.imgPackageIcon.image = image
        }else  if(businessDat.package_id == "4"){
            let image : UIImage = UIImage(named: "silver")!
            cell.imgPackageIcon.image = image
        }else  if(businessDat.package_id == "2"){
            let image : UIImage = UIImage(named: "silver")!
            cell.imgPackageIcon.image = image
        }
        
        cell.lblName.frame = CGRect(x:45,y:10,width:cell.mainView.frame.width-120,height:30)
        cell.lblName.text = businessDat.business_owner_name
        cell.separaterView.frame = CGRect(x:0,y:cell.imgPackageIcon.frame.origin.y+cell.imgPackageIcon.frame.height+5,width:self.SearchBusinessTableView.frame.width-30,height:1)
        
        
        cell.imgLocationIcon.frame = CGRect(x:17,y:cell.separaterView.frame.origin.y+cell.separaterView.frame.height+5,width:13,height:15)
        cell.lblLocation.frame = CGRect(x:40,y:cell.separaterView.frame.origin.y+cell.separaterView.frame.height,width:view.frame.width-120,height:30)
        cell.lblLocation.text = "At Post. "+businessDat.address
       
        cell.imgMobileIcon.frame = CGRect(x:17,y:cell.imgLocationIcon.frame.origin.y+cell.imgLocationIcon.frame.height+20,width:13,height:15)
        cell.lblMobile.frame = CGRect(x:40,y:cell.imgLocationIcon.frame.origin.y+cell.imgLocationIcon.frame.height+15,width:view.frame.width-120,height:30)
        cell.lblMobile.text = businessDat.contact_no
        
        cell.lblProduct.frame = CGRect(x:10,y:cell.lblMobile.frame.origin.y+cell.lblMobile.frame.height+10,width:view.frame.width-120,height:30)
        //cell.lblProduct.text = charturmasName[indexPath.row]
        
        let From = businessDat.product1
        let FromText  = "Product : "
        let attrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        var boldStringFrom = NSMutableAttributedString(string: FromText, attributes:attrsFrom)
        let attributedStringFrom = NSMutableAttributedString(string:From!)
        boldStringFrom.append(attributedStringFrom)
        cell.lblProduct?.attributedText = boldStringFrom
        
        
        
        cell.mainView.addSubview(cell.lblName)
        cell.mainView.addSubview(cell.imgUserIcon)
        cell.mainView.addSubview(cell.imgPackageIcon)
        cell.mainView.addSubview(cell.separaterView)
        cell.mainView.addSubview(cell.imgLocationIcon)
        cell.mainView.addSubview(cell.imgMobileIcon)
        cell.mainView.addSubview(cell.lblMobile)
        cell.mainView.addSubview(cell.lblProduct)
        
//        cell.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.lightgray).cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cell.layer.shadowOpacity = 1
//        cell.layer.shadowRadius = 0
//        cell.layer.masksToBounds = false
        return cell
    }
    
    @IBAction func btnSearchLocationClicked(_ sender: Any) {
        let controller = UISearchController(searchResultsController: seacrhCity)
        controller.searchBar.delegate = self
        controller.searchBar.tag = 1
        self.present(controller, animated:true, completion: nil)
    }
    
    @objc func btnSearchBusinessClicked(_ sender: UIButton) {
        let controller = UISearchController(searchResultsController: seacrhCity)
        controller.searchBar.delegate = self
        controller.searchBar.tag = 0
        self.present(controller, animated:true, completion: nil)
    }
    
   /* func filterDataFromServer(searchText : String){
        let  parameters = "lang=\(GlobalVariables.selectedLanguage)&q=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
        let url = URL(string: ServerUrl.get_business_cat_search)! //change the url
        print(url)
        print(parameters)
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        self.showActivityIndicator()
        
        do {
            request.httpBody = parameters.data(using: String.Encoding.utf8)
        }
        //
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                // print(json)
                let Status = json?.object(forKey: "message") as? String;
                
                
                if (Status == "success")
                {
                    
                    let data = json?.object(forKey: "result") as? [NSDictionary]
                    
                    for i in 0..<data!.count{
                        
                        let jsonObject = data![i]
                        var businessData = businessCatModel()
                        businessData.business_cat_id = jsonObject.object(forKey: "business_cat_id") as? String
                        businessData.business_category = jsonObject.object(forKey: "business_category") as? String
                        self.businessCatDetail.add(businessData)
                        
                    }
                    DispatchQueue.main.async {
                        self.searchResultBusinessCntr.reloadDataWithArray(self.businessCatDetail)
                        self.hideActivityIndicator()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       //self.showAlert(title: "No Search Found", message: "As per this Business Category")
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }*/
    
    
    func getBusinessData(strBusinessId : String){
        
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&business_cat_id=\(strBusinessId)&city=\(self.newAddress)"
       
        print("paramerts=--",parameters)
        let url = URL(string:ServerUrl.get_businessowner_url)!
        print("url=--",url)
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
                     self.businessFullDetail.removeAllObjects()
                    
                    
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
                        
                        var businessDetailData = businessDetailModel()
                        businessDetailData.business_id = jsonObject?.object(forKey: "business_id") as? String
                        businessDetailData.business_cat_id = jsonObject?.object(forKey: "business_cat_id") as? String
                        businessDetailData.package_id = jsonObject?.object(forKey: "package_id") as? String
                        businessDetailData.business_owner_name = jsonObject?.object(forKey: "business_owner_name") as? String
                        businessDetailData.business_title = jsonObject?.object(forKey: "business_title") as? String
                        businessDetailData.business_description = jsonObject?.object(forKey: "business_description") as? String
                        businessDetailData.country = jsonObject?.object(forKey: "country") as? String
                        businessDetailData.state = jsonObject?.object(forKey: "state") as? String
                        businessDetailData.city = jsonObject?.object(forKey: "city") as? String
                        businessDetailData.address = jsonObject?.object(forKey: "address") as? String
                        businessDetailData.contact_no = jsonObject?.object(forKey: "contact_no") as? String
                        businessDetailData.image = jsonObject?.object(forKey: "image") as? String
                        businessDetailData.product1 = jsonObject?.object(forKey: "product1") as? String
                        businessDetailData.product2 = jsonObject?.object(forKey: "product2") as? String
                        businessDetailData.product3 = jsonObject?.object(forKey: "product3") as? String
                        businessDetailData.product4 = jsonObject?.object(forKey: "product4") as? String
                        businessDetailData.reference_code = jsonObject?.object(forKey: "reference_code") as? String
                        
                        self.businessFullDetail.add(businessDetailData)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.SearchBusinessTableView.alpha = 1
                        self.lblNoRecord.alpha = 0
                        self.SearchBusinessTableView.reloadData()
                        
                    }
                }
                else if(Status == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.SearchBusinessTableView.alpha = 0
                        self.lblNoRecord.alpha = 1
                        
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        //self.hideActivityIndicator()
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let businessDetail = storyboard?.instantiateViewController(withIdentifier: "businessDetailIdentifier") as! BusinessDetailCntr
        businessDetail.businessFullDetail = businessFullDetail[indexPath.row] as! businessDetailModel
        self.navigationController?.pushViewController(businessDetail, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchBar.tag == 0){
           
            //filterDataFromServer(searchText: searchText)
           // self.searchResultBusinessCntr.reloadDataWithArray(self.businessCatDetail)
            searchAutocompleteCategory(substring: searchText)
            self.seacrhCity.reloadDataWithArray(self.autocompleteForCatgeory,which: "0")
            
        }else{
            searchAutocompleteEntriesWithSubstring(substring: searchText)
            self.seacrhCity.reloadDataWithArray(self.autocompleteUrls,which: "1")
            
        /*self.resultsArray.removeAll()
        let placeClient = GMSPlacesClient()
        
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
            //NSError myerr = Error
            print("Error @%",error)
            
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            
            self.searchResultController.reloadDataWithArray(self.resultsArray)
            
        }*/
            
      }
        
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
