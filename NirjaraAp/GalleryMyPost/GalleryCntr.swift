//
//  GalleryCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import AlamofireImage
import SDWebImage

class GalleryCntr: UIViewController, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    
    
    
    //var name = ["hello","hello1","dhjsadhaj88"]
    //var date = ["12 march 2017","15 july 2017","10 October 2018"]
    var indexOfCellToExpand: Int!
    var heightAtIndexPath = NSMutableDictionary()
    var expandedLabel: UILabel!
    //var galleryFullData : NSMutableArray = NSMutableArray()
    var member_photo : [String] =  []
    var gallery_photo : [String] =  []
    @IBOutlet weak var galleryTableView: UITableView!
    var GalleryFullDetail : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       indexOfCellToExpand = -1

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Gallery"
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        
        
        titleLabel.attributedText = myMutableString
       
    
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        self.addShadowToBarMap()
       // galleryTableView.decelerationRate = UIScrollViewDecelerationRateFast;
        galleryTableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        //GalleryFullDetail.removeAllObjects()
        if isConnectedToNetwork() {
        self.galleryTableView.estimatedRowHeight = 570
        self.galleryTableView.rowHeight = UITableViewAutomaticDimension
        getGalleryData(strOffSet: GalleryFullDetail.count)
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
   /* func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == indexOfCellToExpand
            {
                return 570 + expandedLabel.frame.height  - 38
            }else{
                return 570
            }
        
//        let height = self.heightAtIndexPath.object(forKey: indexPath)
//        if ((height) != nil) {
//            return CGFloat(570)
//        } else {
//            return 570
//        }
    }*/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == indexOfCellToExpand
        {
            return 570 + expandedLabel.frame.height  - 38
        }else{
            return 570
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = GalleryFullDetail.count - 1
        if(indexPath.row) == index{
            if isConnectedToNetwork() {
            getGalleryData(strOffSet: GalleryFullDetail.count)
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
        }else{

        }
       // let height = cell.frame.size.height
        //self.heightAtIndexPath.setObject(height, forKey: indexPath as NSCopying)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GalleryFullDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = galleryTableView.dequeueReusableCell(withIdentifier: "galleryIdentifier", for: indexPath) as! GallleryTableViewCell
        
        
        var cell:GallleryTableViewCell? = galleryTableView.dequeueReusableCell(withIdentifier: "galleryIdentifier") as? GallleryTableViewCell
        if (cell == nil) {
            cell = GallleryTableViewCell(style:.default, reuseIdentifier:"galleryIdentifier")
        }
        
        
        let GalleryData = self.GalleryFullDetail[indexPath.row] as? galleryModel
        cell?.selectionStyle = .none
        cell?.lblWhoPostName.text = GalleryData?.name
        cell?.lblDate.text = GalleryData?.date.convertDateFormater((GalleryData?.date)!)
        cell?.lblDate.text = GalleryData?.date
    
        cell?.imgWhoPost.layer.cornerRadius = (cell?.imgWhoPost.bounds.size.width)! / 2.0
        cell?.imgWhoPost.clipsToBounds = true
    
        
        /*DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
            let placeholderImage = UIImage(named: "default_icon_new")!
                // let url = URL(string:(GalleryData?.member_photo)!)
            let url = URL(string:self.member_photo[indexPath.row])
                cell?.imgWhoPost.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                
                // let postUrl = URL(string:(GalleryData?.larg_image)!)
            let postUrl = URL(string:self.gallery_photo[indexPath.row])
                cell?.imgWhatpost.af_setImage(withURL: postUrl!,placeholderImage: placeholderImage)
            }
        }*/
        
    
        /*let thumbImageUrl = NSURL(string: self.member_photo[indexPath.row] as String)
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
            if image != nil {
                DispatchQueue.main.async{
                    cell?.imgWhoPost.image = image
                }
            }
        })
         let thumbImageUrl1  =   NSURL(string: self.gallery_photo[indexPath.row] as String)
         SDWebImageManager.shared().imageDownloader?.downloadImage(with: thumbImageUrl1 as URL?, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil,  completed: { (image, data, error, bool) -> Void in
         if image != nil {
         DispatchQueue.main.async{
         cell?.imgWhatpost.image = image
         }
         }
         })*/
        cell?.imgWhoPost.sd_setImage(with: URL(string: self.member_photo[indexPath.row]), placeholderImage: UIImage(named: "default_icon_new"))
        cell?.imgWhatpost.sd_setImage(with: URL(string: self.gallery_photo[indexPath.row]), placeholderImage: UIImage(named: "default_icon_new"))
        
        cell?.imgWhatpost.backgroundColor = UIColor.white
        if(GalleryData?.anumodan_liked == "true"){
            let likeIcon = UIImage(named : "anumodhna_like")
            cell?.btnAnumodha.setImage(likeIcon, for: .normal)
            cell?.btnTextAnumodha.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
        }else{
            let unlikeIcon = UIImage(named : "anumodhna_unlike")
            cell?.btnAnumodha.setImage(unlikeIcon, for: .normal)
            cell?.btnTextAnumodha.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
        }
        
        if(GalleryData?.darshan_liked == "true"){
            let likeIcon = UIImage(named : "darshan_like")
            cell?.btnDarshan.setImage(likeIcon, for: .normal)
            cell?.btnTextDarshan.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
        }else{
            let unlikeIcon = UIImage(named : "darshan_unlike")
            cell?.btnTextDarshan.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
            cell?.btnDarshan.setImage(unlikeIcon, for: .normal)
        }
        
                cell?.btnAnumodha.addTarget(self, action: #selector(self.postAnumodhna(_:)), for: UIControlEvents.touchUpInside)
                cell?.btnDarshan.addTarget(self, action: #selector(self.postDarshan(_:)), for: UIControlEvents.touchUpInside)
                cell?.btnComment.addTarget(self, action: #selector(self.gotoComment(_:)), for: UIControlEvents.touchUpInside)
                cell?.btnBlock.addTarget(self, action: #selector(self.postBlockImage(_:)), for: UIControlEvents.touchUpInside)
        
        cell?.btnAnumodha.tag = indexPath.row
        cell?.btnAnumodha.accessibilityLabel = GalleryData?.gallery_id!
        cell?.btnDarshan.tag = indexPath.row
        cell?.btnDarshan.accessibilityLabel = GalleryData?.gallery_id!
        cell?.btnBlock.tag = indexPath.row
        cell?.btnBlock.accessibilityLabel = GalleryData?.gallery_id!
        cell?.btnComment.accessibilityLabel = GalleryData?.gallery_id!
        
        cell?.btnTextAnumodha.setTitle("Anumodna".localized1+"("+(GalleryData?.anumodnaCount)!+")", for: UIControlState.normal)
        cell?.btnTextDarshan.setTitle("Darshan".localized1+"("+(GalleryData?.darshanCount)!+")", for: UIControlState.normal)
        cell?.btnTextComment.setTitle("Comments".localized1+"("+(GalleryData?.commentsCount)!+")", for: UIControlState.normal)
        
        
        
       /* cell.btnTextAnumodha.frame = CGRect(x:5,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+28,width:cell.btnTextAnumodha.intrinsicContentSize.width+10,height:40)
        cell.btnTextDarshan.frame = CGRect(x:cell.btnTextAnumodha.frame.origin.x+cell.btnTextAnumodha.frame.width+2,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+28,width:cell.btnTextDarshan.intrinsicContentSize.width+10,height:40)
        cell.btnTextComment.frame = CGRect(x:cell.btnTextDarshan.frame.origin.x+cell.btnTextDarshan.frame.width+2,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+28,width:cell.btnTextComment.intrinsicContentSize.width+10,height:40)
        
        cell.btnAnumodha.frame = CGRect(x:cell.btnTextAnumodha.frame.origin.x+cell.btnTextAnumodha.frame.width/2-17.5,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+5,width:35,height:35)
        cell.btnDarshan.frame = CGRect(x:cell.btnTextDarshan.frame.origin.x+cell.btnTextDarshan.frame.width/2-17.5,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+5,width:35,height:35)
        cell.btnComment.frame = CGRect(x:cell.btnTextComment.frame.origin.x+cell.btnTextComment.frame.width/2-17.5,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+5,width:35,height:35)
        cell.btnBlock.frame = CGRect(x:self.view.frame.width-60,y:cell.imgWhatpost.frame.origin.y+cell.imgWhatpost.frame.height+5,width:35,height:35)
        */
        
        
                cell?.btnTextAnumodha.addTarget(self, action: #selector(self.gotoAnuModna(_:)), for: UIControlEvents.touchUpInside)
                cell?.btnTextDarshan.addTarget(self, action: #selector(self.gotoDarshan(_:)), for: UIControlEvents.touchUpInside)
        cell?.btnTextComment.addTarget(self, action: #selector(self.gotoComment(_:)), for: UIControlEvents.touchUpInside)
        cell?.btnComment.tag = Int((GalleryData?.gallery_id)!)!
        cell?.btnTextAnumodha.tag = Int((GalleryData?.gallery_id)!)!
        cell?.btnTextDarshan.tag = Int((GalleryData?.gallery_id)!)!
        cell?.btnTextComment.tag = Int((GalleryData?.gallery_id)!)!
        
       
       
        //cell.lblCaption.text = GalleryData?.title
        //cell.lblCaption.lineBreakMode = .byWordWrapping
        //cell.lblCaption.numberOfLines = 3;
        //cell.lblCaption.frame = CGRect(x:8,y:cell.btnTextAnumodha.frame.height+cell.btnTextAnumodha.frame.origin.y,width:self.view.frame.width-16,height:60)
      
        if(GalleryData?.title == nil || GalleryData?.title == ""){
             //cell.lblCaption.text = "No Caption"
            cell?.lblCaption.text = "No Caption"
            
        }else{
        /*let currentSource = preparedSources(textToShow:(GalleryData?.title)!)[indexPath.row]
        cell.lblCaption.delegate = self
        cell.lblCaption.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: currentSource.textAlignment)
        cell.lblCaption.shouldCollapse = true
        cell.lblCaption.textReplacementType = currentSource.textReplacementType
        cell.lblCaption.numberOfLines = currentSource.numberOfLines
        cell.lblCaption.collapsed = ((GalleryData?.title) != nil)
        cell.lblCaption.text = currentSource.text
        
        cell.layoutIfNeeded()*/
            let data1 = GalleryData?.title.data(using: String.Encoding.utf8)
            let messageString = String(data : data1!,encoding : String.Encoding.nonLossyASCII)
           // let decodedString = messageString
            cell?.lblCaption.text = messageString
            
        }
        cell?.lblCaption.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(GalleryCntr.expandCell(sender:)))
        cell?.lblCaption.addGestureRecognizer(tap)
        cell?.lblCaption.isUserInteractionEnabled = true

        
      /*  cell?.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.lightgray).cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell?.layer.frame = CGRect(x:10,y:(cell?.lblCaption.frame.height)!+(cell?.lblCaption.frame.origin.y)!,width:view.frame.width-20,height:2)
        cell?.layer.shadowOpacity = 1
        cell?.layer.shadowRadius = 0
        cell?.layer.masksToBounds = false*/
            
        return cell!
    }
   
    @objc func expandCell(sender: UITapGestureRecognizer)
    {
        let label = sender.view as! UILabel
        
        let cell: GallleryTableViewCell = galleryTableView.cellForRow(at: IndexPath(row: label.tag, section: 0)) as! GallleryTableViewCell
        let GalleryData = GalleryFullDetail[label.tag] as? galleryModel
        let description = GalleryData?.title
        cell.lblCaption.sizeToFit()
        cell.lblCaption.text = description
        expandedLabel = cell.lblCaption
        indexOfCellToExpand = label.tag
        galleryTableView.reloadRows(at: [IndexPath(row: label.tag, section: 0)], with: .fade)
        //galleryTableView.scrollToRow(at: IndexPath(row: label.tag, section: 0), at: .top, animated: true)
    }
    /* func preparedSources(textToShow : String) -> [(text: String,textReplacementType: ExpandableLabel.TextReplacementType, numberOfLines: Int, textAlignment: NSTextAlignment)] {
       
        return [(textToShow,.word, 3, .left)]
    }
    
   func willExpandLabel(_ label: ExpandableLabel) {
        galleryTableView.beginUpdates()
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: galleryTableView)
        if let indexPath = galleryTableView.indexPathForRow(at: point) as IndexPath? {
            //let GalleryData = galleryFullData[postion] as? galleryModel
            
            galleryFullData[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.galleryTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        galleryTableView.endUpdates()
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        galleryTableView.beginUpdates()
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: galleryTableView)
        if let indexPath = galleryTableView.indexPathForRow(at: point) as IndexPath? {
            galleryFullData[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.galleryTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        galleryTableView.endUpdates()
    }*/
    
    
    
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
        //self.showActivityIndicator()
        
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
                        //self.hideActivityIndicator()
                        let total_anumodan = jsonObject1.object(forKey: "total_anumodan") as? String
                        
                        
                        var updateGallery =  self.GalleryFullDetail[selection.tag] as! galleryModel
                        
                        var galleryData = galleryModel()
                        galleryData.gallery_id =  updateGallery.gallery_id
                        galleryData.name = updateGallery.name
                        galleryData.member_photo = updateGallery.member_photo
                        galleryData.title  = updateGallery.title
                        galleryData.description = updateGallery.description
                        galleryData.date = updateGallery.date
                        galleryData.location = updateGallery.location
                        galleryData.larg_image = updateGallery.larg_image
                        galleryData.small_image = updateGallery.small_image
                        galleryData.darshan_liked = updateGallery.darshan_liked
                        
                        galleryData.darshanCount = updateGallery.darshanCount
                        galleryData.anumodnaCount = total_anumodan
                        galleryData.commentsCount = updateGallery.commentsCount

                        
                        let error_msg = json?.object(forKey: "error_msg") as? String;
                        if(error_msg == "Liked"){
                            galleryData.anumodan_liked = "true"
                        }else{
                            galleryData.anumodan_liked = "false"
                        }
                        
                        self.GalleryFullDetail.removeObject(at: selection.tag)
                        self.GalleryFullDetail.insert(galleryData, at: Int(selection.tag))
                        
                        
                        let indexPath = IndexPath(item: selection.tag, section: 0)
                        self.galleryTableView.reloadRows(at: [indexPath], with: .none)

                    }
                }
                else{
                    DispatchQueue.main.async {
                       // self.hideActivityIndicator()
                        
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
        //self.showActivityIndicator()
        
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
                        //self.hideActivityIndicator()
                       
                        
                        let total_darshan = jsonObject1.object(forKey: "total_darshan") as? String
                        var updateGallery =  self.GalleryFullDetail[selection.tag] as! galleryModel
                        
                        var galleryData = galleryModel()
                        galleryData.gallery_id =  updateGallery.gallery_id
                        galleryData.name = updateGallery.name
                        galleryData.member_photo = updateGallery.member_photo
                        galleryData.title  = updateGallery.title
                        galleryData.description = updateGallery.description
                        galleryData.date = updateGallery.date
                        galleryData.location = updateGallery.location
                        galleryData.larg_image = updateGallery.larg_image
                        galleryData.small_image = updateGallery.small_image
                       
                        galleryData.anumodan_liked = updateGallery.anumodan_liked
                        galleryData.darshanCount = total_darshan
                        galleryData.anumodnaCount = updateGallery.anumodnaCount
                        galleryData.commentsCount = updateGallery.commentsCount
                        
                        let error_msg = json?.object(forKey: "error_msg") as? String;
                        
                        if(error_msg == "Liked"){
                            galleryData.darshan_liked = "true"
                        }else{
                            galleryData.darshan_liked = "false"
                        }
                        
                        self.GalleryFullDetail.removeObject(at: selection.tag)
                        self.GalleryFullDetail.insert(galleryData, at: Int(selection.tag))
                        
                        
                        let indexPath = IndexPath(item: selection.tag, section: 0)
                        self.galleryTableView.reloadRows(at: [indexPath], with: .none)
                    
                    }
                }
                else{
                    DispatchQueue.main.async {
                        //self.hideActivityIndicator()
                        
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
                       self.GalleryFullDetail.removeObject(at: selection.tag)
                        self.member_photo.remove(at: selection.tag)
                        self.gallery_photo.remove(at: selection.tag)
                       self.galleryTableView.reloadData()
                        
                    }
                }else if(message == "fail" && error_msg == "No Data Found"){
                    DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.GalleryFullDetail.removeAllObjects()
                    self.galleryTableView.reloadData()
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
    
    func getGalleryData(strOffSet : Int){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())&offset=\(strOffSet)&limit=10"
        //let url = URL(string:ServerUrl.get_gallery)!
        let url = URL(string:ServerUrl.get_ten_gallery)!
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
                        var galleryData = galleryModel()
                        galleryData.gallery_id = jsonObject?.object(forKey: "gallery_id") as? String
                        galleryData.name = jsonObject?.object(forKey: "name") as? String
                        galleryData.member_photo = jsonObject?.object(forKey: "member_photo") as? String
                        galleryData.title = jsonObject?.object(forKey: "title") as? String
                        galleryData.description = jsonObject?.object(forKey: "description") as? String
                        galleryData.date = jsonObject?.object(forKey: "date") as? String
                        galleryData.location = jsonObject?.object(forKey: "location") as? String
                        galleryData.larg_image = jsonObject?.object(forKey: "larg_image") as? String
                        galleryData.small_image = jsonObject?.object(forKey: "small_image") as? String
                        galleryData.darshan_liked = jsonObject?.object(forKey: "darshan_liked") as? String
                        galleryData.anumodan_liked = jsonObject?.object(forKey: "anumodan_liked") as? String
                        galleryData.darshanCount = jsonObject?.object(forKey: "darshanCount") as? String
                        galleryData.anumodnaCount = jsonObject?.object(forKey: "anumodnaCount") as? String
                        galleryData.commentsCount = jsonObject?.object(forKey: "commentsCount") as? String
                        
                        self.GalleryFullDetail.add(galleryData)
                        self.member_photo.append((jsonObject?.object(forKey: "member_photo") as? String)!)
                        self.gallery_photo.append((jsonObject?.object(forKey: "larg_image") as? String)!)
                        
                    }
                    
                    DispatchQueue.main.async {
                          self.hideActivityIndicator()
                        self.galleryTableView.reloadData()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        //self.hideActivityIndicator()
                        
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

