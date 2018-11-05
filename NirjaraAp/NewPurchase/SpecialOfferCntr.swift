//
//  SpecialOfferCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 6/21/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import ImageSlideshow
import IQKeyboardManagerSwift
class SpecialOfferCntr: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var offerData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var specialOfferTable: UITableView!
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var lblNote: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       specialOfferTable.separatorStyle = .none
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Special Offers"
        //scrollView.delegate = self
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:10,length:6))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel

        updateBackButton()
        addShadowToBar()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        offerData.removeAllObjects()
        specialOfferTable.reloadData()
        getSepcialOffer()
        /*scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.alpha = 0
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideImage))
        view.addGestureRecognizer(tap)*/
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func hideImage(){

       // scrollView.alpha = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = specialOfferTable.dequeueReusableCell(withIdentifier: "specialOfferIdentifier", for: indexPath) as? SpecialOfferCell
        
        var offerData = self.offerData[indexPath.row] as? offerModel
        
        cell?.selectionStyle = .none
        if(offerData?.image == nil || offerData?.image == ""){
            let placeholderImage = UIImage(named: "default-icon")!
            cell?.imgOffer.image = placeholderImage
        }else{
            let url = URL(string:(offerData?.image)!)
            let placeholderImage = UIImage(named: "default-icon")!
            cell?.imgOffer.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }
        
        let imgTab = UITapGestureRecognizer(target: self, action: #selector(showFullScreen(tapGestureRecognizer:)))
        cell?.imgOffer.isUserInteractionEnabled = true
        cell?.imgOffer.addGestureRecognizer(imgTab)
        cell?.imgOffer.accessibilityLabel = offerData?.image
        
        cell?.backView.frame = CGRect(x:10,y:0,width:self.view.frame.width-20,height:192)
        
        cell?.imgOffer.frame = CGRect(x:(cell?.backView.frame.origin.x)!-10,y:(cell?.backView.frame.origin.y)!,width:130,height:(cell?.backView.frame.height)!)
        
      
        /*let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAlertWithImage(tapGestureRecognizer:)))
        cell?.imgOffer.isUserInteractionEnabled = true
        cell?.imgOffer.addGestureRecognizer(tapGestureRecognizer)*/
        
        if(offerData?.image == nil || offerData?.image == ""){
            cell?.imgOffer.accessibilityLabel = "no data"
        }else{
            //cell?.imgOffer.accessibilityLabel = offerData?.image
            cell?.imgOffer.tag = indexPath.row
        }
        
        cell?.lblOfferName.frame = CGRect(x:140,y:10,width:(cell?.backView.frame.width)!-145,height:25)
        cell?.lblOfferName.text = offerData?.title
        
         cell?.btnInfo.frame = CGRect(x:(cell?.backView.frame.width)!-35,y:(cell?.backView.frame.origin.y)!+10,width:25,height:25)
        
        cell?.lblOfferDesc.frame = CGRect(x:140,y:(cell?.lblOfferName.frame.origin.y)!+(cell?.lblOfferName.frame.height)!,width:(cell?.backView.frame.width)!-165,height:35)
        cell?.lblOfferDesc.numberOfLines = 2
        cell?.lblOfferDesc.lineBreakMode = .byWordWrapping
        
        let From = offerData?.description
        let FromText  = "Description : "
        let attrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        let boldStringFrom = NSMutableAttributedString(string: FromText, attributes:attrsFrom)
        let attributedStringFrom = NSMutableAttributedString(string:From!)
        boldStringFrom.append(attributedStringFrom)
        cell?.lblOfferDesc.attributedText = boldStringFrom
        
        cell?.lblActualPrice.frame = CGRect(x:140,y:(cell?.lblOfferDesc.frame.origin.y)!+(cell?.lblOfferDesc.frame.height)!+4,width:(cell?.backView.frame.width)!-145,height:18)
        let actFrom = GlobalVariables.rupee+" "+(offerData?.original_price)!+" /-"
        let actFromText  = "Actual Price : "
        let actAttrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        let actBoldStringFrom = NSMutableAttributedString(string: actFromText, attributes:actAttrsFrom)
        let actAttributedStringFrom = NSMutableAttributedString(string:actFrom)
        actBoldStringFrom.append(actAttributedStringFrom)
        cell?.lblActualPrice.attributedText = actBoldStringFrom
        
        
        cell?.lblDiscountPrice.frame = CGRect(x:140,y:(cell?.lblActualPrice.frame.origin.y)!+(cell?.lblActualPrice.frame.height)!+4,width:(cell?.backView.frame.width)!-145,height:18)
        let disFrom = GlobalVariables.rupee+" "+(offerData?.discount_price)!+" /-"
        let disFromText  = "Discount Price : "
        let disAttrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        let disBoldStringFrom = NSMutableAttributedString(string: disFromText, attributes:disAttrsFrom)
        let disAttributedStringFrom = NSMutableAttributedString(string:disFrom)
        disBoldStringFrom.append(disAttributedStringFrom)
        cell?.lblDiscountPrice.attributedText = disBoldStringFrom
        
    
        cell?.lblOfferTarget.frame = CGRect(x:140,y:(cell?.lblDiscountPrice.frame.origin.y)!+(cell?.lblDiscountPrice.frame.height)!+4,width:(cell?.backView.frame.width)!-145,height:18)
        let Target = (offerData?.target_user)! + " user's"
        let targetFrom  = "Target : "
        let attrsFrom1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        let boldStringFrom1 = NSMutableAttributedString(string: targetFrom, attributes:attrsFrom1)
        let attributedStringFrom1 = NSMutableAttributedString(string:Target)
        boldStringFrom1.append(attributedStringFrom1)
        cell?.lblOfferTarget.attributedText = boldStringFrom1
        
        
        cell?.lblOfferAchieved.frame = CGRect(x:140,y:(cell?.lblOfferTarget.frame.origin.y)!+(cell?.lblOfferTarget.frame.height)! + 4,width:(cell?.backView.frame.width)!-145,height:18)
        let achived = (offerData?.target_archived)! + " user's"
        let achivedFrom  = "Achieved : "
        let attrsFrom2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        let boldStringFrom2 = NSMutableAttributedString(string: achivedFrom, attributes:attrsFrom2)
        let attributedStringFrom2 = NSMutableAttributedString(string:achived)
        boldStringFrom2.append(attributedStringFrom2)
        cell?.lblOfferAchieved.attributedText = boldStringFrom2
        
        cell?.btnSendEnquiry.frame = CGRect(x:(cell?.backView.frame.width)!-130,y:(cell?.lblOfferAchieved.frame.origin.y)!+(cell?.lblOfferAchieved.frame.height)!,width:130,height:40)
    
        cell?.btnSendEnquiry.tag = indexPath.row
        cell?.btnInfo.tag = indexPath.row
        cell?.btnInfo.addTarget(self, action: #selector(showDetail(_:)), for: UIControlEvents.touchUpInside)
        cell?.btnSendEnquiry.addTarget(self, action: #selector(sendEnquiry(_:)), for: UIControlEvents.touchUpInside)
        
        cell?.backView.addSubview((cell?.imgOffer)!)
        cell?.backView.addSubview((cell?.lblOfferName)!)
        cell?.backView.addSubview((cell?.lblOfferDesc)!)
        cell?.backView.addSubview((cell?.lblOfferTarget)!)
        cell?.backView.addSubview((cell?.lblOfferAchieved)!)
        cell?.backView.addSubview((cell?.btnInfo)!)
        cell?.backView.addSubview((cell?.btnSendEnquiry)!)
        cell?.backView.addSubview((cell?.lblActualPrice)!)
        cell?.backView.addSubview((cell?.lblDiscountPrice)!)
        
        cell?.backView.dropShadow(color: UIColor.rgb(hexcolor: "#A8A8A8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        return cell!
    }
    
    @objc func showFullScreen(tapGestureRecognizer : UITapGestureRecognizer){
        
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        var images = [InputSource]()
        
        var offerData = self.offerData[tappedImage.tag] as? offerModel
        let alamofireSource = AlamofireSource(urlString: (offerData?.image)!)!
        let alamofireSource2 = AlamofireSource(urlString: (offerData?.image2)!)!
        let alamofireSource3 = AlamofireSource(urlString: (offerData?.image3)!)!
        let alamofireSource4 = AlamofireSource(urlString: (offerData?.image4)!)!
        let alamofireSource5 = AlamofireSource(urlString: (offerData?.image5)!)!
        images.append(alamofireSource)
        images.append(alamofireSource2)
        images.append(alamofireSource3)
        images.append(alamofireSource4)
        images.append(alamofireSource5)
        
        var addsSlideShow = ImageSlideshow()
        addsSlideShow.setImageInputs(images)
        addsSlideShow.backgroundColor = UIColor.white
        addsSlideShow.slideshowInterval = 3.5
        addsSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
        addsSlideShow.pageControl.isHidden = true
        addsSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        addsSlideShow.presentFullScreenController(from: self)
    }
    
    @objc func showAlertWithImage(tapGestureRecognizer : UITapGestureRecognizer){
        
        
       /* let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if(tappedImage.accessibilityLabel == "no data"){
            
        }else{
            
            if(tappedImage.accessibilityLabel == "" || tappedImage.accessibilityLabel == nil){
                
            }else{
                scrollView.alpha = 1
                let url = URL(string:(tappedImage.accessibilityLabel)!.replacingOccurrences(of: " ", with: "%20"))
                let placeholderImage = UIImage(named: "default_icon_new")!
                
                imgScroll.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                self.imgScroll.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
                self.imgScroll.contentMode = .scaleAspectFit // OR .scaleAspectFill
                self.imgScroll.clipsToBounds = true
            }
        }*/
        
    }
    
    
    @objc func showDetail(_ sender : UIButton){
        
        var offerData = self.offerData[sender.tag] as? offerModel
        showAlert(title: ("Title : "+(offerData?.title)!), message: ("Description : "+(offerData?.description)!))
        
    }
    @objc func sendEnquiry(_ sender : UIButton){
        
        var offerData = self.offerData[sender.tag] as? offerModel
        sendEnquiry(offerId : (offerData?.special_offer_id)!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func sendEnquiry(offerId :String){
        if isConnectedToNetwork() {
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&special_offer_id=\(offerId)"
        let url = URL(string:ServerUrl.get_special_offer_enquiry)!
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
                if (Status == "Success")
                {
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                         let success_msg = json?.object(forKey: "success_msg") as? String;
                        if(success_msg == "Already Checked for this offer"){
                            self.showAlert(title: "Nirjara App", message:"Already Requested has been send Thanks!!")
                        }else{
                             self.showAlert(title: "Nirjara App", message:"Your Request has been send successfully")
                        }
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.showAlert(title: "Nirjara Ap", message: "Something went Wrong")
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
    }
    
    func getSepcialOffer(){
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_special_offer)!
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
                let note = json?.object(forKey: "note") as? String;
                let note_color = json?.object(forKey: "note_color") as? String;
                let note_font_color = json?.object(forKey: "note_font_color") as? String;
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var offerMModel = offerModel()
                        offerMModel.special_offer_id = jsonObject?.object(forKey: "special_offer_id") as? String
                        offerMModel.title = jsonObject?.object(forKey: "title") as? String
                        offerMModel.description = jsonObject?.object(forKey: "description") as? String
                        offerMModel.target_user = jsonObject?.object(forKey: "target_user") as? String
                        offerMModel.target_archived = jsonObject?.object(forKey: "target_archived") as? String
                        offerMModel.image = jsonObject?.object(forKey: "image") as? String
                        offerMModel.image2 = jsonObject?.object(forKey: "image2") as? String
                        offerMModel.image3 = jsonObject?.object(forKey: "image3") as? String
                        offerMModel.image4 = jsonObject?.object(forKey: "image4") as? String
                        offerMModel.image5 = jsonObject?.object(forKey: "image5") as? String
                        offerMModel.original_price = jsonObject?.object(forKey: "original_price") as? String
                        offerMModel.discount_price = jsonObject?.object(forKey: "discount_price") as? String
                        self.offerData.add(offerMModel)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 0
                        self.specialOfferTable.alpha = 1
                        self.specialOfferTable.reloadData()
                        self.lblNote.text = note
                        self.backView.backgroundColor = UIColor.rgb(hexcolor: note_color!)
                        self.lblNote.textColor = UIColor.rgb(hexcolor: note_font_color!)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 1
                        self.specialOfferTable.alpha = 0
                        self.lblNote.text = note
                        self.backView.backgroundColor = UIColor.rgb(hexcolor: note_color!)
                        self.lblNote.textColor = UIColor.rgb(hexcolor: note_font_color!)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

}
