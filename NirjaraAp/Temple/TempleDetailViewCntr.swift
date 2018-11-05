//
//  TempleDetailViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/29/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import Social
import MessageUI
class TempleDetailViewCntr: UIViewController,MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!

    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnWhatsup: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!

    @IBOutlet weak var imgTemple: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    

    @IBOutlet weak var lblTempleName: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDescData: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddressData: UILabel!
    
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    
    @IBOutlet weak var lblFoodData: UILabel!
    @IBOutlet weak var lblFoodAvailable: UILabel!
    
    @IBOutlet weak var btnEditViewBack: UIView!
    
    @IBOutlet weak var lblStay: UILabel!
    @IBOutlet weak var lblStayData: UILabel!
    
    var templeData : templeSthanakModel = templeSthanakModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Temple Details"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:9,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
    
        
        imgTemple.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:210)
        
        btnEditViewBack.frame = CGRect(x:self.view.frame.width-70,y:160,width:50,height:50)
        btnEdit.frame = CGRect(x:12.5,y:12.5,width:25,height:25)
        btnEdit.addTarget(self, action: #selector(imageUpdate(_:)), for: UIControlEvents.touchUpInside)
        btnEditViewBack.addSubview(btnEdit)
        btnEditViewBack.layer.cornerRadius = 25
        lblTempleName.text = templeData.temple_name
        lblTempleName.numberOfLines = 0
        lblTempleName.lineBreakMode = .byWordWrapping;
        lblTempleName.frame = CGRect(x:10,y:imgTemple.frame.origin.y + imgTemple.frame.height+10,width:self.view.frame.width-20,height:lblTempleName.intrinsicContentSize.height)
        
        
        lblDesc.frame = CGRect(x:10,y:lblTempleName.frame.origin.y + lblTempleName.frame.height+10,width:self.view.frame.width-20,height:30)
        
        if(self.templeData.temple_info == ""){
            lblDescData.text = "No Data"
            lblDescData.numberOfLines = 1
            lblDescData.lineBreakMode = .byWordWrapping;
            lblDescData.frame = CGRect(x: 10, y: lblDesc.frame.origin.y + lblDesc.frame.height, width: self.view.frame.width-20, height: lblDescData.intrinsicContentSize.height)
        }else{
        let str = self.templeData.temple_info.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        lblDescData.text = str
        lblDescData.numberOfLines = 3
        lblDescData.lineBreakMode = .byWordWrapping;
        lblDescData.frame = CGRect(x: 10, y: lblDesc.frame.origin.y + lblDesc.frame.height, width: self.view.frame.width-20, height: lblDescData.intrinsicContentSize.height)
        }
        
        
        lblAddress.text = "Address".localized1+" : "
        lblAddress.frame = CGRect(x:10,y:lblDescData.frame.origin.y + lblDescData.frame.height+5,width:self.view.frame.width-20,height:30)
        
        
        
        
        
        if(self.templeData.location == ""){
            
            lblAddressData.text =  "No Address"
            lblAddressData.numberOfLines = 1
            lblAddressData.lineBreakMode = .byWordWrapping;
            lblAddressData.frame = CGRect(x:10,y:lblAddress.frame.origin.y + lblAddress.frame.height,width:self.view.frame.width-20,height:20)
        }else{
            if(self.templeData.location.count < 35){
                print("forsttt else---")
                lblAddressData.numberOfLines = 1
                lblAddressData.lineBreakMode = .byWordWrapping;
                lblAddressData.text =  self.templeData.location
                lblAddressData.frame = CGRect(x:10,y:lblAddress.frame.origin.y+lblAddress.frame.height,width:self.view.frame.width-20,height:20)
            }else if(self.templeData.location.count < 70){
                print("secondddd else----")
                lblAddressData.numberOfLines = 2
                lblAddressData.lineBreakMode = .byWordWrapping;
                lblAddressData.text =  self.templeData.location
                lblAddressData.frame = CGRect(x:10,y:lblAddress.frame.origin.y+lblAddress.frame.height,width:self.view.frame.width-20,height:40)
            }else{
                print("last else---")
                lblAddressData.numberOfLines = 3
                lblAddressData.lineBreakMode = .byWordWrapping;
                lblAddressData.text =  self.templeData.location
                lblAddressData.frame = CGRect(x:10,y:lblAddress.frame.origin.y+lblAddress.frame.height,width:self.view.frame.width-20,height:60)
            }
        }
        
        
        lblContact.text = "ContactNumber".localized1+" : "
        lblContact.frame = CGRect(x:10,y:lblAddressData.frame.origin.y + lblAddressData.frame.height+5,width:140,height:30)
        lblContactNo.frame = CGRect(x:130,y:lblAddressData.frame.origin.y + lblAddressData.frame.height+5,width:self.view.frame.width-20,height:30)
        if(self.templeData.contact == ""){
            lblContactNo.text =  "N/A"
        }else{
        lblContactNo.text =  self.templeData.contact
        }
        
        lblFoodAvailable.text = "FoodFacility".localized1+" : "
        lblFoodAvailable.frame = CGRect(x:10,y:lblContactNo.frame.origin.y+lblContactNo.frame.height+5,width:150,height:30)
        lblFoodData.frame = CGRect(x:125,y:lblContactNo.frame.origin.y+lblContactNo.frame.height+5,width:self.view.frame.width-80,height:30)
        lblFoodData.text =  self.templeData.food_available
        
        lblStay.text = "StayAvailable".localized1+" : "
        lblStay.frame = CGRect(x:10,y:lblFoodData.frame.origin.y+lblFoodData.frame.height+5,width:150,height:30)
        lblStayData.frame = CGRect(x:130,y:lblFoodData.frame.origin.y+lblFoodData.frame.height+5,width:self.view.frame.width-80,height:30)
        lblStayData.text =  self.templeData.stay_available
        
       
        let widthofCell : CGFloat = self.view.frame.width/5
        
        
        btnTwitter.frame = CGRect(x:5,y:lblStayData.frame.origin.y+lblStayData.frame.height+40,width:55,height:55)
        btnTwitter.setFAIcon(icon: .FATwitter, iconSize: 30, forState: .normal)
        btnTwitter.setFATitleColor(color: .white, forState: .normal)
        btnTwitter.addTarget(self, action: #selector(clickedTwitter(_:)), for: UIControlEvents.touchUpInside)
        
        btnFacebook.frame = CGRect(x:widthofCell+2,y:lblStayData.frame.origin.y+lblStayData.frame.height+40,width:55,height:55)
        btnFacebook.setFAIcon(icon: .FAFacebook, iconSize: 30, forState: .normal)
        btnFacebook.setFATitleColor(color: .white, forState: .normal)
        btnFacebook.addTarget(self, action: #selector(clickedFacbook(_:)), for: UIControlEvents.touchUpInside)
        
        btnWhatsup.frame = CGRect(x:((widthofCell * 2)+2) ,y:lblStayData.frame.origin.y+lblStayData.frame.height+40,width:55,height:55)
       // btnWhatsup.setFAIcon(icon: .FAWhatsapp, iconSize: 30, forState: .normal)
        btnWhatsup.setFATitleColor(color: .white, forState: .normal)
        btnWhatsup.addTarget(self, action: #selector(whatsupClicked(_:)), for: UIControlEvents.touchUpInside)
        
        
        btnMail.frame = CGRect(x:(widthofCell * 3)+2 ,y:lblStayData.frame.origin.y+lblStayData.frame.height+40,width:55,height:55)
        btnMail.setFAIcon(icon: .FAFax, iconSize: 30, forState: .normal)
        btnMail.setFATitleColor(color: .white, forState: .normal)
        btnMail.addTarget(self, action: #selector(chooseSharing(_:)), for: UIControlEvents.touchUpInside)
        
        btnMessage.frame = CGRect(x:(widthofCell * 4)+2,y:lblStayData.frame.origin.y+lblStayData.frame.height+40,width:55,height:55)
        //btnMessage.setFAIcon(icon: .FATelegram, iconSize: 30, forState: .normal)
        btnMessage.setFATitleColor(color: .white, forState: .normal)
        btnMessage.addTarget(self, action: #selector(messageClicked(_:)), for: UIControlEvents.touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if(GlobalVariables.editTempleImage == nil || GlobalVariables.editTempleImage == ""){
            
            let placeholderImage = UIImage(named: "default-icon")!
            imgTemple.image = placeholderImage
        }else{
            
            let url = URL(string:(GlobalVariables.editTempleImage))
            let placeholderImage = UIImage(named: "default-icon")!
            imgTemple.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }
    }
    
    @objc func imageUpdate(_ sender : UIButton){
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as? OtherImageUploadCntr
        gotoOtherUpload?.whatToUpload = "templeEditImage"
        gotoOtherUpload?.templeImageId =  templeData.temple_id
        self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
    }

    
    @objc func clickedFacbook(_ sender : UIButton){
        let alert = UIAlertController(title : "Share",message : "Share Nirjara on Facebook",preferredStyle:.actionSheet)
        let actionOne = UIAlertAction(title : "Share on Facebook",style : .default){
            (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                 self.showAlert(title: "Accounts", message: "Please login to a Facebook account to share.")
            } else {
                var contactNo = String()
                if(self.templeData.contact == ""){
                    contactNo =  "N/A"
                }else{
                    contactNo  =  self.templeData.contact
                }
                let msg = "Nirjara App - Temple Details \n\n"+"Temple Name : "+self.templeData.temple_name+"\n\n Temple Description : "+self.templeData.temple_info+"\n\n Temple Address : "+self.templeData.location+"\n\n Contact No : "+contactNo+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
                var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText(msg)
                facebookSheet.add(UIImage(named : "alertIcon"))
                self.present(facebookSheet, animated: true, completion: nil)
            }
        }
        alert.addAction(actionOne)
        self.present(alert,animated: true,completion: nil)
        
    }
    @objc func clickedTwitter(_ sender : UIButton){
        let alert = UIAlertController(title : "Share",message : "Share Nirjara on Twitter",preferredStyle:.actionSheet)
        let actionOne = UIAlertAction(title : "Share on Twitter",style : .default){
            (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                
                self.showAlert(title: "Accounts", message: "Please login to a Twitter account to share.")
            } else {
                var contactNo = String()
                if(self.templeData.contact == ""){
                    contactNo =  "N/A"
                }else{
                    contactNo  =  self.templeData.contact
                }
                let msg = "Nirjara App - Temple Details \n\n"+"Temple Name : "+self.templeData.temple_name+"\n\n Temple Description : "+self.templeData.temple_info+"\n\n Temple Address : "+self.templeData.location+"\n\n Contact No : "+contactNo+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
                var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterSheet.setInitialText(msg)
                twitterSheet.add(UIImage(named : "alertIcon"))
                self.present(twitterSheet, animated: true, completion: nil)
            }
        }
        alert.addAction(actionOne)
        self.present(alert,animated: true,completion: nil)
        
    }
    
    @objc func whatsupClicked(_ sender : UIButton){
        var contactNo = String()
        if(self.templeData.contact == ""){
            contactNo =  "N/A"
        }else{
           contactNo  =  self.templeData.contact
        }
        
        let msg = "Nirjara App - Temple Details \n\n"+"Temple Name : "+self.templeData.temple_name+"\n\n Temple Description : "+self.templeData.temple_info+"\n\n Temple Address : "+self.templeData.location+"\n\n Contact No : "+contactNo+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    self.showAlert(title: "Accounts", message: "Please Install Whatsup")
                }
            }
        }
    }
    
    @objc func chooseSharing(_ sender : UIButton){
        let firstActivityItem = "Temple Details"
        var contactNo = String()
        if(self.templeData.contact == ""){
            contactNo =  "N/A"
        }else{
            contactNo  =  self.templeData.contact
        }
        let msg = "Nirjara App - Temple Details \n\n"+"Temple Name : "+self.templeData.temple_name+"\n\n Temple Description : "+self.templeData.temple_info+"\n\n Temple Address : "+self.templeData.location+"\n\n Contact No : "+contactNo+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        let textShare = [msg]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        /*let secondActivityItem : NSURL = NSURL(string: msg)!
        // If you want to put an image
        let image : UIImage = UIImage(named: "alertIcon")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        
        self.present(activityViewController, animated: true, completion: nil)*/
    }
    
    @objc func messageClicked(_ sender : UIButton){
        
        sendMsg()
    }
    
    
    func sendMsg(){
        if (MFMessageComposeViewController.canSendText()) {
            var contactNo = String()
            if(self.templeData.contact == ""){
                contactNo =  "N/A"
            }else{
                contactNo  =  self.templeData.contact
            }
            let msg = "Nirjara App - Temple Details \n\n"+"Temple Name : "+self.templeData.temple_name+"\n\n Temple Description : "+self.templeData.temple_info+"\n\n Temple Address : "+self.templeData.location+"\n\n Contact No : "+contactNo+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
            let controller = MFMessageComposeViewController()
            controller.body = msg
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
            
        }else{
            self.showAlert(title: "Warnigng", message: "Unable To send sms")
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
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
