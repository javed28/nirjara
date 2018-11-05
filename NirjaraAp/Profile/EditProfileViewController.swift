//
//  EditProfileViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var btnBackView: UIView!
    
    
    
    @IBOutlet weak var sloganView: UIView!
   
    @IBOutlet weak var lblSlogan: UILabel!
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoImg: UIImageView!
    
    @IBOutlet weak var btnEditImage: UIButton!
    
    @IBOutlet weak var btnKnowledge: UIButton!
    @IBOutlet weak var btnMyPost: UIButton!
    @IBOutlet weak var btnTapssayaRecord: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    
    
    @IBOutlet weak var btnChangePasswordText: UIButton!
    @IBOutlet weak var btnMyPostText: UIButton!
    @IBOutlet weak var btnTapssayaRecordText: UIButton!
    @IBOutlet weak var btnKnowledgeText: UIButton!
    
    @IBOutlet weak var lblTextSlogan: UILabel!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblFatherName: UILabel!
    @IBOutlet weak var lblHusbandWifeName: UILabel!
    
    @IBOutlet weak var lblKids1: UILabel!
    @IBOutlet weak var lblKids2: UILabel!
    @IBOutlet weak var lblKids3: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblReligion: UILabel!
    @IBOutlet weak var lblSubgroup: UILabel!
    @IBOutlet weak var lblSampradhay: UILabel!
    @IBOutlet weak var lblBankAccNumber: UILabel!
    @IBOutlet weak var lblIfsc: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblWork: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCity: UILabel!
   
    
    @IBOutlet weak var txtSlogan: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtFatherName: UITextField!
    @IBOutlet weak var txtHusbandName: UITextField!
    @IBOutlet weak var txtKids1: UITextField!
    @IBOutlet weak var txtKids2: UITextField!
    @IBOutlet weak var txtKids3: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtReligion: UITextField!
    @IBOutlet weak var txtSampradhay: UITextField!
    @IBOutlet weak var txtSubgroup: UITextField!
    @IBOutlet weak var txtBankAccNum: UITextField!
    @IBOutlet weak var txtIfsc: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtWork: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var mainTopView: UIView!
    
    
    var member_id = String()
    var guru_id = String()
    var guru_name = String()
    var main_group_id = String()
    var main_group_name = String()
    var sub_group_id = String()
    var sub_group_name = String()
    var member_name = String()
    var gender = String()
    var dob = String()
    var anniversary = String()
    var email_id = String()
    var country_id = String()
    var country = String()
    var state_id = String()
    var state = String()
    var account_number = String()
    var ifsc = String()
    var bank_name = String()
    var city_id = String()
    var member_city = String()
    var member_type = String()
    var contact = String()
    var work = String()
    var fathers_name = String()
    var mothers_name = String()
    var wife_name = String()
    var kids1_name = String()
    var kids2_name = String()
    var kids3_name = String()
    var knowledge = String()
    var slogan = String()
    var religion = String()
    var profile_image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Edit Profile"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:7,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
       // mainBackground.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:120)
        
        sloganView.frame = CGRect(x:10,y:10,width:view.frame.width-20,height:150)
        lblSlogan.frame = CGRect(x:10,y:0,width:sloganView.frame.width-20,height:25)
        
        btnBackView.frame = CGRect(x:self.sloganView.frame.width-70,y:80,width:60,height:60)
        btnEditImage.frame = CGRect(x:15,y:15,width:30,height:30)
        btnEditImage.addTarget(self, action: #selector(gotToEditImage), for: UIControlEvents.touchUpInside)
        
        btnBackView.addSubview(btnEditImage)
        
        sloganView.addSubview(lblSlogan)
        sloganView.addSubview(btnBackView)
        
        
        photoView.frame = CGRect(x:self.view.frame.width/2 - 40,y:100,width:120,height:120)
        photoImg.frame = CGRect(x:0,y:0,width:photoView.frame.width,height:photoView.frame.width)
        
        photoView.addSubview(photoImg)
        
        
        let pageWidth : CGFloat = self.view.frame.width/4
        btnChangePassword.setFAIcon(icon: .FAEdit, iconSize: 35, forState: .normal)
        btnChangePassword.frame = CGRect(x:0,y:photoView.frame.origin.y+photoView.frame.height+10,width:pageWidth,height:55)
        
      //  btnChangePassword.addTarget(self, action: #selector(gotoChangePassword), for: UIControlEvents.touchUpInside)
        
        btnKnowledge.setFAIcon(icon: .FABookmark, iconSize: 35, forState: .normal)
        btnKnowledge.frame = CGRect(x:pageWidth,y:photoView.frame.origin.y+photoView.frame.height+10,width:pageWidth,height:55)
        
        btnMyPost.setFAIcon(icon: .FACertificate, iconSize: 35, forState: .normal)
        btnMyPost.frame = CGRect(x:pageWidth*2,y:photoView.frame.origin.y+photoView.frame.height+10,width:pageWidth,height:55)
        
        btnTapssayaRecord.setFAIcon(icon: .FAAddressCard, iconSize: 35, forState: .normal)
        btnTapssayaRecord.frame = CGRect(x:pageWidth*3,y:photoView.frame.origin.y+photoView.frame.height+10,width:pageWidth,height:55)
        
        
        btnChangePasswordText.frame = CGRect(x:0,y:photoView.frame.origin.y+photoView.frame.height+45,width:pageWidth,height:40)
        btnKnowledgeText.frame = CGRect(x:pageWidth,y:photoView.frame.origin.y+photoView.frame.height+45,width:pageWidth,height:40)
        btnMyPostText.frame = CGRect(x:pageWidth*2,y:photoView.frame.origin.y+photoView.frame.height+45,width:pageWidth,height:40)
        btnTapssayaRecordText.frame = CGRect(x:pageWidth*3,y:photoView.frame.origin.y+photoView.frame.height+45,width:pageWidth,height:40)
        
        btnKnowledge.addTarget(self, action: #selector(gotToKnowledge), for: UIControlEvents.touchUpInside)
        btnKnowledgeText.addTarget(self, action: #selector(gotToKnowledge), for: UIControlEvents.touchUpInside)
        btnMyPostText.addTarget(self, action: #selector(gotToPost(_:)), for: UIControlEvents.touchUpInside)
        btnMyPost.addTarget(self, action: #selector(gotToPost(_:)), for: UIControlEvents.touchUpInside)
        
        btnChangePasswordText.addTarget(self, action: #selector(gotoChangePassword(_:)), for: UIControlEvents.touchUpInside)
        btnTapssayaRecord.addTarget(self, action: #selector(gotToMyTap(_:)), for: UIControlEvents.touchUpInside)
        btnTapssayaRecordText.addTarget(self, action: #selector(gotToMyTap(_:)), for: UIControlEvents.touchUpInside)
        
     
        lblTextSlogan.frame = CGRect(x:10,y:btnChangePasswordText.frame.origin.y+btnChangePasswordText.frame.height+20,width:self.view.frame.width-20,height:25)
        txtSlogan.frame = CGRect(x:10,y:lblTextSlogan.frame.origin.y+lblTextSlogan.frame.height+10,width:self.view.frame.width-20,height:50)
        
    
        
        lblFullName.frame = CGRect(x:10,y:txtSlogan.frame.origin.y+txtSlogan.frame.height+13,width:self.view.frame.width-20,height:25)
       
        txtFullName.frame = CGRect(x:10,y:lblFullName.frame.origin.y+lblFullName.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        lblFatherName.frame = CGRect(x:10,y:txtFullName.frame.origin.y+txtFullName.frame.height+13,width:self.view.frame.width-20,height:25)
        txtFatherName.frame = CGRect(x:10,y:lblFatherName.frame.origin.y+lblFatherName.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblHusbandWifeName.frame = CGRect(x:10,y:txtFatherName.frame.origin.y+txtFatherName.frame.height+13,width:self.view.frame.width-20,height:25)
        txtHusbandName.frame = CGRect(x:10,y:lblHusbandWifeName.frame.origin.y+lblHusbandWifeName.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblKids1.frame = CGRect(x:10,y:txtHusbandName.frame.origin.y+txtHusbandName.frame.height+13,width:self.view.frame.width-20,height:25)
        txtKids1.frame = CGRect(x:10,y:lblKids1.frame.origin.y+lblKids1.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblKids2.frame = CGRect(x:10,y:txtKids1.frame.origin.y+txtKids1.frame.height+13,width:self.view.frame.width-20,height:25)
        txtKids2.frame = CGRect(x:10,y:lblKids2.frame.origin.y+lblKids2.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblKids3.frame = CGRect(x:10,y:txtKids2.frame.origin.y+txtKids2.frame.height+13,width:self.view.frame.width-20,height:25)
        txtKids3.frame = CGRect(x:10,y:lblKids3.frame.origin.y+lblKids3.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblDob.frame = CGRect(x:10,y:txtKids3.frame.origin.y+txtKids3.frame.height+13,width:self.view.frame.width-20,height:25)
        txtDob.frame = CGRect(x:10,y:lblDob.frame.origin.y+lblDob.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblReligion.frame = CGRect(x:10,y:txtDob.frame.origin.y+txtDob.frame.height+13,width:self.view.frame.width-20,height:25)
        txtReligion.frame = CGRect(x:10,y:lblReligion.frame.origin.y+lblReligion.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblSampradhay.frame = CGRect(x:10,y:txtReligion.frame.origin.y+txtReligion.frame.height+13,width:self.view.frame.width-20,height:25)
        txtSampradhay.frame = CGRect(x:10,y:lblSampradhay.frame.origin.y+lblSampradhay.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblSubgroup.frame = CGRect(x:10,y:txtSampradhay.frame.origin.y+txtSampradhay.frame.height+13,width:self.view.frame.width-20,height:25)
        txtSubgroup.frame = CGRect(x:10,y:lblSubgroup.frame.origin.y+lblSubgroup.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblBankAccNumber.frame = CGRect(x:10,y:txtSubgroup.frame.origin.y+txtSubgroup.frame.height+13,width:self.view.frame.width-20,height:25)
        txtBankAccNum.frame = CGRect(x:10,y:lblBankAccNumber.frame.origin.y+lblBankAccNumber.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblIfsc.frame = CGRect(x:10,y:txtBankAccNum.frame.origin.y+txtBankAccNum.frame.height+13,width:self.view.frame.width-20,height:25)
        txtIfsc.frame = CGRect(x:10,y:lblIfsc.frame.origin.y+lblIfsc.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblBankName.frame = CGRect(x:10,y:txtIfsc.frame.origin.y+txtIfsc.frame.height+13,width:self.view.frame.width-20,height:25)
        txtBankName.frame = CGRect(x:10,y:lblBankName.frame.origin.y+lblBankName.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblMobile.frame = CGRect(x:10,y:txtBankName.frame.origin.y+txtBankName.frame.height+13,width:self.view.frame.width-20,height:25)
        txtMobile.frame = CGRect(x:10,y:lblMobile.frame.origin.y+lblMobile.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblWork.frame = CGRect(x:10,y:txtMobile.frame.origin.y+txtMobile.frame.height+13,width:self.view.frame.width-20,height:25)
        txtWork.frame = CGRect(x:10,y:lblWork.frame.origin.y+lblWork.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        lblCountry.frame = CGRect(x:10,y:txtWork.frame.origin.y+txtWork.frame.height+13,width:self.view.frame.width-20,height:25)
        txtCountry.frame = CGRect(x:10,y:lblCountry.frame.origin.y+lblCountry.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblState.frame = CGRect(x:10,y:txtCountry.frame.origin.y+txtCountry.frame.height+13,width:self.view.frame.width-20,height:25)
        txtState.frame = CGRect(x:10,y:lblState.frame.origin.y+lblState.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        
        lblCity.frame = CGRect(x:10,y:txtState.frame.origin.y+txtState.frame.height+13,width:self.view.frame.width-20,height:25)
        txtCity.frame = CGRect(x:10,y:lblCity.frame.origin.y+lblCity.frame.height+10,width:self.view.frame.width-20,height:50)
        
        
        
        btnSave.frame = CGRect(x:10,y:txtCity.frame.origin.y+txtCity.frame.height+20,width:self.view.frame.width-20-20,height:50)
        
        
          getUserProfileData()
        
        // Do any additional setup after loading the view.
    }
    
    func getUserProfileData(){
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_user_profile)!
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
                   
                    let Status = json?.object(forKey: "message") as? String;
                    if (Status == "success")
                    {
                        
                        
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            let jobData = json?.object(forKey: "result") as? [NSDictionary]
                            //for i in 0..<jobData!.count{
                            let jsonObject = jobData?[0]
                            
                            // let member_name = jsonObject?.object(forKey: "member_name") as? String
                            
                            self.member_id = (jsonObject?.object(forKey: "member_id") as? String)!;
                            self.guru_id = (jsonObject?.object(forKey: "guru_id") as? String)!;
                            let guruName = jsonObject?.object(forKey: "guru_name") as? String
                            if(guruName == nil){
                                
                            }else{
                                self.guru_name = guruName!
                            }
                            let maingroup_id = jsonObject?.object(forKey: "main_group_id") as? String
                            if(maingroup_id == nil){
                                
                            }else{
                                self.main_group_id = maingroup_id!
                            }
                            let subgroup_id = jsonObject?.object(forKey: "sub_group_id") as? String
                            if(subgroup_id == nil){
                                
                            }else{
                                self.sub_group_id = subgroup_id!
                            }
                            let subgroup_name = jsonObject?.object(forKey: "sub_group_name") as? String
                            if(subgroup_name == nil){
                                
                            }else{
                                self.sub_group_name = subgroup_name!
                                self.lblSubgroup.text = "Subgroup :" + self.sub_group_name
                                // self.lblSubgroup.attributedText = self.attributedString(from: "Subgroup :", nonBoldRange: NSMakeRange(10, self.sub_group_name.utf16.count))
                            }
                            
                            let membername = jsonObject?.object(forKey: "member_name") as? String
                            if(membername == nil){
                                
                            }else{
                                self.member_name = membername!
                                self.lblFullName.text = self.member_name
                                self.lblFullName.text = "Full Name : " + self.member_name
                                //self.lblFullName.attributedText = self.attributedString(from: "Full Name :"+self.member_name, nonBoldRange: NSMakeRange(11,self.member_name.utf16.count))
                            }
                            
                            let genderD = jsonObject?.object(forKey: "gender") as? String
                            if(genderD == nil){
                                
                            }else{
                                self.gender = genderD!
                                
                                
                            }
                            
                            let dobd = jsonObject?.object(forKey: "dob") as? String
                            if(dobd == nil){
                                
                            }else{
                                self.dob = dobd!
                                self.lblDob.text = "Dob : " + self.dob
                                // self.lblDob.attributedText = self.attributedString(from: "Dob : ", nonBoldRange: NSMakeRange(6, self.dob.utf16.count))
                            }
                            
                            let anniversaryy = jsonObject?.object(forKey: "anniversary") as? String
                            if(anniversaryy == nil){
                                
                            }else{
                                self.anniversary = anniversaryy!
                            }
                            let countryid = jsonObject?.object(forKey: "country_id") as? String
                            if(countryid == nil){
                                
                            }else{
                                self.country_id = countryid!
                            }
                            let country1 = jsonObject?.object(forKey: "country") as? String
                            if(country1 != nil){
                                self.lblCountry.text = "Country : "
                            }else{
                                self.country = country1!
                                self.lblCountry.text = "Country : " + self.country
                                // self.lblCountry.attributedText = self.attributedString(from: "Country :", nonBoldRange: NSMakeRange(10, self.country.utf16.count))
                            }
                            
                            let stateid = jsonObject?.object(forKey: "state_id") as? String
                            if(stateid == nil){
                                
                            }else{
                                self.state_id = stateid!
                            }
                            
                            let statee = jsonObject?.object(forKey: "state") as? String
                            if(statee == nil){
                                
                            }else{
                                self.state = statee!
                                self.lblState.text = "State : " + self.state
                                //self.lblState.attributedText = self.attributedString(from: "State :", nonBoldRange: NSMakeRange(7, self.state.utf16.count))
                            }
                            
                            let accountnumber = jsonObject?.object(forKey: "account_number") as? String
                            if(accountnumber == nil){
                                
                            }else{
                                self.account_number = accountnumber!
                            }
                            let ifscc = jsonObject?.object(forKey: "ifsc") as? String
                            if(ifscc == nil){
                                
                            }else{
                                self.ifsc = ifscc!
                            }
                            let bankname = jsonObject?.object(forKey: "bank_name") as? String
                            if(bankname == nil){
                                
                            }else{
                                self.bank_name = bankname!
                            }
                            
                            let cityid = jsonObject?.object(forKey: "city_id") as? String
                            if(cityid == nil){
                                
                            }else{
                                self.city_id = cityid!
                            }
                            
                            let profileimage = jsonObject?.object(forKey: "profile_image") as? String
                            if(profileimage == nil){
                                
                            }else{
                                self.profile_image = profileimage!
                                let url = URL(string:self.profile_image)
                                let placeholderImage = UIImage(named: "profile")!
                                self.photoImg.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                            }
                            
                            
                            
                            let membercity = jsonObject?.object(forKey: "member_city") as? String
                            if(membercity == nil){
                                
                            }else{
                                self.member_city = membercity!
                                self.lblCity.text =  "City : "+self.member_city
                                // self.lblCity.attributedText = self.attributedString(from: "City :", nonBoldRange: NSMakeRange(6, self.member_city.utf16.count))
                            }
                            let contactt = jsonObject?.object(forKey: "contact") as? String
                            if(contactt == nil){
                                
                            }else{
                                self.contact = contactt!
                                //self.lblMobile.attributedText = self.attributedString(from: "Mobile :", nonBoldRange: NSMakeRange(8, self.contact.utf16.count))
                            }
                            let workk = jsonObject?.object(forKey: "work") as? String
                            if(workk == nil){
                                
                            }else{
                                self.work = workk!
                                self.lblWork.text = "Work : "+self.work
                                // self.lblWork.attributedText = self.attributedString(from: "Work :", nonBoldRange: NSMakeRange(6, self.work.utf16.count))
                            }
                            let fathersname = jsonObject?.object(forKey: "fathers_name") as? String
                            if(fathersname == nil){
                                
                            }else{
                                self.fathers_name = fathersname!
                                self.lblFatherName.text = "Fathers Name : "+self.fathers_name
                                // self.lblFatherName.attributedText = self.attributedString(from: "Fathers Name :", nonBoldRange: NSMakeRange(14,self.fathers_name.utf16.count))
                            }
                            
                            let mothersname = jsonObject?.object(forKey: "mothers_name") as? String
                            if(mothersname == nil){
                                
                            }else{
                                self.mothers_name = mothersname!
                            }
                            
                            let wifename = jsonObject?.object(forKey: "wife_name") as? String
                            if(wifename == nil){
                                
                            }else{
                                self.wife_name = wifename!
                                self.lblHusbandWifeName.text = "Husband Wife/Name : "+self.wife_name
                                // self.lblHusbandWifeName.attributedText = self.attributedString(from: "Husband Wife/Name :", nonBoldRange: NSMakeRange(19, self.wife_name.utf16.count))
                            }
                            
                            let kids1name = jsonObject?.object(forKey: "kids1_name") as? String
                            if(kids1name == nil){
                                
                            }else{
                                self.kids1_name = kids1name!
                                self.lblKids1.text = "Kids1 Name : " + self.kids1_name
                                // self.lblKids1.attributedText = self.attributedString(from: "Kids1 Name :", nonBoldRange: NSMakeRange(12, self.kids1_name.utf16.count))
                            }
                            let kids2name = jsonObject?.object(forKey: "kids2_name") as? String
                            if(kids2name == nil){
                                
                            }else{
                                self.kids2_name = kids2name!
                                self.lblKids2.text = "Kids2 Name : "+self.kids2_name
                                // self.lblKids2.attributedText = self.attributedString(from: "Kids2 Name :", nonBoldRange: NSMakeRange(12,  self.kids2_name.utf16.count))
                            }
                            let kids3name = jsonObject?.object(forKey: "kids3_name") as? String
                            if(kids3name == nil){
                                
                            }else{
                                self.kids3_name = kids3name!
                                self.lblKids3.text = "Kids3 Name : "+self.kids3_name
                                
                            }
                            let knowledgee = jsonObject?.object(forKey: "knowledge") as? String
                            if(knowledgee == nil){
                                
                            }else{
                                self.knowledge = knowledgee!
                                
                            }
                            let slogann = jsonObject?.object(forKey: "slogan") as? String
                            if(slogann == nil){
                                
                            }else{
                                self.slogan = slogann!
                            }
                            let religionn = jsonObject?.object(forKey: "religion") as? String
                            if(religionn == nil){
                                
                            }else{
                                self.religion = religionn!
                                
                            }
                            
                            
                        }
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
    
    
    @objc func gotoChangePassword(_ sender : UIButton){
        self.performSegue(withIdentifier: "changePassIdentifier", sender: self)
    }
    
    @IBAction func btnChangePassClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "changePassIdentifier", sender: self)
    }
    
    
   
    
   @objc func gotToPost(_ sender : UIButton)
    {
        let gotoMyPost = storyboard?.instantiateViewController(withIdentifier: "myPostCntrStory") as! MypostCntr
        self.navigationController?.pushViewController(gotoMyPost, animated: true)
    }
    @objc func gotToKnowledge(_ sender : UIButton)
    {
        let gotoKnowlegde = storyboard?.instantiateViewController(withIdentifier: "myKnowledgeCntrStory") as! KnowledgeCntr
        self.navigationController?.pushViewController(gotoKnowlegde, animated: true)
    }
    @objc func gotToMyTap(_ sender : UIButton)
    {
        let myTapRecordStory = storyboard?.instantiateViewController(withIdentifier: "myTapRecordStory") as! TapssayRecordCntr
        self.navigationController?.pushViewController(myTapRecordStory, animated: true)
    }

    @objc func gotToEditImage(_ sender : UIButton)
    {
        let editImage = storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as! OtherImageUploadCntr
        editImage.whatToUpload = "Profile"
        self.navigationController?.pushViewController(editImage, animated: true)
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
