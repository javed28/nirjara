//
//  FullRegistrationCntrl.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DatePickerDialog
import DropDown
import SearchTextField
import IQKeyboardManagerSwift

class FullRegistrationCntrl: UIViewController,SSRadioButtonControllerDelegate {
    
    

    @IBOutlet weak var imgTopLogo: UIImageView!
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
  
    @IBOutlet weak var btnState: UIButton!
    
    @IBOutlet weak var btnCity: UIButton!
    
    
    @IBOutlet weak var BirthDatePicker: UITextField!
    
    @IBOutlet weak var uiViewGender: UIView!
    @IBOutlet weak var uiViewCaste: UIView!
    
    @IBOutlet weak var btnMale: SSRadioButton!
    @IBOutlet weak var btnFemale: SSRadioButton!
    
    @IBOutlet weak var btnMurtipujak: SSRadioButton!
    @IBOutlet weak var btnSthanakwasi: SSRadioButton!
    @IBOutlet weak var btnDigambar: SSRadioButton!
    @IBOutlet weak var btnTerapanthi: SSRadioButton!
    @IBOutlet weak var btnJain: SSRadioButton!
    
    var genderRadioButton: SSRadioButtonsController?
    var casteRadioButton: SSRadioButtonsController?

    var kidsBelowRadioButton: SSRadioButtonsController?
    var membersAboveButton: SSRadioButtonsController?
    
    
     let pickOptions = ["One", "Two", "Three", "Seven", "Fifteen"]
    @IBOutlet weak var lblHelpUs: UILabel!
    @IBOutlet weak var lblKidsBelow: UILabel!
    
    @IBOutlet weak var uiViewKids: UIView!
    @IBOutlet weak var uiViewMembers: UIView!
    
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var lblMembers: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnAlreadySignIn: UIButton!
    
    
    @IBOutlet weak var btnKids0: SSRadioButton!
    @IBOutlet weak var btnKids1: SSRadioButton!
    @IBOutlet weak var btnKids6: SSRadioButton!
    @IBOutlet weak var btnKids3: SSRadioButton!
    @IBOutlet weak var btnKids5: SSRadioButton!
    @IBOutlet weak var btnKids4: SSRadioButton!
    @IBOutlet weak var btnKids2: SSRadioButton!
    
    @IBOutlet weak var btnMember0: SSRadioButton!
    @IBOutlet weak var btnMember1: SSRadioButton!
    @IBOutlet weak var btnMember2: SSRadioButton!
    @IBOutlet weak var btnMember3: SSRadioButton!
    @IBOutlet weak var btnMember4: SSRadioButton!
    @IBOutlet weak var btnMember5: SSRadioButton!
    @IBOutlet weak var btnMember6: SSRadioButton!
    
    @IBOutlet weak var btnSamprdhay: UIButton!
    let chooseArticleDropDown = DropDown()
    let chooseState = DropDown()
    let chooseCity = DropDown()
    
    var items = [[String : String]]()
    //var itemsId = [[String]]()
    var countriesList = [String]()
    
   // var stateData : NSMutableArray = NSMutableArray()
 //   var cityData : NSMutableArray = NSMutableArray()
    
    var stateName = [String]()
    var stateId = [String]()
    
    var cityId = [String]()
    var cityName = [String]()
    
    
    
    var language = String()
    var memberType = String()
    
    
    
    @IBOutlet weak var marriedView: UIView!
    var marriedButton: SSRadioButtonsController?
    @IBOutlet weak var btnMarried: SSRadioButton!
    @IBOutlet weak var btnUnMarried: SSRadioButton!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         BirthDatePicker.delegate = self
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    
        if isConnectedToNetwork() {
            getState()
            getGroupData()
        
        }else{
            showAlert(title: "Oop's", message: "No Internet Connection")
        }
        
        genderRadioButton = SSRadioButtonsController(buttons: btnMale, btnFemale)
        genderRadioButton!.delegate = self
        genderRadioButton!.shouldLetDeSelect = true
        
        
        casteRadioButton = SSRadioButtonsController(buttons: btnMurtipujak, btnSthanakwasi,btnDigambar,btnTerapanthi,btnJain)
        casteRadioButton!.delegate = self
        casteRadioButton!.shouldLetDeSelect = true
        
