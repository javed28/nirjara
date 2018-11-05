//
//  EventsDetailsViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import ImageSlideshow
import Social
import MessageUI
class EventsDetailsViewController: UIViewController,MFMessageComposeViewControllerDelegate {

    
    @IBOutlet weak var addsSlideShow: ImageSlideshow!
    @IBOutlet weak var lblOrganized: UILabel!
    @IBOutlet weak var lblOrganizedName: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblFromtext: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblToText: UILabel!
    @IBOutlet weak var lblVenue: UILabel!
     @IBOutlet weak var lblVenueText: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnTwitter: UIButton!
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    
    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var btnWhatsup: UIButton!
    
    
    @IBOutlet weak var lblContactNoText: UILabel!
    
    
    @IBOutlet weak var lblContactN: UILabel!
    
    var eventsData : eventsModel = eventsModel()
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    
    @IBOutlet weak var lblEventDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Events Details"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:9,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()

        
            var images = [InputSource]()
        if(eventsData.event_photo1_large == ""){
            images.append(ImageSource(image: UIImage(named: "default-img")!))
        }else{
            let alamofireSource = AlamofireSource(urlString: eventsData.event_photo1_large.replacingOccurrences(of: " ", with: "%20"))!
            images.append(alamofireSource)
        }
        
        if(eventsData.event_photo2_large == ""){
            images.append(ImageSource(image: UIImage(named: "default-img")!))
        }else{
            let alamofireSource = AlamofireSource(urlString: eventsData.event_photo2_large.replacingOccurrences(of: " ", with: "%20"))!
            images.append(alamofireSource)
        }
        
        if(eventsData.event_photo3_large == ""){
            images.append(ImageSource(image: UIImage(named: "default-img")!))
        }else{
            let alamofireSource = AlamofireSource(urlString: eventsData.event_photo3_large.replacingOccurrences(of: " ", with: "%20"))!
            images.append(alamofireSource)
        }
        
        
        
        
        self.addsSlideShow.setImageInputs(images)
        
        
        self.addsSlideShow.backgroundColor = UIColor.white
        self.addsSlideShow.slideshowInterval = 4.0
        self.addsSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
        self.addsSlideShow.pageControl.pageIndicatorTintColor = UIColor.white
        self.addsSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        
        
