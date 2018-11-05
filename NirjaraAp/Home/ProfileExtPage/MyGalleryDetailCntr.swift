

//
//  MyGalleryDetailCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/21/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyGalleryDetailCntr: UIViewController {

    @IBOutlet weak var imgWhoPost: UIImageView!
    @IBOutlet weak var lblWhoPostName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var imgWhatpost: UIImageView!
    
    
    @IBOutlet weak var btnAnumodha: UIButton!
    
    @IBOutlet weak var btnDarshan: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var btnTextComment: UIButton!
    @IBOutlet weak var btnTextAnumodha: UIButton!
    @IBOutlet weak var btnTextDarshan: UIButton!
    var GalleryData = galleryModel()
    var containerController: ContainerViewController?
    
    @IBOutlet weak var sideViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCaption: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  My Gallery"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:5))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:5,length:7))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        lblWhoPostName.text = GalleryData.name

        updateBackButton()
        
        lblDate.text = GalleryData.date.convertDateFormater((GalleryData.date)!)
        imgWhoPost.layer.cornerRadius = imgWhoPost.bounds.size.width / 2.0
        imgWhoPost.clipsToBounds = true
        
        let url = URL(string:(GalleryData.member_photo)!)
        let placeholderImage = UIImage(named: "default_icon_new")!
        imgWhoPost.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        let postUrl = URL(string:(GalleryData.larg_image)!)
        
   
        imgWhatpost.af_setImage(withURL: postUrl!,placeholderImage: placeholderImage)
        let imgHeight : CGFloat = imgWhatpost.intrinsicContentSize.height
      
        if(GalleryData.anumodan_liked == "liked"){
            let likeIcon = UIImage(named : "anumodhna_like")
            btnAnumodha.setImage(likeIcon, for: .normal)
            btnTextAnumodha.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
        }else{
            let unlikeIcon = UIImage(named : "anumodhna_unlike")
            btnAnumodha.setImage(unlikeIcon, for: .normal)
            btnTextAnumodha.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
        }
        
        if(GalleryData.darshan_liked == "liked"){
            let likeIcon = UIImage(named : "darshan_like")
            btnDarshan.setImage(likeIcon, for: .normal)
            btnTextDarshan.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
        }else{
            let unlikeIcon = UIImage(named : "darshan_unlike")
            btnTextDarshan.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
            btnDarshan.setImage(unlikeIcon, for: .normal)
        }
        
        
        btnAnumodha.addTarget(self, action: #selector(postAnumodhna(_:)), for: UIControlEvents.touchUpInside)
        btnDarshan.addTarget(self, action: #selector(postDarshan(_:)), for: UIControlEvents.touchUpInside)
        btnComment.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
        btnBlock.addTarget(self, action: #selector(postBlockImage(_:)), for: UIControlEvents.touchUpInside)
        
        
        btnAnumodha.accessibilityLabel = GalleryData.gallery_id!
       
        btnDarshan.accessibilityLabel = GalleryData.gallery_id!
        
        btnBlock.accessibilityLabel = GalleryData.gallery_id!
        btnComment.accessibilityLabel = GalleryData.gallery_id!
        
        btnTextAnumodha.setTitle("Anumodna".localized1+"("+(GalleryData.anumodnaCount)!+")", for: UIControlState.normal)
        btnTextDarshan.setTitle("Darshan".localized1+"("+(GalleryData.darshanCount)!+")", for: UIControlState.normal)
        btnTextComment.setTitle("Comments".localized1+"("+(GalleryData.commentsCount)!+")", for: UIControlState.normal)
        
        
        
        btnTextAnumodha.frame = CGRect(x:5,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+28,width:btnTextAnumodha.intrinsicContentSize.width+10,height:40)
        btnTextDarshan.frame = CGRect(x:btnTextAnumodha.frame.origin.x+btnTextAnumodha.frame.width+2,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+28,width:btnTextDarshan.intrinsicContentSize.width+10,height:40)
        btnTextComment.frame = CGRect(x:btnTextDarshan.frame.origin.x+btnTextDarshan.frame.width+2,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+28,width:btnTextComment.intrinsicContentSize.width+10,height:40)
        
        btnAnumodha.frame = CGRect(x:btnTextAnumodha.frame.origin.x+btnTextAnumodha.frame.width/2-17.5,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+5,width:35,height:35)
        btnDarshan.frame = CGRect(x:btnTextDarshan.frame.origin.x+btnTextDarshan.frame.width/2-17.5,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+5,width:35,height:35)
        btnComment.frame = CGRect(x:btnTextComment.frame.origin.x+btnTextComment.frame.width/2-17.5,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+5,width:35,height:35)
        btnBlock.frame = CGRect(x:self.view.frame.width-60,y:imgWhatpost.frame.origin.y+imgWhatpost.frame.height+5,width:35,height:35)
        
        btnComment.tag = Int((GalleryData.gallery_id)!)!
        
        btnTextAnumodha.addTarget(self, action: #selector(gotoAnuModna(_:)), for: UIControlEvents.touchUpInside)
        btnTextDarshan.addTarget(self, action: #selector(gotoDarshan(_:)), for: UIControlEvents.touchUpInside)
        btnTextComment.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
        btnTextAnumodha.tag = Int((GalleryData.gallery_id)!)!
        btnTextDarshan.tag = Int((GalleryData.gallery_id)!)!
        btnTextComment.tag = Int((GalleryData.gallery_id)!)!
        
        
        
        
        /*lblCaption.lineBreakMode = .byWordWrapping
        lblCaption.numberOfLines = 0;
        lblCaption.text = GalleryData.title
        lblCaption.sizeToFit()*/
        
        
        let data1 = GalleryData.title.data(using: String.Encoding.utf8)
        let messageString = String(data : data1!,encoding : String.Encoding.nonLossyASCII)
        
        lblCaption.text = messageString
        let greet4Height = lblCaption.optimalHeight
        lblCaption.frame = CGRect(x: 5, y: 455, width:self.mainView.frame.width+10, height: greet4Height)
        
        sideViewHeight.constant = btnTextAnumodha.frame.height+btnTextAnumodha.frame.origin.y + greet4Height + 70
        
        //lblCaption.frame = CGRect(x:5,y:btnTextAnumodha.frame.height+btnTextAnumodha.frame.origin.y,width:self.view.frame.width-10,height:greet4Height)
        
        containerController = revealViewController().frontViewController as? ContainerViewController
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func gotoAnuModna(_ selection : UIButton){
        
        let anumodhnaPage = storyboard?.instantiateViewController(withIdentifier: "anumodhnaStoryBoardId") as? AnumodhnaViewController
        anumodhnaPage?.gallery_id = String(selection.tag)
        anumodhnaPage?.fromWhere = "Gallery"
        navigationController?.pushViewController(anumodhnaPage!, animated: true)
        
        
    }
    @objc func gotoDarshan(_ selection : UIButton){
        
        let darshanBoardId = storyboard?.instantiateViewController(withIdentifier: "darshanStoryBoardId") as? DarshanViewController
        darshanBoardId?.gallery_id = String(selection.tag)
        navigationController?.pushViewController(darshanBoardId!, animated: true)
        
        
    }
    
    @objc func gotoComment(_ selection : UIButton){
        
        let commentPage = storyboard?.instantiateViewController(withIdentifier: "commentStoryBoardId") as? CommentViewController
        commentPage?.gallery_id = String(selection.tag)
        commentPage?.fromWhere = "Gallery"
        navigationController?.pushViewController(commentPage!, animated: true)
    }
    
    
    @objc func postAnumodhna(_ selection : UIButton){
        let parameters = "gallery_id=\(selection.accessibilityLabel!)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.post_anumodnas)!
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
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    let jsonObject1 = data![0]
                    
                    print("Anumodhna Repsone--",jsonObject1)
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        let total_anumodan = jsonObject1.object(forKey: "total_anumodan") as? String
                        let error_msg = json?.object(forKey: "error_msg") as? String;
                        if(error_msg == "Liked"){
                            let likeIcon = UIImage(named : "anumodhna_like")
                            self.btnAnumodha.setImage(likeIcon, for: .normal)
                            self.btnTextAnumodha.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
                        }else{
                            let unlikeIcon = UIImage(named : "anumodhna_unlike")
                            self.btnAnumodha.setImage(unlikeIcon, for: .normal)
                            self.btnTextAnumodha.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
                        }
                        
                        self.btnTextAnumodha.setTitle("Anumodna".localized1+"("+(total_anumodan)!+")", for: UIControlState.normal)
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
    
    @objc func postDarshan(_ selection : UIButton){
        let parameters = "gallery_id=\(selection.accessibilityLabel!)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.post_darshans)!
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
                    
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    let jsonObject1 = data![0]
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        
                        let total_darshan = jsonObject1.object(forKey: "total_darshan") as? String
                        
                        let error_msg = json?.object(forKey: "error_msg") as? String;
                        
                        if(error_msg == "Liked"){
                            let likeIcon = UIImage(named : "darshan_like")
                            self.btnDarshan.setImage(likeIcon, for: .normal)
                            self.btnTextDarshan.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
                        }else{
                            let unlikeIcon = UIImage(named : "darshan_unlike")
                            self.btnTextDarshan.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
                            self.btnDarshan.setImage(unlikeIcon, for: .normal)
                        }
                        self.btnTextDarshan.setTitle("Darshan".localized1+"("+(total_darshan)!+")", for: UIControlState.normal)
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
    
    @objc func postBlockImage(_ selection : UIButton){
        let parameters = "gallery_id=\(selection.accessibilityLabel!)&objection_mem_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.block_gallery_image)!
        
        print("urll--",url,parameters)
        
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
                
                print("post block---",json)
                let message = json?.object(forKey: "message") as? String;
                let error_msg = json?.object(forKey: "error_msg") as? String;
                if (message == "Success")
                {
                    
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                    
                        self.navigationController?.popViewController(animated: true)
                        self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                        self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[4])
                        self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                        
                    }
                }else if(message == "fail" && error_msg == "No Data Found"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.navigationController?.popViewController(animated: true)
                        self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                        self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[4])
                        self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.navigationController?.popViewController(animated: true)
                        self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                        self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[4])
                        self.revealViewController().pushFrontViewController(self.containerController,animated:true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