        kidsBelowRadioButton = SSRadioButtonsController(buttons: btnKids0, btnKids1,btnKids2,btnKids3,btnKids4,btnKids5,btnKids6)
        kidsBelowRadioButton!.delegate = self
        kidsBelowRadioButton!.shouldLetDeSelect = true
        
         membersAboveButton = SSRadioButtonsController(buttons: btnMember0, btnMember1,btnMember2,btnMember3,btnMember4,btnMember5,btnMember6)
        membersAboveButton!.delegate = self
        membersAboveButton!.shouldLetDeSelect = true
        
        marriedButton = SSRadioButtonsController(buttons: btnMarried, btnUnMarried)
        marriedButton!.delegate = self
        marriedButton!.shouldLetDeSelect = true
        
        lblNote.numberOfLines=0
        
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        txtSampraday.inputView = pickerView
        
        imgTopLogo.frame = CGRect(x:70,y:30,width:self.view.frame.width-140,height:150)
        
        txtFullName.frame = CGRect(x:20,y:imgTopLogo.frame.origin.y+self.imgTopLogo.frame.height,width:self.view.frame.width-40,height:45)
        txtUserName.frame = CGRect(x:20,y:txtFullName.frame.origin.y+self.txtFullName.frame.height+10,width:self.view.frame.width-40,height:45)
        
        txtFullName.placeholder = "FullName".localized1
        txtUserName.placeholder = "Username".localized1
        
        txtPassword.frame = CGRect(x:20,y:txtUserName.frame.origin.y+self.txtUserName.frame.height+10,width:self.view.frame.width-40,height:45)
        txtPassword.placeholder = "Password".localized1
        txtMobileNumber.frame = CGRect(x:20,y:txtPassword.frame.origin.y+self.txtPassword.frame.height+10,width:self.view.frame.width-40,height:45)
        txtMobileNumber.placeholder = "MobileNumber".localized1
        txtEmail.frame = CGRect(x:20,y:txtMobileNumber.frame.origin.y+self.txtMobileNumber.frame.height+10,width:self.view.frame.width-40,height:45)
        txtEmail.placeholder = "Email".localized1
        txtCountry.frame = CGRect(x:20,y:txtEmail.frame.origin.y+self.txtEmail.frame.height+10,width:self.view.frame.width-40,height:45)
        txtCountry.placeholder = "Country".localized1
        btnState.frame = CGRect(x:20,y:txtCountry.frame.origin.y+self.txtCountry.frame.height+10,width:self.view.frame.width-40,height:45)
        btnState.setTitle("State".localized1, for: .normal)
        btnCity.frame = CGRect(x:20,y:btnState.frame.origin.y+self.btnState.frame.height+10,width:self.view.frame.width-40,height:45)
        btnCity.setTitle("City".localized1, for:.normal)
        BirthDatePicker.frame = CGRect(x:20,y:btnCity.frame.origin.y+self.btnCity.frame.height+10,width:self.view.frame.width-40,height:45)
        
        
        
        txtFullName.setRightViewFAIcon(icon: .FAUser)
        txtUserName.setRightViewFAIcon(icon: .FAUser)
        txtPassword.setRightViewFAIcon(icon: .FAUnlock)
        txtMobileNumber.setRightViewFAIcon(icon: .FAMobile)
        txtEmail.setRightViewFAIcon(icon: .FAMailReply)
        txtCountry.setRightViewFAIcon(icon: .FAFlag)
        BirthDatePicker.setRightViewFAIcon(icon: .FABirthdayCake)
        
        
        
        
        uiViewGender.frame = CGRect(x:20,y:BirthDatePicker.frame.origin.y+self.BirthDatePicker.frame.height+10,width:self.view.frame.width-40,height:65)
        btnMale.frame = CGRect(x:8,y:9,width:self.uiViewGender.frame.width/2-20,height:45)
        btnFemale.frame = CGRect(x:self.uiViewGender.frame.width/2,y:9,width:self.uiViewGender.frame.width/2,height:45)
        btnMale.setTitle("Male".localized1, for: .normal)
        btnFemale.setTitle("Female".localized1, for: .normal)
        
        uiViewGender.addSubview(btnMale)
        uiViewGender.addSubview(btnFemale)
    
