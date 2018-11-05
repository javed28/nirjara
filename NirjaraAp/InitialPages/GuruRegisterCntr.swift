//
//  GuruRegisterCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class GuruRegisterCntr: UIViewController,SSRadioButtonControllerDelegate {
    

    @IBOutlet weak var imgTopLogo: UIImageView!
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    
    @IBOutlet weak var uiViewGender: UIView!
    @IBOutlet weak var acharyaView: UIView!
    @IBOutlet weak var uiViewCaste: UIView!
    @IBOutlet weak var adhithanaView: UIView!
    
    @IBOutlet weak var btnMale: SSRadioButton!
    @IBOutlet weak var btnFemale: SSRadioButton!
    
    @IBOutlet weak var btnMurtipujak: SSRadioButton!
    @IBOutlet weak var btnSthanakwasi: SSRadioButton!
    @IBOutlet weak var btnDigambar: SSRadioButton!
    @IBOutlet weak var btnTerapanthi: SSRadioButton!
    @IBOutlet weak var btnJain: SSRadioButton!
    
    @IBOutlet weak var btnAcharyaShri: SSRadioButton!
    @IBOutlet weak var btnUpadhayaShri: SSRadioButton!
    @IBOutlet weak var btnJainMuni: SSRadioButton!
    @IBOutlet weak var btnJainSadhvi: SSRadioButton!
    
    
    @IBOutlet weak var btnSamprdhay: UIButton!
    
    var genderRadioButton: SSRadioButtonsController?
    var casteRadioButton: SSRadioButtonsController?
    var acharya: SSRadioButtonsController?
    

    let chooseArticleDropDown = DropDown()

    @IBOutlet weak var lblAdhithana: UILabel!
    @IBOutlet weak var txtAdithana: UITextField!
    
    
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnAlreadySignIn: UIButton!
    var language = String()
    var memberType = String()
    var items = [[String : String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        genderRadioButton = SSRadioButtonsController(buttons: btnMale, btnFemale)
        genderRadioButton!.delegate = self
        genderRadioButton!.shouldLetDeSelect = true
        
        
        casteRadioButton = SSRadioButtonsController(buttons: btnMurtipujak, btnSthanakwasi,btnDigambar,btnTerapanthi,btnJain)
        casteRadioButton!.delegate = self
        casteRadioButton!.shouldLetDeSelect = true
        
        
        acharya = SSRadioButtonsController(buttons: btnAcharyaShri, btnUpadhayaShri,btnJainMuni,btnJainSadhvi)
        acharya!.delegate = self
        acharya!.shouldLetDeSelect = true

        imgTopLogo.frame = CGRect(x:70,y:25,width:self.view.frame.width-140,height:150)
        
        txtFullName.frame = CGRect(x:20,y:imgTopLogo.frame.origin.y+self.imgTopLogo.frame.height,width:self.view.frame.width-40,height:45)
        txtUserName.frame = CGRect(x:20,y:txtFullName.frame.origin.y+self.txtFullName.frame.height+10,width:self.view.frame.width-40,height:45)
        
        txtPassword.frame = CGRect(x:20,y:txtUserName.frame.origin.y+self.txtUserName.frame.height+10,width:self.view.frame.width-40,height:45)
        
        txtMobileNumber.frame = CGRect(x:20,y:txtPassword.frame.origin.y+self.txtPassword.frame.height+10,width:self.view.frame.width-40,height:45)
        
        txtFullName.setRightViewFAIcon(icon: .FAUser)
        txtUserName.setRightViewFAIcon(icon: .FAUser)
        txtPassword.setRightViewFAIcon(icon: .FAUnlock)
        txtMobileNumber.setRightViewFAIcon(icon: .FAMobile)
        
        
        txtFullName.placeholder = "FullName".localized1
        txtUserName.placeholder = "Username".localized1
        txtPassword.placeholder = "Password".localized1
        txtMobileNumber.placeholder = "MobileNumber".localized1
        
        uiViewGender.frame = CGRect(x:20,y:txtMobileNumber.frame.origin.y+self.txtMobileNumber.frame.height+10,width:self.view.frame.width-40,height:65)
        btnMale.frame = CGRect(x:8,y:9,width:self.uiViewGender.frame.width/2-20,height:45)
        btnFemale.frame = CGRect(x:self.uiViewGender.frame.width/2,y:9,width:self.uiViewGender.frame.width/2,height:45)
        btnMale.setTitle("Male".localized1, for: .normal)
        btnFemale.setTitle("Female".localized1, for: .normal)
        
        uiViewGender.addSubview(btnMale)
        uiViewGender.addSubview(btnFemale)
        
        acharyaView.frame = CGRect(x:20,y:uiViewGender.frame.origin.y+self.uiViewGender.frame.height+10,width:self.view.frame.width-40,height:100)
        
        
        btnAcharyaShri.frame = CGRect(x:8,y:8,width:self.acharyaView.frame.width/2-20,height:45)
        btnUpadhayaShri.frame = CGRect(x:self.acharyaView.frame.width/2,y:8,width:self.acharyaView.frame.width/2,height:45)
        btnJainMuni.frame = CGRect(x:8,y:50,width:self.acharyaView.frame.width/2-20,height:45)
        btnJainSadhvi.frame = CGRect(x:self.acharyaView.frame.width/2,y:50,width:self.acharyaView.frame.width/2,height:45)
        
        btnAcharyaShri.setTitle("Acharya_Sri".localized1, for: .normal)
        btnUpadhayaShri.setTitle("Upadhaya_Sri".localized1, for: .normal)
        btnJainMuni.setTitle("Jain_Muni".localized1, for: .normal)
        btnJainSadhvi.setTitle("Jain_Sadhvi".localized1, for: .normal)
        
        
        
        acharyaView.addSubview(btnAcharyaShri)
        acharyaView.addSubview(btnUpadhayaShri)
        acharyaView.addSubview(btnJainMuni)
        acharyaView.addSubview(btnJainSadhvi)
        
        
        
       
        
        uiViewCaste.frame = CGRect(x:20,y:acharyaView.frame.origin.y+self.acharyaView.frame.height+10,width:self.view.frame.width-40,height:160)
        
        
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
        
        
        
        adhithanaView.frame = CGRect(x:20,y:btnSamprdhay.frame.origin.y+self.btnSamprdhay.frame.height+10,width:self.view.frame.width-40,height:65)
        lblAdhithana.frame = CGRect(x:8,y:9,width:110,height:45)
        txtAdithana.frame = CGRect(x:115,y:9,width:self.adhithanaView.frame.width-120,height:45)
        lblAdhithana.text = "Adithana".localized1
        txtAdithana.placeholder = "Adithana".localized1
        adhithanaView.addSubview(lblAdhithana)
        adhithanaView.addSubview(txtAdithana)
        
        
        btnSignIn.frame = CGRect(x:20,y:adhithanaView.frame.origin.y+self.adhithanaView.frame.height+20,width:self.view.frame.width-40,height:45)
        btnSignIn.setTitle("singup".localized1, for: .normal)
        btnAlreadySignIn.frame = CGRect(x:20,y:btnSignIn.frame.origin.y+self.btnSignIn.frame.height+10,width:self.view.frame.width-40,height:45)
        btnAlreadySignIn.setTitle("Alreadyhaveaccount".localized1+" ? "+"singup".localized1, for: .normal)
        
        txtFullName.layer.borderWidth=1
        txtUserName.layer.borderWidth=1
        txtPassword.layer.borderWidth=1
        txtMobileNumber.layer.borderWidth=1
        btnSamprdhay.layer.borderWidth=1
        getGroupData()
        setupDropDowns()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func getGroupData(){
        
        let parameters = "lang=\(language)"
        let url = URL(string:ServerUrl.get_guru_data)!
        print("rul--",parameters)
        print("rul--",url)
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
                        // var subgroupId = [String]()
                        let sub_group_data = jsonObject?.object(forKey: "sub_group_data") as? [NSDictionary]
                        for j in 0..<sub_group_data!.count{
                            let subGroupData = sub_group_data?[j]
                            let sub_group_name = (subGroupData?.object(forKey: "sub_group_name") as? String)?.capitalized
                            let sub_group_id = subGroupData?.object(forKey: "sub_group_id") as? String
                            subgroupDa.updateValue(sub_group_name!, forKey: sub_group_id!)
                            //   subgroupId.append(sub_group_id!)
                        }
                        self.items.append(subgroupDa)
                        // self.itemsId.append(subgroupDa)
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
    

    func setupDropDowns(){
        setupChooseArticleDropDown()
    }
    

    @IBAction func btnSamprdhayClicked(_ sender: Any) {
        chooseArticleDropDown.show()
    }
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnSamprdhay
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnSamprdhay.setTitle(item, for: .normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
        else if(selectedButton?.titleLabel?.text == "Only "+"Jain".localized1+" (Open for All)"){
            var dropDownData = [String]()
            for (name, path) in items[4] {
                dropDownData.append(path)
            }
            chooseArticleDropDown.dataSource = dropDownData
            btnSamprdhay.setTitle("Select", for: .normal)
        }
    }
    
    
    @IBAction func btnSigninClicked(_ sender: Any) {
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
        }else if(casteRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Group", duration: 2.0, position: .bottom)
        }else if(acharya?.selectedButton() == nil){
            self.view.makeToast("Please Select Padvi", duration: 2.0, position: .bottom)
        }else{
        postRegData()
        }
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
    }
    
    func postRegData(){
        
        var mainGroup : Int = 0
        var subGroupId : String = "0"
        if(casteRadioButton?.selectedButton()?.currentTitle == "Sthanakwasi".localized1){
            mainGroup = 1
        }else if(casteRadioButton?.selectedButton()?.currentTitle == "Murtipujak".localized1){
            mainGroup = 2
        }else  if(casteRadioButton?.selectedButton()?.currentTitle == "Digambar".localized1){
            mainGroup = 4
        }else if(casteRadioButton?.selectedButton()?.currentTitle == "Terapanthi".localized1){
            mainGroup = 3
        }else if(casteRadioButton?.selectedButton()?.currentTitle == "Only "+"Jain".localized1+" (Open for All)"){
            mainGroup = 5
        }
        else{
            mainGroup = 5
        }
        
        if( btnSamprdhay.currentTitle == "Select"){
            
        }else{
            for (name, path) in items[mainGroup] {
                if(path == btnSamprdhay.currentTitle){
                    subGroupId = name
                }
            }
        }
        
        var genderData = String()
        var acharyaData = String()
        var adithna = String()
       
        if(genderRadioButton?.selectedButton()?.currentTitle == ""){
            genderData = ""
        }else{
            genderData = (genderRadioButton?.selectedButton()?.currentTitle)!
        }
        
        if(acharya?.selectedButton()?.currentTitle == ""){
            acharyaData = ""
        }else{
            acharyaData = (acharya?.selectedButton()?.currentTitle)!
        }
        
        if(txtAdithana.text! == ""){
            adithna = ""
        }else{
            adithna = txtAdithana.text!
        }
        
        
        // member_name=guru&username=gurus&password=123456&contact=1234567890&gender=Male&member_type=Guru&adithana=27&main_group=1&sub_group=10&language=gu&padvi=jain%20muni
        
        
        let parameters = "member_name=\(txtFullName.text!)&username=\(txtUserName.text!)&password=\(txtPassword.text!)&member_type=\(memberType)&language=\(language)&gender=\(genderData)&contact=\(txtMobileNumber.text!)&main_group=\(mainGroup)&sub_group=\(subGroupId)&padvi=\((acharya?.selectedButton()?.currentTitle)!)&adithana=\(adithna)"
        
        print("parameter",parameters)
        print("yrl---",ServerUrl.post_guru_registration_new)
        let url = URL(string:ServerUrl.post_guru_registration_new)!
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
                    let error_msg = json?.object(forKey: "error_msg") as? String;
                    
                    
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    
                    let jsonObject = jobData![0]
                    print(jsonObject)
                    DispatchQueue.main.async {
                    let member_name = jsonObject.object(forKey: "member_name") as? String
                    let member_id = jsonObject.object(forKey: "member_id") as? Int
                    let member_type = jsonObject.object(forKey: "member_type") as? String
                    //let username = jsonObject?.object(forKey: "username") as? String
                    let language = jsonObject.object(forKey: "language") as? String
                    let adithana = jsonObject.object(forKey: "adithana") as? String
                    let contact = jsonObject.object(forKey: "contact") as? String
                    if(contact?.description == "null" || contact?.description == "<null>" || contact?.description == nil){
                        
                    }else{
                        UserDefaults.standard.setMobileNumber(value: contact!.description)
                    }
                    
                    
                        self.view.makeToast(error_msg, duration: 2.0, position: .bottom)
                        self.hideActivityIndicator()
                        UserDefaults.standard.setUserID(value:String(member_id!))
                        UserDefaults.standard.setLoggedIn(value: true)
                        UserDefaults.standard.setMemberName(value: member_name!)
                        UserDefaults.standard.setMemberType(value: member_type!)
                        UserDefaults.standard.setLanguage(value: language!)
                        UserDefaults.standard.setAdhithana(value: adithana!)
                        // UserDefaults.standard.setFirstName(value: username!)
                        
                       // self.performSegue(withIdentifier: "guruRegisterToIntro", sender: self)
                       // self.performSegue(withIdentifier: "guruRegToVideoIntro", sender: self)
                        self.performSegue(withIdentifier: "guruToLogin", sender: self)
                        self.view.makeToast("Once active you can login", duration: 2.0, position: .bottom)
                        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
