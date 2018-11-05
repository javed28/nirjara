//
//  NewProfileViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import SMSegmentView

class NewProfileViewController: UIViewController {
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUserPic: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!

    @IBOutlet weak var profileBanner: UIImageView!
    
     var segmentView: SMSegmentView!
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var knowledgeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        let myString:NSString = "  Profile"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points : 0", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
        addShadowToBar()
        aboutView.isHidden = true
        knowledgeView.isHidden = true
        tapView.isHidden = true
        lblName.text = UserDefaults.standard.getMemberName()
        
        
        profileBanner.frame = CGRect(x:0,y:topbarHeight+6,width:view.frame.width, height: 160)
        lblName.frame = CGRect(x:0,y:topbarHeight+135,width:view.frame.width-175, height: 30)
        imgUserPic.frame = CGRect(x:view.frame.width-160,y:topbarHeight+40,width:120, height: 120)
        btnEdit.frame = CGRect(x:view.frame.width-50,y:topbarHeight+30,width:22, height: 22)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgUserPic.isUserInteractionEnabled = true
        imgUserPic.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        let appearance = SMSegmentAppearance()
        appearance.segmentOnSelectionColour = UIColor.rgb(hexcolor: GlobalVariables.orangeColor)
        appearance.segmentOffSelectionColour = UIColor.white
        appearance.titleOnSelectionFont = UIFont.systemFont(ofSize: 12.0)
        appearance.titleOffSelectionFont = UIFont.systemFont(ofSize: 12.0)
        appearance.contentVerticalMargin = 10.0
        
        
        /*
         Init SMsegmentView
         Set divider colour and width here if there is a need
         */
        let segmentFrame = CGRect(x: 0, y: profileBanner.frame.height+profileBanner.frame.origin.y+5, width: self.view.frame.size.width, height: 45.0)
        self.segmentView = SMSegmentView(frame: segmentFrame, dividerColour: UIColor(white: 0.95, alpha: 0.3), dividerWidth: 1.0, segmentAppearance: appearance)
        self.segmentView.backgroundColor = UIColor.clear
        
        self.segmentView.layer.cornerRadius = 5.0
        self.segmentView.layer.borderColor = UIColor.rgb(hexcolor: GlobalVariables.orangeColor).cgColor
        self.segmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("Posts".localized1, onSelectionImage: UIImage(named: "post_white"), offSelectionImage: UIImage(named: "post_gray"))
        self.segmentView.addSegmentWithTitle("About", onSelectionImage: UIImage(named: "about_white"), offSelectionImage: UIImage(named: "about_gray"))
        self.segmentView.addSegmentWithTitle("Knowledge".localized1, onSelectionImage: UIImage(named: "book_white"), offSelectionImage: UIImage(named: "book_gray"))
        self.segmentView.addSegmentWithTitle("Tap".localized1+" "+"Record".localized1, onSelectionImage: UIImage(named: "tap_record_white"), offSelectionImage: UIImage(named: "tap_record_gray"))
        
        self.segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        
        // Set segment with index 0 as selected by default
        self.segmentView.selectedSegmentIndex = 0
        self.view.addSubview(self.segmentView)
        
        let removeFromBottom : CGFloat = view.frame.height-280
        
        galleryView.frame = CGRect(x:0,y:segmentView.frame.height+segmentView.frame.origin.y+5,width:view.frame.width, height:removeFromBottom)
        aboutView.frame = CGRect(x:0,y:segmentView.frame.height+segmentView.frame.origin.y+5,width:view.frame.width, height: removeFromBottom)
        knowledgeView.frame = CGRect(x:0,y:segmentView.frame.height+segmentView.frame.origin.y+5,width:view.frame.width, height: removeFromBottom)
        tapView.frame = CGRect(x:0,y:segmentView.frame.height+segmentView.frame.origin.y+5,width:view.frame.width, height: removeFromBottom)
        
        
//        segmentCntr.setTitle("Posts".localized1, forSegmentAt: 0)
//        segmentCntr.setTitle("About".localized1, forSegmentAt: 1)
//        segmentCntr.setTitle("Knowledge".localized1, forSegmentAt: 2)
//        segmentCntr.setTitle("Tap".localized1+" "+"Record".localized1, forSegmentAt: 3)
       