        uiViewCaste.frame = CGRect(x:20,y:uiViewGender.frame.origin.y+self.uiViewGender.frame.height+10,width:self.view.frame.width-40,height:160)
        

        btnMurtipujak.frame = CGRect(x:8,y:8,width:self.uiViewCaste.frame.width/2-20,height:45)
        btnSthanakwasi.frame = CGRect(x:self.uiViewCaste.frame.width/2,y:8,width:self.uiViewCaste.frame.width/2,height:45)
        btnDigambar.frame = CGRect(x:8,y:50,width:self.uiViewCaste.frame.width/2-20,height:45)
        btnTerapanthi.frame = CGRect(x:self.uiViewCaste.frame.width/2,y:50,width:self.uiViewCaste.frame.width/2,height:45)
        btnJain.frame = CGRect(x:8,y:100,width:self.uiViewCaste.frame.width-16,height:45)
        
        btnMurtipujak.setTitle("Murtipujak".localized1, for: .normal)
        btnSthanakwasi.setTitle("Sthanakwasi".localized1, for: .normal)
        btnDigambar.setTitle("Digambar".localized1, for: .normal)
        btnTerapanthi.setTitle("Terapanthi".localized1, for: .normal)
        btnJain.setTitle("Only "+"Jain".localized1+" (Open for All)", for: .normal)
         uiViewCaste.addSubview(btnMurtipujak)
         uiViewCaste.addSubview(btnSthanakwasi)
         uiViewCaste.addSubview(btnDigambar)
         uiViewCaste.addSubview(btnTerapanthi)
         uiViewCaste.addSubview(btnJain)
        
        btnSamprdhay.frame = CGRect(x:20,y:uiViewCaste.frame.origin.y+self.uiViewCaste.frame.height+10,width:self.view.frame.width-40,height:45)
        
        
        marriedView.frame = CGRect(x:20,y:btnSamprdhay.frame.origin.y+self.btnSamprdhay.frame.height+10,width:self.view.frame.width-40,height:65)
        btnMarried.frame = CGRect(x:8,y:9,width:self.marriedView.frame.width/2-20,height:45)
        btnUnMarried.frame = CGRect(x:self.marriedView.frame.width/2,y:9,width:self.marriedView.frame.width/2,height:45)
        
        marriedView.addSubview(btnMarried)
        marriedView.addSubview(btnUnMarried)
        
        
        
        lblHelpUs.frame = CGRect(x:30,y:marriedView.frame.origin.y+self.marriedView.frame.height+10,width:self.view.frame.width-40,height:25)
        lblHelpUs.text = "HelpUsCountingJainPopulation".localized1
        lblKidsBelow.frame = CGRect(x:20,y:lblHelpUs.frame.origin.y+self.lblHelpUs.frame.height+10,width:self.view.frame.width-40,height:25)
        lblHelpUs.text = "KidsBelow_18".localized1
        
         uiViewKids.frame = CGRect(x:20,y:lblKidsBelow.frame.origin.y+self.lblKidsBelow.frame.height+10,width:self.view.frame.width-40,height:50)
        
