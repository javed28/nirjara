//
//  ProfileViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var sloganView: UIView!
    @IBOutlet weak var lblSlogan: UILabel!
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnKnowledge: UIButton!
    @IBOutlet weak var btnMyPost: UIButton!
    @IBOutlet weak var btnTapssayaRecord: UIButton!
    
    @IBOutlet weak var btnKnowledgeText: UIButton!
    @IBOutlet weak var btnTapssayaRecordText: UIButton!
    @IBOutlet weak var btnMyPostText: UIButton!
    @IBOutlet weak var btnEditText: UIButton!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblFatherName: UILabel!
    @IBOutlet weak var lblHusbandWifeName: UILabel!
    @IBOutlet weak var lblKids1: UILabel!
    @IBOutlet weak var lblKids2: UILabel!
    @IBOutlet weak var lblKids3: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblReligion: UILabel!
    @IBOutlet weak var lblSampradhay: UILabel!
    @IBOutlet weak var lblSubgroup: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblWork: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    
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
        var myString:NSString = "  Profile"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        // UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points : 0", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
        
        sloganView.frame = CGRect(x:0,y:10,width:self.view.frame.width-20,height:150)
        lblSlogan.frame = CGRect(x:10,y:10,width:sloganView.frame.width,height:25)
        
        sloganView.addSubview(lblSlogan)
        
        photoView.frame = CGRect(x:mainBackground.frame.width/2 - 40,y:100,width:120,height:120)
      
        photoView.layer.cornerRadius = photoView.bounds.size.width / 2.0
        photoView.clipsToBounds = true
        
        photoImg.frame = CGRect(x:0,y:0,width:photoView.frame.width,height:photoView.frame.width)
        
        photoView.addSubview(photoImg)
        lblName.frame = CGRect(x:20,y:photoView.frame.origin.y+photoView.frame.height+15,width:self.view.frame.width-40,height:25)
        
        let pageWidth : CGFloat = self.view.frame.width/4
        btnEdit.setFAIcon(icon: .FAEdit, iconSize: 35, forState: .normal)
        btnEdit.frame = CGRect(x:0,y:lblName.frame.origin.y+lblName.frame.height+10,width:pageWidth,height:55)
        
        btnKnowledge.setFAIcon(icon: .FABookmark, iconSize: 35, forState: .normal)
        btnKnowledge.frame = CGRect(x:pageWidth,y:lblName.frame.origin.y+lblName.frame.height+10,width:pageWidth,height:55)
        
         btnMyPost.setFAIcon(icon: .FACertificate, iconSize: 35, forState: .normal)
        btnMyPost.frame = CGRect(x:pageWidth*2,y:lblName.frame.origin.y+lblName.frame.height+10,width:pageWidth,height:55)
        
         btnTapssayaRecord.setFAIcon(icon: .FAAddressCard, iconSize: 35, forState: .normal)
        btnTapssayaRecord.frame = CGRect(x:pageWidth*3,y:lblName.frame.origin.y+lblName.frame.height+10,width:pageWidth,height:55)
        
        
        btnEditText.frame = CGRect(x:0,y:lblName.frame.origin.y+lblName.frame.height+45,width:pageWidth,height:40)
        btnKnowledgeText.frame = CGRect(x:pageWidth,y:lblName.frame.origin.y+lblName.frame.height+45,width:pageWidth,height:40)
        btnMyPostText.frame = CGRect(x:pageWidth*2,y:lblName.frame.origin.y+lblName.frame.height+45,width:pageWidth,height:40)
        btnTapssayaRecordText.frame = CGRect(x:pageWidth*3,y:lblName.frame.origin.y+lblName.frame.height+45,width:pageWidth-20,height:40)
        
        btnTapssayaRecordText.titleLabel?.lineBreakMode = .byWordWrapping;
        btnTapssayaRecordText.titleLabel?.textAlignment = .center;
    
        
       lblFullName.frame = CGRect(x:0,y:btnEditText.frame.origin.y+btnEditText.frame.height+20,width:self.mainBackground.frame.width,height:30)
        
        //lblFullName.sizeToFit()
        
        
        lblFatherName.frame = CGRect(x:0,y:lblFullName.frame.origin.y+lblFullName.frame.height+15,width:self.mainBackground.frame.width,height:30)
      
        //lblFatherName.sizeToFit()
        
        lblHusbandWifeName.frame = CGRect(x:0,y:lblFatherName.frame.origin.y+lblFatherName.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblHusbandWifeName.sizeToFit()
        
        
        lblKids1.frame = CGRect(x:0,y:lblHusbandWifeName.frame.origin.y+lblHusbandWifeName.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblKids1.sizeToFit()
        
        
        lblKids2.frame = CGRect(x:0,y:lblKids1.frame.origin.y+lblKids1.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
        //lblKids2.sizeToFit()
        
        
        lblKids3.frame = CGRect(x:0,y:lblKids2.frame.origin.y+lblKids2.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblKids3.sizeToFit()
        
        
        lblDob.frame = CGRect(x:0,y:lblKids3.frame.origin.y+lblKids3.frame.height+15,width:self.mainBackground.frame.width,height:30)
       
       // lblDob.sizeToFit()
        
        lblReligion.frame = CGRect(x:0,y:lblDob.frame.origin.y+lblDob.frame.height+15,width:self.mainBackground.frame.width,height:30)
        lblReligion.text = "Religion"
      //  lblReligion.attributedText = attributedString(from: "Religion : ", nonBoldRange: NSMakeRange(11, 5))
       // lblReligion.sizeToFit()
        
        lblSampradhay.frame = CGRect(x:0,y:lblReligion.frame.origin.y+lblReligion.frame.height+15,width:self.mainBackground.frame.width,height:30)
        lblSampradhay.text = "Sampradhay"
        //lblSampradhay.attributedText = attributedString(from: "Sampradhay : ", nonBoldRange: NSMakeRange(13, 5))
       // lblSampradhay.sizeToFit()
        
        lblSubgroup.frame = CGRect(x:0,y:lblSampradhay.frame.origin.y+lblSampradhay.frame.height+15,width:self.mainBackground.frame.width,height:30)
       
       // lblSubgroup.sizeToFit()
        
        lblMobile.frame = CGRect(x:0,y:lblSubgroup.frame.origin.y+lblSubgroup.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblMobile.sizeToFit()
        
        lblWork.frame = CGRect(x:0,y:lblMobile.frame.origin.y+lblMobile.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblWork.sizeToFit()
        
        
        lblCountry.frame = CGRect(x:0,y:lblWork.frame.origin.y+lblWork.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblCountry.sizeToFit()
       
        
        lblState.frame = CGRect(x:0,y:lblCountry.frame.origin.y+lblCountry.frame.height+15,width:self.mainBackground.frame.width,height:30)
       
        //lblState.sizeToFit()
        
        
        lblCity.frame = CGRect(x:0,y:lblState.frame.origin.y+lblState.frame.height+15,width:self.mainBackground.frame.width,height:30)
        
       // lblCity.sizeToFit()
        
    
        
        
        mainBackground.addSubview(sloganView)
        mainBackground.addSubview(photoView)
        mainBackground.addSubview(lblName)
        mainBackground.addSubview(btnEdit)
        mainBackground.addSubview(btnKnowledge)
        mainBackground.addSubview(btnMyPost)
        mainBackground.addSubview(btnKnowledgeText)
        mainBackground.addSubview(btnTapssayaRecordText)
        mainBackground.addSubview(btnEditText)
        mainBackground.addSubview(btnMyPostText)
        
        mainBackground.addSubview(lblFullName)
        mainBackground.addSubview(lblFatherName)
        mainBackground.addSubview(lblHusbandWifeName)
        mainBackground.addSubview(lblKids1)
        mainBackground.addSubview(lblKids2)
        mainBackground.addSubview(lblKids3)
        mainBackground.addSubview(lblDob)
        mainBackground.addSubview(lblReligion)
        mainBackground.addSubview(lblSampradhay)
        mainBackground.addSubview(lblSubgroup)
        mainBackground.addSubview(lblMobile)
        mainBackground.addSubview(lblWork)
        mainBackground.addSubview(lblCountry)
        mainBackground.addSubview(lblState)
        mainBackground.addSubview(lblCity)
        getUserProfileData()
        
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
                    print("sdadsa",json)
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
                            self.lblName.text = self.member_name
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
    
    func attributedString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let attrs = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        let nonBoldAttribute = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            // menuButton.image  = UIImage(named:"hamburger")?.withRenderingMode(.alwaysOriginal);
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 180
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
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