        sideMenu()
        getProfileData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        btnEdit.alpha = 0
        let placeholderImage = UIImage(named: "default-icon")!
        if(GlobalVariables.profileImage == nil || GlobalVariables.profileImage == ""){
            self.imgUserPic.image = placeholderImage
            
        }else{
            
            let url = URL(string:GlobalVariables.profileImage)
            self.imgUserPic.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        btnEdit.alpha = 1
        // Your action
    }
    @objc func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        /*
         Replace the following line to implement what you want the app to do after the segment gets tapped.
         */
        print("Select segment at index: \(segmentView.selectedSegmentIndex)")
                switch (segmentView.selectedSegmentIndex) {
                case 0:
                    galleryView.isHidden = false
                    aboutView.isHidden = true
                    knowledgeView.isHidden = true
                    tapView.isHidden = true
                    break
                case 1:
                    aboutView.isHidden = false
                    galleryView.isHidden = true
                    knowledgeView.isHidden = true
                    tapView.isHidden = true
                    break
                case 2:
                    knowledgeView.isHidden = false
                    galleryView.isHidden = true
                    aboutView.isHidden = true
                    tapView.isHidden = true
                    break
                case 3:
                    tapView.isHidden = false
                    galleryView.isHidden = true
                    aboutView.isHidden = true
                    knowledgeView.isHidden = true
        
                    break
                default:
                    break
                }
    }
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        /*
         MARK: Replace the following line to your own frame setting for segmentView.
         */
        if toInterfaceOrientation == UIInterfaceOrientation.landscapeLeft || toInterfaceOrientation == UIInterfaceOrientation.landscapeRight {
            
            self.segmentView.organiseMode = .vertical
            if let appearance = self.segmentView.segmentAppearance {
                appearance.contentVerticalMargin = 25.0
            }
            self.segmentView.frame = CGRect(x: self.view.frame.size.width/2 - 40.0, y: 100.0, width: 80.0, height: 220.0)
        }
        else {
            
            self.segmentView.organiseMode = .horizontal
            if let appearance = self.segmentView.segmentAppearance {
                appearance.contentVerticalMargin = 10.0
            }
            self.segmentView.frame = CGRect(x: 0, y: 120.0, width: self.view.frame.size.width, height: 40.0)
            
        }
    }

    @IBAction func btnEditClicked(_ sender: Any) {
        let editImage = storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as! OtherImageUploadCntr
        editImage.whatToUpload = "Profile"
        self.navigationController?.pushViewController(editImage, animated: true)
    }