         btnKids0.frame = CGRect(x:5,y:4,width:40,height:45)
         btnKids1.frame = CGRect(x:50,y:4,width:40,height:45)
         btnKids2.frame = CGRect(x:100,y:4,width:40,height:45)
         btnKids3.frame = CGRect(x:150,y:4,width:40,height:45)
         btnKids4.frame = CGRect(x:200,y:4,width:40,height:45)
         btnKids5.frame = CGRect(x:250,y:4,width:40,height:45)
         btnKids6.frame = CGRect(x:300,y:4,width:40,height:45)
        uiViewKids.addSubview(btnKids0)
        uiViewKids.addSubview(btnKids1)
        uiViewKids.addSubview(btnKids2)
        uiViewKids.addSubview(btnKids3)
        uiViewKids.addSubview(btnKids4)
        uiViewKids.addSubview(btnKids5)
        uiViewKids.addSubview(btnKids6)
        
        
        lblMembers.frame = CGRect(x:20,y:uiViewKids.frame.origin.y+self.uiViewKids.frame.height+10,width:self.view.frame.width-40,height:25)
        lblMembers.text = "MemberAbove60".localized1
        uiViewMembers.frame = CGRect(x:20,y:lblMembers.frame.origin.y+self.lblMembers.frame.height+10,width:self.view.frame.width-40,height:50)
        btnMember0.frame = CGRect(x:5,y:4,width:40,height:45)
        btnMember1.frame = CGRect(x:50,y:4,width:40,height:45)
        btnMember2.frame = CGRect(x:100,y:4,width:40,height:45)
        btnMember3.frame = CGRect(x:150,y:4,width:40,height:45)
        btnMember4.frame = CGRect(x:200,y:4,width:40,height:45)
        btnMember5.frame = CGRect(x:250,y:4,width:40,height:45)
        btnMember6.frame = CGRect(x:300,y:4,width:40,height:45)
        uiViewMembers.addSubview(btnMember0)
        uiViewMembers.addSubview(btnMember1)
        uiViewMembers.addSubview(btnMember2)
        uiViewMembers.addSubview(btnMember3)
        uiViewMembers.addSubview(btnMember4)
        uiViewMembers.addSubview(btnMember5)
        uiViewMembers.addSubview(btnMember6)
        lblNote.frame = CGRect(x:20,y:uiViewMembers.frame.origin.y+self.uiViewMembers.frame.height+10,width:self.view.frame.width-40,height:55)
        
        lblNote.text = "Population_onlymarried_woman".localized1
        
        marriedView.alpha = 0
        lblKidsBelow.alpha = 0
        lblHelpUs.alpha = 0
        uiViewKids.alpha = 0
        lblMembers.alpha = 0
        uiViewMembers.alpha = 0
        lblNote.alpha = 0

