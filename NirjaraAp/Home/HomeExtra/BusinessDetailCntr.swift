//
//  BusinessDetailCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/18/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import ImageSlideshow
import Social
import MessageUI
class BusinessDetailCntr: UIViewController,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var imgUserIcon: UIImageView!
    @IBOutlet weak var imgPackageIcon: UIImageView!
    
    @IBOutlet weak var separaterView: UIView!
    @IBOutlet weak var imgMobileIcon: UIImageView!
    @IBOutlet weak var addsSlideShow: ImageSlideshow!
    @IBOutlet weak var lblBusinessName: UILabel!
    @IBOutlet weak var imgLocationIcon: UIImageView!
    
    @IBOutlet weak var lblBusindesc: UILabel!
    @IBOutlet weak var lblLoc: UILabel!
    
    @IBOutlet weak var lblContact: UILabel!
    
    @IBOutlet weak var lblProduct: UILabel!
    
    
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnMail: UIButton!
    
    
    @IBOutlet weak var btnWhatsup: UIButton!
    var businessFullDetail = businessDetailModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Business Detail"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:6))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        self.addShadowToBarMap()
        
        var images = [InputSource]()
        if(businessFullDetail.image == ""){
            images.append(ImageSource(image: UIImage(named: "default-img")!))
        }else{
            let alamofireSource = AlamofireSource(urlString: businessFullDetail.image)!
            images.append(alamofireSource)
        }
        images.append(ImageSource(image: UIImage(named: "default-img")!))
        images.append(ImageSource(image: UIImage(named: "default-img")!))
        
        
        
        self.addsSlideShow.setImageInputs(images)
        
        self.addsSlideShow.frame = CGRect(x:0,y:10,width:self.view.frame.width,height:210)
        self.addsSlideShow.backgroundColor = UIColor.white
        self.addsSlideShow.slideshowInterval = 4.0
        self.addsSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
        self.addsSlideShow.pageControl.pageIndicatorTintColor = UIColor.white
        self.addsSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        self.addsSlideShow.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -0.5, height: 0.5), radius: 1.5, scale: true)
        
        lblBusinessName.text =  self.businessFullDetail.business_owner_name
       
        
        imgUserIcon.frame = CGRect(x:10,y:addsSlideShow.frame.origin.y + addsSlideShow.frame.height+20,width:30,height:30)
        lblBusinessName.frame = CGRect(x:55,y:addsSlideShow.frame.origin.y + addsSlideShow.frame.height+20,width:self.view.frame.width-20,height:30)
        
        
        imgPackageIcon.frame = CGRect(x:self.view.frame.width-45,y:addsSlideShow.frame.origin.y + addsSlideShow.frame.height+20,width:40,height:40)
        separaterView.frame = CGRect(x:10,y:imgPackageIcon.frame.origin.y+imgPackageIcon.frame.height+5,width:self.view.frame.width-20,height:1)
        
        if(businessFullDetail.package_id == "3"){
            let image : UIImage = UIImage(named: "gold")!
            imgPackageIcon.image = image
        }else  if(businessFullDetail.package_id == "4"){
            let image : UIImage = UIImage(named: "silver")!
            imgPackageIcon.image = image
        }else  if(businessFullDetail.package_id == "2"){
            let image : UIImage = UIImage(named: "silver")!
            imgPackageIcon.image = image
        }
        lblBusindesc.text =  self.businessFullDetail.business_title
        lblBusindesc.numberOfLines = 3
        lblBusindesc.lineBreakMode = .byWordWrapping;
        lblBusindesc.frame = CGRect(x:10,y:separaterView.frame.origin.y + separaterView.frame.height+10,width:self.view.frame.width-20,height:50)
        

        imgLocationIcon.frame = CGRect(x:10,y:lblBusindesc.frame.origin.y+lblBusindesc.frame.height+5,width:13,height:15)
        if(self.businessFullDetail.address == ""){
            lblLoc.numberOfLines = 1
            lblLoc.lineBreakMode = .byWordWrapping;
            lblLoc.text =  "No Address"
            lblLoc.frame = CGRect(x:35,y:lblBusindesc.frame.origin.y+lblBusindesc.frame.height,width:self.view.frame.width-70,height:20)
        }else{
        if(self.businessFullDetail.address.count < 35){
            print("forsttt else---")
            lblLoc.numberOfLines = 1
            lblLoc.lineBreakMode = .byWordWrapping;
            lblLoc.text =  self.businessFullDetail.address
            lblLoc.frame = CGRect(x:35,y:lblBusindesc.frame.origin.y+lblBusindesc.frame.height,width:self.view.frame.width-70,height:20)
        }else if(self.businessFullDetail.address.count < 70){
             print("secondddd else----")
            lblLoc.numberOfLines = 2
            lblLoc.lineBreakMode = .byWordWrapping;
            lblLoc.text =  self.businessFullDetail.address
            lblLoc.frame = CGRect(x:35,y:lblBusindesc.frame.origin.y+lblBusindesc.frame.height,width:self.view.frame.width-70,height:40)
        }else{
            print("last else---")
            lblLoc.numberOfLines = 3
            lblLoc.lineBreakMode = .byWordWrapping;
            lblLoc.text =  self.businessFullDetail.address
            lblLoc.frame = CGRect(x:35,y:lblBusindesc.frame.origin.y+lblBusindesc.frame.height,width:self.view.frame.width-70,height:60)
        }
        }
        
        
        
        imgMobileIcon.frame = CGRect(x:10,y:lblLoc.frame.origin.y+lblLoc.frame.height+15,width:13,height:15)
        lblContact.frame = CGRect(x:35,y:lblLoc.frame.origin.y+lblLoc.frame.height+5,width:self.view.frame.width-20,height:30)
        lblContact.text =  self.businessFullDetail.contact_no
    
        
        let From = businessFullDetail.product1
        let FromText  = "Product : "
        let attrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        var boldStringFrom = NSMutableAttributedString(string: FromText, attributes:attrsFrom)
        let attributedStringFrom = NSMutableAttributedString(string:From!)
        boldStringFrom.append(attributedStringFrom)
        lblProduct.attributedText = boldStringFrom
        
        lblProduct.numberOfLines = 3
        lblProduct.lineBreakMode = .byWordWrapping;
        lblProduct.frame = CGRect(x:10,y:lblContact.frame.origin.y+lblContact.frame.height,width:self.view.frame.width-20,height:50)
        //lblProduct.text =  self.businessFullDetail.product1
        
        
        let widthofCell : CGFloat = self.view.frame.width/5
        
        
        btnTwitter.frame = CGRect(x:5,y:lblProduct.frame.origin.y+lblProduct.frame.height+35,width:55,height:55)
        btnTwitter.setFAIcon(icon: .FATwitter, iconSize: 30, forState: .normal)
        btnTwitter.setFATitleColor(color: .white, forState: .normal)
        btnTwitter.addTarget(self, action: #selector(clickedTwitter(_:)), for: UIControlEvents.touchUpInside)
        
        btnFacebook.frame = CGRect(x:widthofCell+2,y:lblProduct.frame.origin.y+lblProduct.frame.height+35,width:55,height:55)
        btnFacebook.setFAIcon(icon: .FAFacebook, iconSize: 30, forState: .normal)
        btnFacebook.setFATitleColor(color: .white, forState: .normal)
        btnFacebook.addTarget(self, action: #selector(clickedFacbook(_:)), for: UIControlEvents.touchUpInside)
        
        btnWhatsup.frame = CGRect(x:((widthofCell * 2)+2) ,y:lblProduct.frame.origin.y+lblProduct.frame.height+35,width:55,height:55)
        //btnWhatsup.setFAIcon(icon: .FAWhatsapp, iconSize: 30, forState: .normal)
        btnWhatsup.setFATitleColor(color: .white, forState: .normal)
        btnWhatsup.addTarget(self, action: #selector(whatsupClicked(_:)), for: UIControlEvents.touchUpInside)
        
        
        btnMail.frame = CGRect(x:(widthofCell * 3)+2 ,y:lblProduct.frame.origin.y+lblProduct.frame.height+35,width:55,height:55)
        btnMail.setFAIcon(icon: .FAFax, iconSize: 30, forState: .normal)
        btnMail.setFATitleColor(color: .white, forState: .normal)
        btnMail.addTarget(self, action: #selector(chooseSharing(_:)), for: UIControlEvents.touchUpInside)
        
        btnMessage.frame = CGRect(x:(widthofCell * 4)+2,y:lblProduct.frame.origin.y+lblProduct.frame.height+35,width:55,height:55)
        //btnMessage.setFAIcon(icon: .FATelegram, iconSize: 30, forState: .normal)
        btnMessage.setFATitleColor(color: .white, forState: .normal)
        btnMessage.addTarget(self, action: #selector(messageClicked(_:)), for: UIControlEvents.touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func clickedFacbook(_ sender : UIButton){
        let alert = UIAlertController(title : "Share",message : "Share Nirjara on Facebook",preferredStyle:.actionSheet)
        let actionOne = UIAlertAction(title : "Share on Facebook",style : .default){
            (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                 self.showAlert(title: "Accounts", message: "Please login to a Facebook account to share.")
            } else {
                var contactNo = String()
                if(self.businessFullDetail.contact_no == ""){
                    contactNo =  "N/A"
                }else{
                    contactNo  =  "("+self.businessFullDetail.contact_no+")"
                }
                let msg = "Nirjara App - Business Details \n\n"+self.businessFullDetail.business_title+"\n\n Contact Person : "+self.businessFullDetail.business_owner_name+" "+contactNo+"\n\n Description : "+self.businessFullDetail.product1+"\n\n Address : "+self.businessFullDetail.address+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
                
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
                if(self.businessFullDetail.contact_no == ""){
                    contactNo =  "N/A"
                }else{
                    contactNo  =  "("+self.businessFullDetail.contact_no+")"
                }
                let msg = "Nirjara App - Business Details \n\n"+self.businessFullDetail.business_title+"\n\n Contact Person : "+self.businessFullDetail.business_owner_name+" "+contactNo+"\n\n Description : "+self.businessFullDetail.product1+"\n\n Address : "+self.businessFullDetail.address+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
                
                
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
        if(self.businessFullDetail.contact_no == ""){
            contactNo =  "N/A"
        }else{
            contactNo  =  "("+self.businessFullDetail.contact_no+")"
        }
        let msg = "Nirjara App - Business Details \n\n"+self.businessFullDetail.business_title+"\n\n Contact Person : "+self.businessFullDetail.business_owner_name+" "+contactNo+"\n\n Description : "+self.businessFullDetail.product1+"\n\n Address : "+self.businessFullDetail.address+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
    
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
        let firstActivityItem = "Business Details"
        var contactNo = String()
        if(self.businessFullDetail.contact_no == ""){
            contactNo =  "N/A"
        }else{
            contactNo  =  "("+self.businessFullDetail.contact_no+")"
        }
        let msg = "Nirjara App - Business Details \n\n"+self.businessFullDetail.business_title+"\n\n Contact Person : "+self.businessFullDetail.business_owner_name+" "+contactNo+"\n\n Description : "+self.businessFullDetail.product1+"\n\n Address : "+self.businessFullDetail.address+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        
        let textShare = [msg]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        /*let firstActivityItem = "Business Details"
        let secondActivityItem : NSURL = NSURL(string: msg)!
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
            if(self.businessFullDetail.contact_no == ""){
                contactNo =  "N/A"
            }else{
                contactNo  =  "("+self.businessFullDetail.contact_no+")"
            }
            let msg = "Nirjara App - Business Details \n\n"+self.businessFullDetail.business_title+"\n\n Contact Person : "+self.businessFullDetail.business_owner_name+" "+contactNo+"\n\n Description : "+self.businessFullDetail.product1+"\n\n Address : "+self.businessFullDetail.address+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
            
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
    
    
    @objc func didTap() {
        addsSlideShow.presentFullScreenController(from: self)
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