//     func segmentClicked(_ sender: Any) {
//
//        switch (segmentCntr.selectedSegmentIndex) {
//        case 0:
//            galleryView.isHidden = false
//            aboutView.isHidden = true
//            knowledgeView.isHidden = true
//            tapView.isHidden = true
//            break
//        case 1:
//            aboutView.isHidden = false
//            galleryView.isHidden = true
//            knowledgeView.isHidden = true
//            tapView.isHidden = true
//            break
//        case 2:
//            knowledgeView.isHidden = false
//            galleryView.isHidden = true
//            aboutView.isHidden = true
//            tapView.isHidden = true
//            break
//        case 3:
//            tapView.isHidden = false
//            galleryView.isHidden = true
//            aboutView.isHidden = true
//            knowledgeView.isHidden = true
//
//            break
//        default:
//            break
//        }
//    }
    func getProfileData(){
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_user_profile)!
        print("NEw Profile--",parameters)
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
                print("Profile Data--",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    
                   DispatchQueue.main.async {
                        let jobData = json?.object(forKey: "result") as? [NSDictionary]
                        let jsonObject = jobData?[0]
                        let name = jsonObject?.object(forKey: "member_name") as? String
                        let profile_image = jsonObject?.object(forKey: "profile_image") as? String
                    GlobalVariables.profileImage = profile_image!
                    let placeholderImage = UIImage(named: "default-icon")!
                    
                    self.lblName.text = name
                    if(profile_image == nil || profile_image == ""){
                        self.imgUserPic.image = placeholderImage
                       
                    }else{
                        
                        let url = URL(string:profile_image!)
                        self.imgUserPic.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                    }
                    
                    if(jsonObject?.object(forKey: "main_group_id") as? String == "null" || jsonObject?.object(forKey: "main_group_id") as? String == nil){
                        
                    }else{
                        GlobalVariables.main_group_id = (jsonObject?.object(forKey: "main_group_id") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "main_group_name") as? String == "null" || jsonObject?.object(forKey: "main_group_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.main_group_name = (jsonObject?.object(forKey: "main_group_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "sub_group_id") as? String == "null" || jsonObject?.object(forKey: "sub_group_id") as? String == nil){
                        
                    }else{
                        GlobalVariables.sub_group_id = (jsonObject?.object(forKey: "sub_group_id") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "sub_group_name") as? String == "null" || jsonObject?.object(forKey: "sub_group_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.sub_group_name = (jsonObject?.object(forKey: "sub_group_name") as? String)!
                    }
                    if(jsonObject?.object(forKey: "religion") as? String == "null" || jsonObject?.object(forKey: "religion") as? String == nil){
                        
                    }else{
                        GlobalVariables.religion = (jsonObject?.object(forKey: "religion") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "state_id") as? String == "null" || jsonObject?.object(forKey: "state_id") as? String == nil){
                        
                    }else{
                        GlobalVariables.state_id = (jsonObject?.object(forKey: "state_id") as? String)!
                    }
                    if(jsonObject?.object(forKey: "state_id") as? String == "null" || jsonObject?.object(forKey: "state_id") as? String == nil){
                        
                    }else{
                        GlobalVariables.state_id = (jsonObject?.object(forKey: "state_id") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "state") as? String == "null" || jsonObject?.object(forKey: "state") as? String == nil){
                        
                    }else{
                    GlobalVariables.state = (jsonObject?.object(forKey: "state") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "city_id") as? String == "null" || jsonObject?.object(forKey: "city_id") as? String == nil){
                        
                    }else{
                        GlobalVariables.city_id = (jsonObject?.object(forKey: "city_id") as? String)!
                    }
                    if(jsonObject?.object(forKey: "member_city") as? String == "null" || jsonObject?.object(forKey: "member_city") as? String == nil){
                        
                    }else{
                        GlobalVariables.member_city = (jsonObject?.object(forKey: "member_city") as? String)!
                    }
                    if(jsonObject?.object(forKey: "work") as? String == "null" || jsonObject?.object(forKey: "work") as? String == nil){
                        
                    }else{
                        GlobalVariables.work = (jsonObject?.object(forKey: "work") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "work_address") as? String == "null" || jsonObject?.object(forKey: "work_address") as? String == nil){
                        
                    }else{
                        GlobalVariables.work_address = (jsonObject?.object(forKey: "work_address") as? String)!
                    }
                    if(jsonObject?.object(forKey: "kids1_name") as? String == "null" || jsonObject?.object(forKey: "kids1_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.kids1_name = (jsonObject?.object(forKey: "kids1_name") as? String)!
                    }
                    if(jsonObject?.object(forKey: "kids2_name") as? String == "null" || jsonObject?.object(forKey: "kids2_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.kids2_name = (jsonObject?.object(forKey: "kids2_name") as? String)!
                    }
                    if(jsonObject?.object(forKey: "kids3_name") as? String == "null" || jsonObject?.object(forKey: "kids3_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.kids3_name = (jsonObject?.object(forKey: "kids3_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "kids3_name") as? String == "null" || jsonObject?.object(forKey: "kids3_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.kids3_name = (jsonObject?.object(forKey: "kids3_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "fathers_name") as? String == "null" || jsonObject?.object(forKey: "fathers_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.fathers_name = (jsonObject?.object(forKey: "fathers_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "mothers_name") as? String == "null" || jsonObject?.object(forKey: "mothers_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.mothers_name = (jsonObject?.object(forKey: "mothers_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "wife_name") as? String == "null" || jsonObject?.object(forKey: "wife_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.wife_name = (jsonObject?.object(forKey: "wife_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "bank_name") as? String == "null" || jsonObject?.object(forKey: "bank_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.bank_name = (jsonObject?.object(forKey: "bank_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "ifsc") as? String == "null" || jsonObject?.object(forKey: "ifsc") as? String == nil){
                        
                    }else{
                        GlobalVariables.ifsc = (jsonObject?.object(forKey: "ifsc") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "account_number") as? String == "null" || jsonObject?.object(forKey: "account_number") as? String == nil){
                        
                    }else{
                        GlobalVariables.account_number = (jsonObject?.object(forKey: "account_number") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "member_name") as? String == "null" || jsonObject?.object(forKey: "member_name") as? String == nil){
                        
                    }else{
                        GlobalVariables.member_name = (jsonObject?.object(forKey: "member_name") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "email_id") as? String == "null" || jsonObject?.object(forKey: "email_id") as? String == nil){
                        
                    }else{
                        GlobalVariables.email_id = (jsonObject?.object(forKey: "email_id") as? String)!
                    }
                    
                    if(jsonObject?.object(forKey: "contact") as? String == "null" || jsonObject?.object(forKey: "contact") as? String == nil){
                        
                    }else{
                        GlobalVariables.contact = (jsonObject?.object(forKey: "contact") as? String)!
                    }
                    if(jsonObject?.object(forKey: "dob") as? String == "null" || jsonObject?.object(forKey: "dob") as? String == nil){
                        
                    }else{
                        GlobalVariables.dob = (jsonObject?.object(forKey: "dob") as? String)!
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
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
