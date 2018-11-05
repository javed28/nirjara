//
//  MyGalleryViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/3/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyGalleryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    

    var imgGalleryData : [String] = []
    @IBOutlet weak var galleryCollection: UICollectionView!
    var tapassiviData : NSMutableArray = NSMutableArray()
    var GalleryFullDetail : NSMutableArray = NSMutableArray()
    @IBOutlet weak var lblNoImage: UILabel!
    var name = String()
    var profileImage = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
        self.lblNoImage.alpha = 1
        self.galleryCollection.alpha = 1
        self.lblNoImage.text = "No Gallery Post"
        imgGalleryData.removeAll()
        tapassiviData.removeAllObjects()
        GalleryFullDetail.removeAllObjects()
        galleryCollection.reloadData()
        getGallery()
        getTapssaviById()
    }else{
    
    }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.section == 0){
        let yourWidth = (collectionView.bounds.width/3.0)-4
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
        }else{
            let yourWidth = (collectionView.bounds.width/2.0)-4
            let yourHeight : CGFloat = 132.0
            
            return CGSize(width: yourWidth, height: yourHeight)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(section == 0){
            return imgGalleryData.count
        }else{
            return tapassiviData.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            let gotoMyPost = storyboard?.instantiateViewController(withIdentifier: "mydetailIdentifier") as! MyGalleryDetailCntr
            gotoMyPost.GalleryData = GalleryFullDetail[indexPath.row] as! galleryModel
            self.navigationController?.pushViewController(gotoMyPost, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
    
            let size = CGSize(width: self.view.frame.width, height: 50)
            return size
    
        }
    
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
if(indexPath.section == 0){
            let headerView : GalleryHeaderViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "galleryHeaderIdentifier", for: indexPath) as! GalleryHeaderViewCell
            headerView.lblHeader.frame = CGRect(x:0,y:0,width:galleryCollection.frame.width,height:50)
            headerView.lblHeader.text = "Gallery".localized1
            return headerView
}else{
    let headerView : GalleryHeaderViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "galleryHeaderIdentifier", for: indexPath) as! GalleryHeaderViewCell
    headerView.lblHeader.frame = CGRect(x:0,y:0,width:galleryCollection.frame.width,height:50)
    headerView.lblHeader.text = "My Tap".localized1
    return headerView
            }
            }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.section == 0){

        let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: "myGalleryIndentifier", for: indexPath) as! GalleryViewCell
            cell.imgGallery.alpha = 1
            cell.backView.alpha = 0
            cell.tapasvi_image.alpha = 0
            cell.tapassya_name.alpha = 0
            cell.btnComment.alpha = 0
            cell.btnCommentCount.alpha = 0
            cell.btnLikeCount.alpha = 0
            cell.btnLike.alpha = 0
            cell.tapasvi_name.alpha = 0
        let yourWidth = (collectionView.bounds.width/3.0)-4
        cell.imgGallery.frame = CGRect(x:0,y:0,width:yourWidth,height:yourWidth)
        if(imgGalleryData[indexPath.row] == nil || imgGalleryData[indexPath.row] == ""){
            let placeholderImage = UIImage(named: "default-icon")!
            cell.imgGallery.image = placeholderImage
        }else{
            let url = URL(string:(imgGalleryData[indexPath.row]))
            let placeholderImage = UIImage(named: "default-icon")!
            cell.imgGallery.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }
            
            
        return cell
        }else{
            let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: "myGalleryIndentifier", for: indexPath) as! GalleryViewCell
            cell.imgGallery.alpha = 0
            cell.backView.alpha = 1
            cell.tapasvi_image.alpha = 1
            cell.tapassya_name.alpha = 1
            cell.btnComment.alpha = 1
            cell.btnCommentCount.alpha = 1
            cell.btnLikeCount.alpha = 1
            cell.btnLike.alpha = 1
            cell.tapasvi_name.alpha = 1
             let tapData = self.tapassiviData[indexPath.row] as? tapassviModel
            
            cell.backView.frame = CGRect(x:2,y:0,width:(self.galleryCollection.frame.width/2)-6,height:130)
            
            let normalTextVenue = tapData?.tapassya_name
            let boldTextVenue  = "Tap".localized1 + " : "
            let attrsVenue = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 11)]
            var boldStringVenue = NSMutableAttributedString(string: boldTextVenue, attributes:attrsVenue)
            let attributedStringVenue = NSMutableAttributedString(string:normalTextVenue!)
            boldStringVenue.append(attributedStringVenue)
            cell.tapassya_name?.attributedText = boldStringVenue
            
            //let greet4Height = cell.tapasvi_name.optimalHeight
            cell.tapasvi_name.numberOfLines = 2
            cell.tapasvi_name?.text = UserDefaults.standard.getMemberName()
            cell.tapasvi_image.frame = CGRect(x:10,y:10,width:80,height:80)
            cell.tapasvi_name.frame=CGRect(x:93,y:10,width:cell.backView.frame.width-95,height:40)
            
            cell.tapassya_name.frame = CGRect(x:93,y:(cell.tapasvi_name.frame.origin.y)+(cell.tapasvi_name.frame.height),width:cell.backView.frame.width/2,height:20)
           
            let placeholderImage = UIImage(named: "default-icon")!
            if(self.profileImage == nil || self.profileImage == ""){
                cell.tapasvi_image.image = placeholderImage
            }else{
                let url = URL(string:self.profileImage)
                cell.tapasvi_image.af_setImage(withURL: url!, placeholderImage: placeholderImage)
            }
            
            cell.btnCommentCount?.setTitle("( "+(tapData?.total_comment)!+" )", for: .normal)
            cell.btnLikeCount?.setTitle("( "+(tapData?.total_likes)!+" )", for: .normal)
            
            
            cell.btnLike.frame=CGRect(x:5,y:101,width:25,height:25)
            cell.btnLike.tag = indexPath.row
            cell.btnLike.accessibilityLabel = (tapData?.tapasvi_id!)!
            
            
            cell.btnLikeCount.frame=CGRect(x:(cell.btnLike.frame.origin.x)+(cell.btnLike.intrinsicContentSize.width)+3,y:101,width:(cell.btnLikeCount.intrinsicContentSize.width),height:25)
            cell.btnLikeCount.tag = indexPath.row
            cell.btnLikeCount.accessibilityLabel = (tapData?.tapasvi_id!)!
            
            cell.btnComment.frame=CGRect(x:(cell.btnLikeCount.frame.origin.x)+(cell.btnLikeCount.intrinsicContentSize.width)+25,y:101,width:25,height:25)
            cell.btnComment.tag = indexPath.row
            cell.btnComment.accessibilityLabel = (tapData?.tapasvi_id!)!
            
            cell.btnCommentCount.accessibilityLabel = (tapData?.tapasvi_id!)!
            cell.btnCommentCount.frame=CGRect(x:(cell.btnComment.frame.origin.x)+(cell.btnComment.intrinsicContentSize.width),y:101,width:(cell.btnCommentCount.intrinsicContentSize.width),height:25)
            cell.btnCommentCount.tag = indexPath.row
            
            /*if(tapData?.likedUnliked == true){
                let likeIcon = UIImage(named : "namskar-icon-like")
                cell.btnLike.setImage(likeIcon, for: .normal)
            }else{
                let unlikeIcon = UIImage(named : "unlikeTap")
                cell.btnLike.setImage(unlikeIcon, for: .normal)
            }*/
            
            
            cell.btnLike.addTarget(self, action: #selector(gotoAnuModna(_:)), for: UIControlEvents.touchUpInside)
            cell.btnLikeCount.addTarget(self, action: #selector(gotoAnuModna(_:)), for: UIControlEvents.touchUpInside)
            cell.btnComment.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
            cell.btnCommentCount.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
            
            
            cell.backView.addSubview(cell.tapasvi_image)
            cell.backView.addSubview(cell.tapassya_name)
            cell.backView.addSubview(cell.tapasvi_name)
            cell.backView.addSubview(cell.btnComment)
            cell.backView.addSubview(cell.btnCommentCount)
            cell.backView.addSubview(cell.btnLike)
            cell.backView.addSubview(cell.btnLikeCount)
            
            var borderColor: CGColor! = UIColor.black.cgColor
            var borderWidth: CGFloat = 1
            cell.backView.layer.borderWidth = borderWidth
            cell.backView.layer.borderColor = borderColor
            return cell
        }
    }
    
    @objc func gotoAnuModna(_ selection : UIButton){
        
        let anumodhnaPage = storyboard?.instantiateViewController(withIdentifier: "anumodhnaStoryBoardId") as? AnumodhnaViewController
        let ids: String = selection.accessibilityLabel!
        //let seperateIds = ids.components(separatedBy: "::")
        anumodhnaPage?.tapasvi_id = ids
        //anumodhnaPage?.tapassya_id = seperateIds[1]
        anumodhnaPage?.fromWhere = "profileTap"
        navigationController?.pushViewController(anumodhnaPage!, animated: true)
        
    }
    
    @objc func gotoComment(_ selection : UIButton){
        
        let commentPage = storyboard?.instantiateViewController(withIdentifier: "commentStoryBoardId") as? CommentViewController
        let ids: String = selection.accessibilityLabel!
        //let seperateIds = ids.components(separatedBy: "::")
        commentPage?.tapasvi_id = ids
       // commentPage?.tapassya_id = seperateIds[1]
        commentPage?.fromWhere = "profileTap"
        navigationController?.pushViewController(commentPage!, animated: true)
    }
    
    
    @objc func postAnumodhna(_ selection : UIButton){
        
        let ids: String = selection.accessibilityLabel!
        let seperateIds = ids.components(separatedBy: "::")
        
        
        let parameters = "tapasvi_id=\(seperateIds[0])&member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)&tapassya_id=\(seperateIds[1])"
        
        let url = URL(string:ServerUrl.post_tapasvi_likes)!
        
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
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        var updateTapData =  self.tapassiviData[selection.tag] as! tapassviModel
                        
                        var tapData = tapassviModel()
                        tapData.tapasvi_id =  updateTapData.tapasvi_id
                        tapData.tapassya_id = updateTapData.tapassya_id
                        tapData.tapasvi_age = updateTapData.tapasvi_age
                        tapData.tapasvi_name  = updateTapData.tapasvi_name
                        tapData.main_group_name = updateTapData.main_group_name
                        tapData.tapassya_name = updateTapData.tapassya_name
                        tapData.tapasvi_image = updateTapData.tapasvi_image
                        tapData.contact = updateTapData.contact
                        tapData.total_likes = (Int(updateTapData.total_likes)! + 1).description
                        tapData.total_comment = updateTapData.total_comment
                        tapData.likedUnliked = true
                        
                        self.tapassiviData.removeObject(at: selection.tag)
                        self.tapassiviData.insert(tapData, at: Int(selection.tag))
                        let indexPath = IndexPath(item: selection.tag, section: 1)
                        self.galleryCollection.reloadItems(at: [indexPath])
                    }
                    
                }
                else if(Status == "Record Deleted success"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        var updateTapData =  self.tapassiviData[selection.tag] as! tapassviModel
                        
                        var tapData = tapassviModel()
                        tapData.tapasvi_id =  updateTapData.tapasvi_id
                        tapData.tapassya_id = updateTapData.tapassya_id
                        tapData.tapasvi_age = updateTapData.tapasvi_age
                        tapData.tapasvi_name  = updateTapData.tapasvi_name
                        tapData.main_group_name = updateTapData.main_group_name
                        tapData.tapassya_name = updateTapData.tapassya_name
                        tapData.tapasvi_image = updateTapData.tapasvi_image
                        tapData.contact = updateTapData.contact
                        tapData.total_likes = (Int(updateTapData.total_likes)! - 1).description
                        tapData.total_comment = updateTapData.total_comment
                        
                        
                        tapData.likedUnliked = false
                        
                        self.tapassiviData.removeObject(at: selection.tag)
                        self.tapassiviData.insert(tapData, at: Int(selection.tag))
                        let indexPath = IndexPath(item: selection.tag, section: 1)
                        self.galleryCollection.reloadItems(at: [indexPath])
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
    func getGallery(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())"
        //let parameters = "member_id=16"
        let url = URL(string:ServerUrl.get_gallery_by_id)!
        
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

                let message : String =  json!.value(forKey: "message") as! String
                if (message == "success")
                {
                   
                    DispatchQueue.main.async {
                        
                       
                        let viharData = json!.value(forKey: "result") as? [NSDictionary]
                        for j in 0..<viharData!.count{
                           let jsonObject = viharData?[j]
                           let imgGallery = jsonObject?.object(forKey: "larg_image") as? String
                           self.imgGalleryData.append(imgGallery!)
                            
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
                            
                            
                        }
                        //self.lblNoImage.alpha = 0
                        //self.galleryCollection.alpha = 1
                        self.galleryCollection.reloadData()
                    }
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                        
                        //self.lblNoImage.alpha = 1
                        //self.galleryCollection.alpha = 0
                        self.galleryCollection.reloadData()
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
    
    
    func getTapssaviById(){
        
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
       // let url = URL(string:ServerUrl.get_tapasvi_by_id)!
        let url = URL(string:ServerUrl.get_tapasvi_by_idd)!
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
               
                let  message = json?.object(forKey: "message") as? String!
                if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.galleryCollection.reloadData()
                    }
                }else if(message == "success"){
                    DispatchQueue.main.async {
                        
                        self.name = (json?.object(forKey: "name") as? String!)!
                        self.profileImage = (json?.object(forKey: "image") as? String!)!
                        let tapData = json?.object(forKey: "result") as? [NSDictionary]
                        for i in 0..<tapData!.count{
                            let tapModelDat = tapData![i]
                            var tapaivviModel = tapassviModel()
                            tapaivviModel.tapasvi_id = tapModelDat.object(forKey: "tapasvi_id") as? String
                            tapaivviModel.tapassya_name = tapModelDat.object(forKey: "tapassya_name") as? String
                            tapaivviModel.total_likes = tapModelDat.object(forKey: "total_like") as? String
                            tapaivviModel.total_comment = tapModelDat.object(forKey: "total_comment") as? String
                            /*tapaivviModel.tapassya_id = tapModelDat.object(forKey: "tapassya_id") as? String
                            tapaivviModel.tapasvi_age = tapModelDat.object(forKey: "tapasvi_age") as? Int*/
                           /*
                            tapaivviModel.main_group_name = tapModelDat.object(forKey: "main_group_name") as? String
                            tapaivviModel.tapassya_name = tapModelDat.object(forKey: "tapassya_name") as? String
                            tapaivviModel.tapasvi_image = tapModelDat.object(forKey: "tapasvi_image") as? String
                            tapaivviModel.contact = tapModelDat.object(forKey: "contact") as? String
                            if(tapModelDat.object(forKey: "likeUnlike") as? String == "1"){
                                tapaivviModel.likedUnliked = true
                            }else{
                                tapaivviModel.likedUnliked = false
                            }*/
                            self.tapassiviData.add(tapaivviModel)
                        }
                        
                        self.hideActivityIndicator()
                        self.galleryCollection.reloadData()
                        //  self.GetDataFromServer(tapModelDat: tapData!)
                        
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.galleryCollection.reloadData()
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
