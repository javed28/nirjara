//
//  PostBusinessCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import SearchTextField
import JHTAlertController

class PostBusinessCntr: UIViewController {

    
    var whichPackage = String()
    var packageId = String()
    
    //var business_cat_id = [String]()
    //var business_category = [String]()
    
    @IBOutlet weak var lblPackage: UILabel!
    @IBOutlet weak var txtPackage: UITextField!
    @IBOutlet weak var lblBusinessCat: UILabel!
    @IBOutlet weak var btnBusinessCat: UIButton!

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var txtProduct: UITextField!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var lblReferralCode: UILabel!
    @IBOutlet weak var txtReferralCode: UITextField!

    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var lblState: UILabel!
   
    @IBOutlet weak var lblCity: UILabel!
    

    let chooseArticleDropDown = DropDown()
    let chooseState = DropDown()
    let chooseCity = DropDown()
    var cityId = [String]()
    var cityName = [String]()
    
    var containerController: ContainerViewController?
    
   
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Business Information"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:11))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
       self.updateBackButton()
        containerController = revealViewController().frontViewController as? ContainerViewController
        
        lblPackage.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        txtPackage.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:50)
        txtPackage.text = whichPackage
        lblPackage.text = "Package".localized1
        txtPackage.placeholder = "Package".localized1
        lblBusinessCat.frame = CGRect(x:10,y:txtPackage.frame.origin.y+txtPackage.frame.height+10,width:self.view.frame.width-20,height:25)
        btnBusinessCat.frame = CGRect(x:10,y:lblBusinessCat.frame.origin.y+lblBusinessCat.frame.height+10,width:self.view.frame.width-20,height:50)
        lblBusinessCat.text = "BusinessCategory".localized1
        
        lblTitle.frame = CGRect(x:10,y:btnBusinessCat.frame.origin.y+btnBusinessCat.frame.height+10,width:self.view.frame.width-20,height:25)
        txtTitle.frame = CGRect(x:10,y:lblTitle.frame.origin.y+lblTitle.frame.height+10,width:self.view.frame.width-20,height:50)
        lblTitle.text = "Title".localized1
        txtTitle.placeholder = "Title".localized1
        lblProduct.frame = CGRect(x:10,y:txtTitle.frame.origin.y+txtTitle.frame.height+10,width:self.view.frame.width-20,height:25)
        txtProduct.frame = CGRect(x:10,y:lblProduct.frame.origin.y+lblProduct.frame.height+10,width:self.view.frame.width-20,height:50)
        lblProduct.text = "Products".localized1
        txtProduct.placeholder = "Products".localized1
        lblName.frame = CGRect(x:10,y:txtProduct.frame.origin.y+txtProduct.frame.height+10,width:self.view.frame.width-20,height:25)
        txtName.frame = CGRect(x:10,y:lblName.frame.origin.y+lblName.frame.height+10,width:self.view.frame.width-20,height:50)
        lblName.text = "Name".localized1
        txtName.placeholder = "Name".localized1
        lblAddress.frame = CGRect(x:10,y:txtName.frame.origin.y+txtName.frame.height+10,width:self.view.frame.width-20,height:25)
        txtAddress.frame = CGRect(x:10,y:lblAddress.frame.origin.y+lblAddress.frame.height+10,width:self.view.frame.width-20,height:50)
        lblAddress.text = "Address".localized1
        txtAddress.placeholder = "Address".localized1
        lblEmail.frame = CGRect(x:10,y:txtAddress.frame.origin.y+txtAddress.frame.height+10,width:self.view.frame.width-20,height:25)
        txtEmail.frame = CGRect(x:10,y:lblEmail.frame.origin.y+lblEmail.frame.height+10,width:self.view.frame.width-20,height:50)
        lblEmail.text = "Email".localized1
        txtEmail.placeholder = "Email".localized1
        lblPhone.frame = CGRect(x:10,y:txtEmail.frame.origin.y+txtEmail.frame.height+10,width:self.view.frame.width-20,height:25)
        txtPhone.frame = CGRect(x:10,y:lblPhone.frame.origin.y+lblPhone.frame.height+10,width:self.view.frame.width-20,height:50)
        lblPhone.text = "Phone".localized1
        txtPhone.placeholder = "Phone".localized1
        lblReferralCode.frame = CGRect(x:10,y:txtPhone.frame.origin.y+txtPhone.frame.height+10,width:self.view.frame.width-20,height:25)
        txtReferralCode.frame = CGRect(x:10,y:lblReferralCode.frame.origin.y+lblReferralCode.frame.height+10,width:self.view.frame.width-20,height:50)
        lblReferralCode.text = "ReferralCode".localized1
        txtReferralCode.placeholder = "ReferralCode".localized1
        lblCountry.frame = CGRect(x:10,y:txtReferralCode.frame.origin.y+txtReferralCode.frame.height+10,width:self.view.frame.width-20,height:25)
        txtCountry.frame = CGRect(x:10,y:lblCountry.frame.origin.y+lblCountry.frame.height+10,width:self.view.frame.width-20,height:50)
        lblCountry.text = "Country".localized1
        txtCountry.placeholder = "Country".localized1
        lblState.frame = CGRect(x:10,y:txtCountry.frame.origin.y+txtCountry.frame.height+10,width:self.view.frame.width-20,height:25)
        lblState.text = "State".localized1
        btnState.setTitle("State".localized1, for: .normal)
        btnState.frame = CGRect(x:10,y:lblState.frame.origin.y+lblState.frame.height+10,width:self.view.frame.width-20,height:50)
        
        lblCity.frame = CGRect(x:10,y:btnState.frame.origin.y+btnState.frame.height+10,width:self.view.frame.width-20,height:25)
        lblCity.text = "City".localized1
        btnCity.setTitle("City".localized1, for: .normal)
        btnCity.frame = CGRect(x:10,y:lblCity.frame.origin.y+lblCity.frame.height+10,width:self.view.frame.width-20,height:50)
        
        btnSubmit.frame = CGRect(x:10,y:btnCity.frame.origin.y+btnCity.frame.height+25,width:self.view.frame.width-20,height:50)
        btnSubmit.setTitle("Submit".localized1, for: .normal)
        btnSubmit.addTarget(self, action: #selector(postBusiness), for: UIControlEvents.touchUpInside)
        
        if isConnectedToNetwork() {
            
            if(GlobalVariables.stateId.count > 0){
                self.chooseState.dataSource = GlobalVariables.stateName
            }else{
                getState()
                
            }
            if(GlobalVariables.business_cat_id.count > 0 ){
                self.chooseArticleDropDown.dataSource = GlobalVariables.business_category
            }else{
                getBusinessCategory()
            }
        }else{
            
        }
        
        setupChooseArticleDropDown()
        setupState()
        setupChoosecity()
        btnState.addTarget(self, action: #selector(btnStateClicked(_:)), for: .touchUpInside)
        btnCity.addTarget(self, action: #selector(btnCityClicked(_:)), for: .touchUpInside)
         /*self.txtState.filterStrings(GlobalVariables.stateName)
         self.txtCity.filterStrings(GlobalVariables.cityName)
        
        txtState.theme.font = UIFont.systemFont(ofSize: 45)
        txtState.theme.bgColor = UIColor.white
        txtState.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        txtState.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        txtState.theme.cellHeight = 45
        txtState.maxNumberOfResults = 5
        
        //txtState.comparisonOptions = [.caseInsensitive]
        // Set the max number of results. By default it's not limited
    
        
        txtCity.theme.font = UIFont.systemFont(ofSize: 45)
        txtCity.theme.bgColor = UIColor.white
        txtCity.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        txtCity.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        txtCity.theme.cellHeight = 45
        txtCity.maxNumberOfResults = 5*/
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBusinessCatClicked(_ sender: Any) {
        chooseArticleDropDown.show()
    }
    
    @objc func btnStateClicked(_ sender : UIButton){
        chooseState.show()
    }
    @objc func btnCityClicked(_ sender : UIButton){
        chooseCity.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                       
                        //self.business_cat_id.append(busCatId!)
                        //self.business_category.append(busCatName!)
                        GlobalVariables.business_cat_id.append(busCatId!)
                        GlobalVariables.business_category.append(busCatName!)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       self.chooseArticleDropDown.dataSource = GlobalVariables.business_category
                        
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
    
    func getCity(stateId : String){
        let parameters = "key=city&state_id=\(stateId)"
        print("getting city--",parameters)
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
                        self.cityId.append(city_id!)
                        self.cityName.append(city_name!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseCity.dataSource = self.cityName
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
    func getState(){
        let parameters = "key=state&country_id="
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
                        
                        let stateId = jsonObject?.object(forKey: "sid") as? String
                        let stateName = jsonObject?.object(forKey: "state") as? String
                        GlobalVariables.stateId.append(stateId!)
                        GlobalVariables.stateName.append(stateName!)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseState.dataSource = GlobalVariables.stateName
                        //self.txtState.filterStrings(self.stateName)
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
    
    
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnBusinessCat
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnBusinessCat.setTitle(item, for: .normal)
        }
    }
    func setupState() {
        chooseState.anchorView = btnState
        chooseState.selectionAction = { [weak self] (index, item) in
            self?.btnState.setTitle(item, for: .normal)
            
            self?.cityId.removeAll()
            self?.cityName.removeAll()
            self?.getCity(stateId: (GlobalVariables.stateId[index]))
        }
    }
    
    func setupChoosecity() {
        chooseCity.dataSource = cityName
        chooseCity.anchorView = btnCity
        chooseCity.selectionAction = { [weak self] (index, item) in
            self?.btnCity.setTitle(item, for: .normal)
            
        }
    }
    
    @objc func postBusiness(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(btnBusinessCat.currentTitle == "Select"){
            self.view.makeToast("Please Select Business Category", duration: 2.0, position: .top)
        }
        else if(txtTitle.text == ""){
            self.view.makeToast("Please Enter Business Title", duration: 2.0, position: .top)
        }
        else if(txtProduct.text == ""){
            self.view.makeToast("Please Enter Product Name", duration: 2.0, position: .top)
        }
        else if(txtName.text == ""){
            self.view.makeToast("Please enter Contact Persone name", duration: 2.0, position: .top)
        }
        else if(txtAddress.text == ""){
            self.view.makeToast("Please Enter Address", duration: 2.0, position: .top)
        }
        else if(txtEmail.text == ""){
            self.view.makeToast("Please Enter Email", duration: 2.0, position: .top)
        }
        else if(txtPhone.text == ""){
            self.view.makeToast("Please Enter Mobile No", duration: 2.0, position: .top)
        }
        else if(txtCountry.text == ""){
            self.view.makeToast("Please Enter Country", duration: 2.0, position: .top)
        }
        else if(btnState.currentTitle == "State" || btnState.currentTitle == "Select"){
            
            self.view.makeToast("Please Select State", duration: 2.0, position: .top)
        }
        else if(btnCity.currentTitle == "City" || btnCity.currentTitle == "Select"){
            
            self.view.makeToast("Please Select City", duration: 2.0, position: .top)
        }else{
            AddBusiness()
        }
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }

        /*else if(btnCity.currentTitle != "Select"){
            if(GlobalVariables.cityName.contains(txtCity.text!)){
                 AddBusiness()
            }else{
            self.view.makeToast("Please select City", duration: 2.0, position: .top)
            }
        }*/
    }
    
    
    func AddBusiness(){
        var businesSelectId : String = "0"
        if(btnBusinessCat.currentTitle == "Select"){
        }else{
            let indexofdesName = GlobalVariables.business_category.index(of: btnBusinessCat.currentTitle!)
            businesSelectId  =  GlobalVariables.business_cat_id[indexofdesName!]
        }
        let referenceCode : String = "0"
        
        var country : String = ""
        if(txtCountry.text == ""){
        }else{
            country =  txtCountry.text!
        }
        
        
        var stateSelectedId = String()
        var citySelectedId = String()
        if(btnState.currentTitle == ""){
            
        }else{
            if(GlobalVariables.stateName.contains(btnState.currentTitle!)){
                let indexofState  =  GlobalVariables.stateName.index(of: btnState.currentTitle!)
                stateSelectedId  = GlobalVariables.stateId[indexofState!]
            }else{
                
            }
        }
        if(btnCity.currentTitle  == ""){
            
        }else{
            if(self.cityName.contains(btnCity.currentTitle!)){
                let indexofCity  =  self.cityName.index(of:btnCity.currentTitle!)
                citySelectedId  = self.cityId[indexofCity!]
            }else{
                
            }
        }
        let parameters = "reference_code=\(referenceCode)&member_id=\(UserDefaults.standard.getUserID())&business_owner_name=\(txtName.text!)&contact_no=\(txtPhone.text!)&business_title=\(btnBusinessCat.currentTitle!)&business_description=\(whichPackage)&member_name=\(UserDefaults.standard.getMemberName())&country=\(country)&city=\(citySelectedId)&state=\(stateSelectedId)&address=\(txtAddress.text!)&email_id=\(txtEmail.text!)&product1=\(txtProduct.text!)&business_cat_id=\(businesSelectId)&package_id=\(packageId)"
        
        
        let url = URL(string:ServerUrl.post_new_business_url_ios)!
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
                
                let Success = json?.object(forKey: "message") as? String;
                if (Success == "success")
                {
                    DispatchQueue.main.async {
                        
                        let last_inserted_id = json?.object(forKey: "data") as! Int
                        
                        print("Events Repsonse---finally",last_inserted_id)
                        //  let last_inserted_id = json?.object(forKey: "last_inserted_id") as? String;
                        
                        self.hideActivityIndicator()
                        // self.showAlert(title: "Well Done", message: "Your Business Added Successfuly Proceed to Payment")
                        
                        
                        let alertController = JHTAlertController(title: "Well Done", message:"Your Business Added Successfuly", preferredStyle: .alert)
                        
                        alertController.titleTextColor = .black
                        alertController.titleFont = .systemFont(ofSize: 18)
                        alertController.titleViewBackgroundColor = .white
                        alertController.messageTextColor = .black
                        alertController.alertBackgroundColor = .white
                        alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                        
                        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                            
                            // let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            
                            if(self.whichPackage == "Regular"){
                                self.navigationController?.popViewController(animated: true)
                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[1])
                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                            }else{
                            let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as? OtherImageUploadCntr
                            
                            gotoOtherUpload?.whatToUpload = "Business"
                            gotoOtherUpload?.businessId = String(describing: last_inserted_id)
                            
                            self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
                            }
                        }
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.showAlert(title: "Something Went Wrong", message: "Nirjara Ap")
                        //self.alert(message: "Invalid Credential", title:"Nirjara Ap")
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