        addsSlideShow.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:210)
    
        lblOrganized.text = "OrganizedBy".localized1+" : "
        lblOrganized.frame = CGRect(x:10,y:addsSlideShow.frame.origin.y + addsSlideShow.frame.height+20,width:lblOrganized.intrinsicContentSize.width,height:30)
        
        
        lblOrganizedName.text =  self.eventsData.event_organizer
        lblOrganizedName.numberOfLines = 0
        lblOrganizedName.lineBreakMode = .byWordWrapping;
        lblOrganizedName.frame = CGRect(x:lblOrganized.intrinsicContentSize.width+lblOrganized.frame.origin.x+5,y:addsSlideShow.frame.origin.y + addsSlideShow.frame.height+28,width:self.view.frame.width-lblOrganized.intrinsicContentSize.width+lblOrganized.frame.origin.x-10,height:lblOrganizedName.intrinsicContentSize.height)

        
        lblTitle.text =  self.eventsData.event_title
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping;
        lblTitle.frame = CGRect(x: 10, y: lblOrganizedName.frame.origin.y + lblOrganizedName.frame.height+13, width: self.view.frame.width-20, height: lblTitle.intrinsicContentSize.height)
        
        
        lblEventDesc.text =  self.eventsData.event_description
        lblEventDesc.numberOfLines = 0
        lblEventDesc.lineBreakMode = .byWordWrapping;
        lblEventDesc.frame = CGRect(x: 10, y: lblTitle.frame.origin.y + lblTitle.frame.height+10, width: self.view.frame.width-20, height: lblEventDesc.intrinsicContentSize.height)
        
        
        lblContact.text = "ContactPersonName".localized1+" : "
        lblContact.frame = CGRect(x:10,y:lblEventDesc.frame.origin.y + lblEventDesc.frame.height+10,width:205,height:30)
        lblContactNo.frame = CGRect(x:190,y:lblEventDesc.frame.origin.y + lblEventDesc.frame.height+10,width:self.view.frame.width-220,height:30)
        if(self.eventsData.contact_person == "" || self.eventsData.contact == nil){
            lblContactNo.text =  "N/A"
        }else{
            lblContactNo.text =  self.eventsData.contact_person
        }
        
    
        lblContactNoText.text = "ContactNumber".localized1+" : "
        lblContactNoText.frame = CGRect(x:10,y:lblContact.frame.origin.y + lblContact.frame.height+5,width:lblContactNoText.intrinsicContentSize.width,height:30)
        
        lblContactN.frame = CGRect(x:lblContactNoText.frame.origin.x + lblContactNoText.frame.width+10,y:lblContact.frame.origin.y + lblContact.frame.height+5,width:self.view.frame.width-180,height:30)
        if(self.eventsData.contact == "" || self.eventsData.contact == nil){
            lblContactN.text =  "N/A"
        }else{
            lblContactN.text =  self.eventsData.contact
        }
        
        //lblContactN.textAlignment = .left
    
        lblFrom.text = "From".localized1+" : "
        lblFrom.frame = CGRect(x:10,y:lblContactNoText.frame.origin.y+lblContactNoText.frame.height+5,width:70,height:30)
        lblFromtext.frame = CGRect(x:70,y:lblContactN.frame.origin.y+lblContactN.frame.height+5,width:self.view.frame.width-80,height:30)
        lblFromtext.text =  self.eventsData.event_from
        
        lblTo.text = "To".localized1+" : "
        lblTo.frame = CGRect(x:10,y:lblFromtext.frame.origin.y+lblFromtext.frame.height+5,width:lblTo.intrinsicContentSize.width,height:30)
        lblToText.frame = CGRect(x:lblTo.frame.origin.x + lblTo.frame.width+10,y:lblFromtext.frame.origin.y+lblFromtext.frame.height+5,width:self.view.frame.width-80,height:30)
        lblToText.text =  self.eventsData.event_to
        
        lblVenue.text = "Venue".localized1+" : "
        lblVenue.frame = CGRect(x:10,y:lblToText.frame.origin.y+lblToText.frame.height+5,width:80,height:30)
        lblVenueText.frame = CGRect(x:70,y:lblToText.frame.origin.y+lblToText.frame.height+5,width:self.view.frame.width-80,height:30)
        lblVenueText.text =  self.eventsData.event_venue
        
        
        let widthofCell : CGFloat = self.view.frame.width/5
        
        
        btnTwitter.frame = CGRect(x:5,y:lblVenue.frame.origin.y+lblVenue.frame.height+40,width:55,height:55)
        btnTwitter.setFAIcon(icon: .FATwitter, iconSize: 30, forState: .normal)
        btnTwitter.setFATitleColor(color: .white, forState: .normal)
        btnTwitter.addTarget(self, action: #selector(clickedTwitter(_:)), for: UIControlEvents.touchUpInside)

        btnFacebook.frame = CGRect(x:widthofCell+2,y:lblVenue.frame.origin.y+lblVenue.frame.height+40,width:55,height:55)
        btnFacebook.setFAIcon(icon: .FAFacebook, iconSize: 30, forState: .normal)
        btnFacebook.setFATitleColor(color: .white, forState: .normal)
        btnFacebook.addTarget(self, action: #selector(clickedFacbook(_:)), for: UIControlEvents.touchUpInside)
        
        btnWhatsup.frame = CGRect(x:((widthofCell * 2)+2) ,y:lblVenue.frame.origin.y+lblVenue.frame.height+40,width:55,height:55)
        //btnWhatsup.setFAIcon(icon: .FAWhatsapp, iconSize: 30, forState: .normal)
        btnWhatsup.setFATitleColor(color: .white, forState: .normal)
        btnWhatsup.addTarget(self, action: #selector(whatsupClicked(_:)), for: UIControlEvents.touchUpInside)
        
        
        btnMail.frame = CGRect(x:(widthofCell * 3)+2 ,y:lblVenue.frame.origin.y+lblVenue.frame.height+40,width:55,height:55)
        btnMail.setFAIcon(icon: .FAFax, iconSize: 30, forState: .normal)
        btnMail.setFATitleColor(color: .white, forState: .normal)
        btnMail.addTarget(self, action: #selector(chooseSharing(_:)), for: UIControlEvents.touchUpInside)
        
        btnMessage.frame = CGRect(x:(widthofCell * 4)+2,y:lblVenue.frame.origin.y+lblVenue.frame.height+40,width:55,height:55)
        //btnMessage.setFAIcon(icon: .FATelegram, iconSize: 30, forState: .normal)
        btnMessage.setFATitleColor(color: .white, forState: .normal)
        btnMessage.addTarget(self, action: #selector(messageClicked(_:)), for: UIControlEvents.touchUpInside)
      
        
        heightOfView.constant = btnMessage.frame.origin.y+btnMessage.frame.height+130
    }
    @objc func clickedFacbook(_ sender : UIButton){
        let alert = UIAlertController(title : "Share",message : "Share Nirjara on Facebook",preferredStyle:.actionSheet)
        let actionOne = UIAlertAction(title : "Share on Facebook",style : .default){
            (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                
         self.showAlert(title: "Accounts", message: "Please login to a Facebook account to share.")
            } else {
                var contactNo = String()
                if(self.eventsData.contact == ""){
                    contactNo =  "N/A"
                }else{
                    contactNo  =  self.eventsData.contact
                }
                let msg = "Nirjara App - Event Details\n\n"+self.eventsData.event_organizer+"\n\n Contact Person : "+contactNo+"\n\n From : "+self.eventsData.event_from+"\n\n To : "+self.eventsData.event_from+"\n\n Venue : "+self.eventsData.event_venue+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
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
                if(self.eventsData.contact == ""){
                    contactNo =  "N/A"
                }else{
                    contactNo  =  self.eventsData.contact
                }
                let msg = "Nirjara App - Event Details\n\n"+self.eventsData.event_organizer+"\n\n Contact Person : "+contactNo+"\n\n From : "+self.eventsData.event_from+"\n\n To : "+self.eventsData.event_from+"\n\n Venue : "+self.eventsData.event_venue+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
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
        if(self.eventsData.contact == ""){
            contactNo =  "N/A"
        }else{
            contactNo  =  self.eventsData.contact
        }
        let msg = "Nirjara App - Event Details\n\n"+self.eventsData.event_organizer+"\n\n Contact Person : "+contactNo+"\n\n From : "+self.eventsData.event_from+"\n\n To : "+self.eventsData.event_from+"\n\n Venue : "+self.eventsData.event_venue+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        
       
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
        let firstActivityItem = "Jain Events"
        var contactNo = String()
        if(self.eventsData.contact == ""){
            contactNo =  "N/A"
        }else{
            contactNo  =  self.eventsData.contact
        }
        let msg = "Nirjara App - Event Details\n\n"+self.eventsData.event_organizer+"\n\n Contact Person : "+contactNo+"\n\n From : "+self.eventsData.event_from+"\n\n To : "+self.eventsData.event_from+"\n\n Venue : "+self.eventsData.event_venue+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        //let text = "This is the text....."
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
            if(self.eventsData.contact == ""){
                contactNo =  "N/A"
            }else{
                contactNo  =  self.eventsData.contact
            }
            let msg = "Nirjara App - Event Details\n\n"+self.eventsData.event_organizer+"\n\n Contact Person : "+contactNo+"\n\n From : "+self.eventsData.event_from+"\n\n To : "+self.eventsData.event_from+"\n\n Venue : "+self.eventsData.event_venue+"\n\n https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
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