        mainViewHeight.constant = 1300
        mainView.layoutIfNeeded()
       // btnSignIn.frame = CGRect(x:20,y:lblNote.frame.origin.y+self.lblNote.frame.height+20,width:self.view.frame.width-40,height:45)
        btnSignIn.frame = CGRect(x:20,y:btnSamprdhay.frame.origin.y+self.btnSamprdhay.frame.height+20,width:self.view.frame.width-40,height:45)
        btnAlreadySignIn.frame = CGRect(x:20,y:btnSignIn.frame.origin.y+self.btnSignIn.frame.height+10,width:self.view.frame.width-40,height:45)
        btnSignIn.setTitle("singup".localized1, for: .normal)
        btnAlreadySignIn.setTitle("Alreadyhaveaccount".localized1+" ? "+"signin".localized1, for: .normal)
        txtFullName.layer.borderWidth=1
        txtUserName.layer.borderWidth=1
        txtPassword.layer.borderWidth=1
        txtMobileNumber.layer.borderWidth=1
        txtEmail.layer.borderWidth=1
        txtCountry.layer.borderWidth=1
        BirthDatePicker.layer.borderWidth=1
        btnSamprdhay.layer.borderWidth=1
        setupDropDowns()
        setupState()
        setupChoosecity()
        btnState.addTarget(self, action: #selector(btnStateClicked(_:)), for: .touchUpInside)
        btnCity.addTarget(self, action: #selector(btnCityClicked(_:)), for: .touchUpInside)
        /*//txtState.filterStrings(["Red", "Blue", "Yellow","Black"])
       
        
        // Set a visual theme (SearchTextFieldTheme). By default it's the light theme
        //txtState.theme = SearchTextFieldTheme.darkTheme()
        
        // Modify current theme properties
     //  txtState.theme.font = UIFont.systemFont(ofSize: 50)
        txtState.theme.font = UIFont.systemFont(ofSize: 45)
        txtState.theme.bgColor = UIColor.white
        txtState.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        txtState.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        txtState.theme.cellHeight = 45
        
        //txtState.comparisonOptions = [.caseInsensitive]
        // Set the max number of results. By default it's not limited
        txtState.maxNumberOfResults = 5
        
        
      
        txtCity.theme.font = UIFont.systemFont(ofSize: 45)
        txtCity.theme.bgColor = UIColor.white
        txtCity.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        txtCity.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        txtCity.theme.cellHeight = 45
        txtCity.maxNumberOfResults = 5*/
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func setupState() {
        chooseState.anchorView = btnState
        chooseState.selectionAction = { [weak self] (index, item) in
            self?.btnState.setTitle(item, for: .normal)
            
            self?.cityId.removeAll()
            self?.cityName.removeAll()
            self?.getCity(stateId: (self?.stateId[index])!)
        }
    }
    
    func setupChoosecity() {
        chooseCity.dataSource = cityName
        chooseCity.anchorView = btnCity
        chooseCity.selectionAction = { [weak self] (index, item) in
            self?.btnCity.setTitle(item, for: .normal)
            
        }
    }
    @objc func btnStateClicked(_ sender : UIButton){
        chooseState.show()
    }
    @objc func btnCityClicked(_ sender : UIButton){
        chooseCity.show()
    }
    
    @IBAction func btnSigninclicked(_ sender: Any) {
        
        if isConnectedToNetwork() {
        if(txtFullName.text == ""){
            self.view.makeToast("Please Enter Full Name", duration: 2.0, position: .bottom)
        }else if(txtUserName.text == ""){
            self.view.makeToast("Please Enter User Name", duration: 2.0, position: .bottom)
        }
        else if(txtPassword.text == ""){
            self.view.makeToast("Please Enter Pasword", duration: 2.0, position: .bottom)
        }
        else if(txtMobileNumber.text == ""){
            self.view.makeToast("Please Enter Mobile Number", duration: 2.0, position: .bottom)
        }
        else if(genderRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Gender", duration: 2.0, position: .bottom)
        }else{
        
           
           postRegData()
           // print("Birth Pciker",BirthDatePicker.text)
                // let data  = itemsId[indexofSampradhay!]
            
//            member_name=test&member_surname=jadhav&member_type=Sharawak&gender=Male&contact=1234567890&username=testing&password=123456&email=arun@omwebsolution.com&main_group=2&language=hi&sub_group=5&country=99&state=21&member_city=351&dob=1990-12-19&members_below18=1&members_above60=1
            //postRegData()
        }
    }else{
    showAlert(title: "OOp's", message: "No Internet Connection")
    }
        
        
        
        
    }
    
    
    
    
    func postRegData(){
        
        var mainGroup : Int = 0
        var subGroupId : String = "0"
        if(casteRadioButton?.selectedButton()?.currentTitle == "Sthanakwasi".localized1){
            mainGroup = 0
        }else if(casteRadioButton?.selectedButton()?.currentTitle == "Murtipujak".localized1){
            mainGroup = 1
        }else  if(casteRadioButton?.selectedButton()?.currentTitle == "Digambar".localized1){
            mainGroup = 2
        }else if(casteRadioButton?.selectedButton()?.currentTitle == "Terapanthi".localized1){
            mainGroup = 3
        }else if(casteRadioButton?.selectedButton()?.currentTitle == "Only "+"Jain".localized1+" (Open for All)"){
            mainGroup = 4
        }
        
        if( btnSamprdhay.currentTitle == "Select"){
            
        }else{
            for (name, path) in items[mainGroup] {
                print("Name 1---\(path)")
                print("Name 2---\(name)")
                print("Name 3---\(btnSamprdhay.currentTitle)")
                if(path == btnSamprdhay.currentTitle){
                    subGroupId = name
                    break
                }
            }
        }
    
        var stateSelectedId = String()
        var citySelectedId = String()
        var birthDate = String()
        var email = String()
        var membersAboveData = String()
        var membersbelowData = String()
        var genderData = String()
        
        if(btnState.currentTitle == ""){
            
        }else{
            
            if(self.stateName.contains(btnState.currentTitle!)){
                let indexofState  =  stateName.index(of: btnState.currentTitle!)
                stateSelectedId  = stateId[indexofState!]
                
            }else{
                
            }
        }
        if(btnCity.currentTitle == ""){
            
        }else{
            
            if(self.cityName.contains(btnCity.currentTitle!)){
                let indexofCity  =  cityName.index(of: btnCity.currentTitle!)
                citySelectedId  = cityId[indexofCity!]
            }else{
                
            }
 
        }
        if(BirthDatePicker.text == "Selected DOB"){
            birthDate = "00-00-0000"
        }else{
            //birthDate = BirthDatePicker.text!
            birthDate = (BirthDatePicker.text?.convertDateForDob(BirthDatePicker.text!))!
        }
        
        if(txtEmail.text == ""){
            email = ""
        }else{
            email = txtEmail.text!
            
        }
        
        if(membersAboveButton?.selectedButton() == nil){
            membersAboveData = ""
        }else{
            membersAboveData = (membersAboveButton?.selectedButton()?.currentTitle)!
            
        }
        
        if(kidsBelowRadioButton?.selectedButton() == nil){
            membersbelowData = ""
        }else{
            membersbelowData = (kidsBelowRadioButton?.selectedButton()?.currentTitle)!
        }
        
        if(genderRadioButton?.selectedButton()?.currentTitle == ""){
            genderData = ""
        }else{
            genderData = (genderRadioButton?.selectedButton()?.currentTitle)!
        }
        
        if(mainGroup == 0){
            mainGroup = 1
        }else if(mainGroup == 1){
             mainGroup = 2
        }
        else if(mainGroup == 2){
             mainGroup = 3
        }
        else if(mainGroup == 3){
             mainGroup = 4
        }
        else if(mainGroup == 4){
             mainGroup = 5
        }

        let parameters = "member_name=\(txtFullName.text!)&username=\(txtUserName.text!)&password=\(txtPassword.text!)&member_type=\(memberType)&language=\(language)&gender=\(genderData)&contact=\(txtMobileNumber.text!)&email=\(email)&main_group=\(mainGroup)&sub_group=\(subGroupId)&country=99&member_city=\(citySelectedId)&dob=\(birthDate)&members_below18=\(membersbelowData)&members_above60=\(membersAboveData)&state=\(stateSelectedId)"
        
        print("parameter",parameters)
        print("yrl---",ServerUrl.post_shravak_registration)
        let url = URL(string:ServerUrl.post_shravak_registration)!
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
 print("register res---",json)
                
                let message = json?.object(forKey: "message") as? String;
                if (message == "success")
                {
                    
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    
                        let jsonObject = jobData![0]
                        print(jsonObject)
                        
                    let member_name = jsonObject.object(forKey: "member_name") as? String
                    let member_id = jsonObject.object(forKey: "member_id") as? Int
                    let member_type = jsonObject.object(forKey: "member_type") as? String
                        //let username = jsonObject?.object(forKey: "username") as? String
                    let language = jsonObject.object(forKey: "language") as? String
                    let contact = jsonObject.object(forKey: "contact") as? String
                    if(contact?.description == "null" || contact?.description == "<null>" || contact?.description == nil){
                        
                    }else{
                        UserDefaults.standard.setMobileNumber(value: contact!.description)
                    }
                        DispatchQueue.main.async {
                            let error_msg = json?.object(forKey: "error_msg") as? String;
                            
                            self.view.makeToast(error_msg, duration: 2.0, position: .bottom)
                            self.hideActivityIndicator()
                            UserDefaults.standard.setUserID(value:String(member_id!))
                            UserDefaults.standard.setLoggedIn(value: true)
                            UserDefaults.standard.setMemberName(value: member_name!)
                            UserDefaults.standard.setMemberType(value: member_type!)
                            UserDefaults.standard.setLanguage(value: language!)
                            // UserDefaults.standard.setFirstName(value: username!)
                            
                            //self.performSegue(withIdentifier: "registerToIntro", sender: self)
                            self.performSegue(withIdentifier: "ShravakRegToVideoIntro", sender: self)
                            
                        
                      //  {"message""success","data":[{"member_name":"Hihi","member_id":239,"gender":"Female\"","dob":"26-08-1999","member_type":"Shravak","male_members_below18":null,"female_members_below18":null,"male_members_18to25":null,"female_members_18to25":null,"male_members_25to40":null,"female_members_25to40":null,"male_members_40to60":null,"female_members_40to60":null,"male_members_above60":null,"female_members_above60":null,"main_group_id":"1","main_group":"Sthanakwasi","sub_group_id":"52","sub_group":"ACHARYA SRI VIJAY VALLABH SURISHWARJI M.S. (NITHYANANDSURI) 2017","contact":"32323232232","username":"Hi","password":"","language":"","date_added":"2018-03-21","status":"Active"}],"error_msg":"Your Registration is successfull.."}
                       
                        
                    }
                   
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    let error_msg = json?.object(forKey: "error_msg") as? String;
                    self.view.makeToast(error_msg, duration: 2.0, position: .top)
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
                        self.stateId.append(stateId!)
                        self.stateName.append(stateName!)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseState.dataSource = self.stateName
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
    
    
    
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = -99
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: UIColor.rgb(hexcolor: "#FF9800"),
                                          buttonColor: UIColor.rgb(hexcolor: "#FF9800"),
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Select Your BirthDate",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd-MM-yyyy"
                               
                                
                                self.BirthDatePicker.text = formatter.string(from: dt)
                                
                            }
                            var toYear = Int()
                            let components = NSCalendar.current.dateComponents([.day,.month,.year],from:date!)
                           // if let day = components.day, let month = components.month, let year = components.year {
//                                let dayString = "\(day)"
//                                let monthString = "\(month)"
//                                let yearString = "\(year)"
                             if let year = components.year {
                                toYear = year
                                
                            }
                            

                            let currentDateTime = Date()
                            let userCalendar = Calendar.current
                            let requestedComponents: Set<Calendar.Component> = [
                                .year,
                                .month,
                                .day,
                                .hour,
                                .minute,
                                .second
                            ]
                            let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
                            let year = dateTimeComponents.year
                            print("hello",year!-toYear)
                            if((year!-toYear)>=18){
                                self.marriedView.alpha = 1
//                                lblKidsBelow.alpha = 0
//                                lblHelpUs.alpha = 0
//                                uiViewKids.alpha = 0
//                                lblMembers.alpha = 0
//                                uiViewMembers.alpha = 0
//                                lblNote.alpha = 0
                                
                                self.mainViewHeight.constant = 1480
                                self.mainView.layoutIfNeeded()
                                // btnSignIn.frame = CGRect(x:20,y:lblNote.frame.origin.y+self.lblNote.frame.height+20,width:self.view.frame.width-40,height:45)
                               self.btnSignIn.frame = CGRect(x:20,y:self.marriedView.frame.origin.y+self.marriedView.frame.height+20,width:self.view.frame.width-40,height:45)
                                self.btnAlreadySignIn.frame = CGRect(x:20,y:self.btnSignIn.frame.origin.y+self.btnSignIn.frame.height+10,width:self.view.frame.width-40,height:45)

                            }else{
                                
                                
                                self.btnMarried.isSelected = false
                                self.btnUnMarried.isSelected = false
                                self.marriedView.alpha = 0
                                self.lblKidsBelow.alpha = 0
                                self.lblHelpUs.alpha = 0
                                self.uiViewKids.alpha = 0
                                self.lblMembers.alpha = 0
                                self.uiViewMembers.alpha = 0
                                self.lblNote.alpha = 0
                                
                                self.mainViewHeight.constant = 1300
                                self.mainView.layoutIfNeeded()
                            
                                self.btnSignIn.frame = CGRect(x:20,y:self.btnSamprdhay.frame.origin.y+self.btnSamprdhay.frame.height+20,width:self.view.frame.width-40,height:45)
                                self.btnAlreadySignIn.frame = CGRect(x:20,y:self.btnSignIn.frame.origin.y+self.btnSignIn.frame.height+10,width:self.view.frame.width-40,height:45)
                                
                            }

                            
        }
    }
    func setupDropDowns(){
        setupChooseArticleDropDown()
    }

    @IBAction func btnSamprdhayClicked(_ sender: Any) {
        chooseArticleDropDown.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnSamprdhay
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnSamprdhay.setTitle(item, for: .normal)
        }
    }
    func didSelectButton(selectedButton: UIButton?) {
        if(selectedButton?.titleLabel?.text == "Murtipujak".localized1){
            var dropDownData = [String]()
            for (name, path) in items[1] {
               dropDownData.append(path)
            }
            chooseArticleDropDown.dataSource = dropDownData
            btnSamprdhay.setTitle("Select", for: .normal)
        }else if(selectedButton?.titleLabel?.text == "Sthanakwasi".localized1){
            var dropDownData = [String]()
            for (name, path) in items[0] {
                dropDownData.append(path)
            }
            chooseArticleDropDown.dataSource = dropDownData
            btnSamprdhay.setTitle("Select", for: .normal)
        }else if(selectedButton?.titleLabel?.text == "Digambar".localized1){
            var dropDownData = [String]()
            for (name, path) in items[3] {
                dropDownData.append(path)
            }
            chooseArticleDropDown.dataSource = dropDownData
            btnSamprdhay.setTitle("Select", for: .normal)
        }else if(selectedButton?.titleLabel?.text == "Terapanthi".localized1){
            var dropDownData = [String]()
            for (name, path) in items[2] {
                dropDownData.append(path)
            }
            chooseArticleDropDown.dataSource = dropDownData
            btnSamprdhay.setTitle("Select", for: .normal)
        }else if(selectedButton?.titleLabel?.text == "Only "+"Jain".localized1+" (Open for All)"){
            var dropDownData = [String]()
            for (name, path) in items[4] {
                dropDownData.append(path)
            }
            chooseArticleDropDown.dataSource = dropDownData
            btnSamprdhay.setTitle("Select", for: .normal)
        }else if(selectedButton?.titleLabel?.text == "Married"){
            self.marriedView.alpha = 1
                                            lblKidsBelow.alpha = 1
                                            lblHelpUs.alpha = 1
                                            uiViewKids.alpha = 1
                                            lblMembers.alpha = 1
                                            uiViewMembers.alpha = 1
                                            lblNote.alpha = 1
            
            self.mainViewHeight.constant = 1600
            self.mainView.layoutIfNeeded()
             btnSignIn.frame = CGRect(x:20,y:lblNote.frame.origin.y+self.lblNote.frame.height+20,width:self.view.frame.width-40,height:45)
            //self.btnSignIn.frame = CGRect(x:20,y:self.marriedView.frame.origin.y+self.marriedView.frame.height+20,width:self.view.frame.width-40,height:45)
            self.btnAlreadySignIn.frame = CGRect(x:20,y:self.btnSignIn.frame.origin.y+self.btnSignIn.frame.height+10,width:self.view.frame.width-40,height:45)

        }
        else if(selectedButton?.titleLabel?.text == "UnMarried"){
                                            self.marriedView.alpha = 1
                                            lblKidsBelow.alpha = 0
                                            lblHelpUs.alpha = 0
                                            uiViewKids.alpha = 0
                                            lblMembers.alpha = 0
                                            uiViewMembers.alpha = 0
                                            lblNote.alpha = 0
            
            
            self.mainViewHeight.constant = 1480
            self.mainView.layoutIfNeeded()
            // btnSignIn.frame = CGRect(x:20,y:lblNote.frame.origin.y+self.lblNote.frame.height+20,width:self.view.frame.width-40,height:45)
            self.btnSignIn.frame = CGRect(x:20,y:self.marriedView.frame.origin.y+self.marriedView.frame.height+20,width:self.view.frame.width-40,height:45)
            self.btnAlreadySignIn.frame = CGRect(x:20,y:self.btnSignIn.frame.origin.y+self.btnSignIn.frame.height+10,width:self.view.frame.width-40,height:45)

        }
        
        
//        var currentGenderButton = genderRadioButton?.selectedButton()
//        var currentCasteButton = casteRadioButton?.selectedButton()
//        var currentKidsButton = kidsBelowRadioButton?.selectedButton()
//        var currentMembersButton = membersAboveButton?.selectedButton()
//
//        print("currentGenderButton",currentGenderButton)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    func getGroupData(){
    
        let parameters = "lang=\(language)"
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

                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var subgroupDa : [String : String]  = [:]
                      
                        let sub_group_data = jsonObject?.object(forKey: "sub_group_data") as? [NSDictionary]
                        for j in 0..<sub_group_data!.count{
                            let subGroupData = sub_group_data?[j]
                            let sub_group_name = (subGroupData?.object(forKey: "sub_group_name") as? String)?.capitalized
                            let sub_group_id = subGroupData?.object(forKey: "sub_group_id") as? String
                            subgroupDa.updateValue(sub_group_name!, forKey: sub_group_id!)
                        
                        }
                        self.items.append(subgroupDa)
                      
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

}
extension FullRegistrationCntrl: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.BirthDatePicker {
            datePickerTapped()
            return false
        }
        
        return true
    }
}

