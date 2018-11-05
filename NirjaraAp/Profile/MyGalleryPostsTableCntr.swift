//
//  MyGalleryPostsTableCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyGalleryPostsTableCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {

   // var name=["hello","ewwew","hjsdsa"]
    //var date = ["12 march 2017","15 july 2017","10 October 2018"]
    
    var myGalleryData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var tblGallery: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblGallery.separatorStyle = .none
        getMyGalleryData()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 555
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGalleryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblGallery.dequeueReusableCell(withIdentifier: "galleryIdentifier", for: indexPath) as! MyGalleryPostsTableViewCell
        cell.selectionStyle = .none
        
        let GalleryData = myGalleryData[indexPath.row] as? MyGalleryPostModel
        
        cell.lblGalleryName.text = GalleryData?.name
        
        cell.lblDate.text = GalleryData?.date
        cell.lblLocation.text = GalleryData?.location
        
        cell.btnAnumodhaText.setTitle("("+(GalleryData?.anumodnaCount)!+")", for: .normal)
        cell.btnDarshanText.setTitle("("+(GalleryData?.darshanCount)!+")", for: .normal)
        cell.btnCommentText.setTitle("("+(GalleryData?.commentsCount)!+")", for: .normal)
        
        let url = URL(string:(GalleryData?.member_photo)!)
        let placeholderImage = UIImage(named: "default-icon")!
        cell.imgWhoPost.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        
        cell.lblGalleryName.frame = CGRect(x:120,y:10,width:view.frame.width-120,height:30)
        cell.lblLocation.frame = CGRect(x:120,y:42,width:view.frame.width-120,height:30)
        cell.lblDate.frame = CGRect(x:120,y:75,width:view.frame.width-120,height:30)
        
        cell.imgWhoPost.frame = CGRect(x:10,y:10,width:80,height:80)
        cell.imgWhoPost.layer.cornerRadius = cell.imgWhoPost.bounds.size.width / 2.0
        cell.imgWhoPost.clipsToBounds = true
        
        
        
        cell.lineView.frame = CGRect(x:0,y:110,width:view.frame.width,height:1)
        cell.imgWhatpost.frame = CGRect(x:10,y:120,width:view.frame.width-20,height:375)
        
        let postUrl = URL(string:(GalleryData?.larg_image)!)
        cell.imgWhatpost.af_setImage(withURL: postUrl!, placeholderImage: placeholderImage)
        
        cell.btnAnumodha.frame = CGRect(x:10,y:505,width:50,height:50)
        cell.btnAnumodhaText.frame = CGRect(x:60,y:505,width:25,height:50)
        
        cell.btnDarshan.frame = CGRect(x:90,y:505,width:50,height:50)
        cell.btnDarshanText.frame = CGRect(x:140,y:505,width:25,height:50)
        
        cell.btnComment.frame = CGRect(x:180,y:505,width:50,height:50)
        cell.btnCommentText.frame = CGRect(x:238,y:505,width:25,height:50)
        
        
        cell.btnAnumodha.addTarget(self, action: #selector(postAnumodhna(_:)), for: UIControlEvents.touchUpInside)
        cell.btnDarshan.addTarget(self, action: #selector(postDarshan(_:)), for: UIControlEvents.touchUpInside)
        cell.btnComment.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
       
        
        cell.btnAnumodha.tag = indexPath.row
        cell.btnAnumodha.accessibilityLabel = GalleryData?.gallery_id!
        cell.btnDarshan.tag = indexPath.row
        cell.btnDarshan.accessibilityLabel = GalleryData?.gallery_id!
        cell.btnComment.accessibilityLabel = GalleryData?.gallery_id!
        
        
        cell.btnAnumodhaText.addTarget(self, action: #selector(gotoAnuModna(_:)), for: UIControlEvents.touchUpInside)
        cell.btnDarshanText.addTarget(self, action: #selector(gotoDarshan(_:)), for: UIControlEvents.touchUpInside)
        cell.btnCommentText.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
        cell.btnComment.tag = Int((GalleryData?.gallery_id)!)!
        cell.btnAnumodhaText.tag = Int((GalleryData?.gallery_id)!)!
        cell.btnDarshanText.tag = Int((GalleryData?.gallery_id)!)!
        cell.btnCommentText.tag = Int((GalleryData?.gallery_id)!)!
 
        return cell
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
                
                print("post anumodhna--",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    let jsonObject1 = data![0]
                    
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        let total_anumodan = jsonObject1.object(forKey: "total_anumodan") as? String
                        
                        
                        var updateGallery =  self.myGalleryData[selection.tag] as! MyGalleryPostModel
                        
                        var galleryData = MyGalleryPostModel()
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
                        galleryData.anumodan_liked = updateGallery.anumodan_liked
                        galleryData.darshanCount = updateGallery.darshanCount
                        galleryData.anumodnaCount = total_anumodan
                        galleryData.commentsCount = updateGallery.commentsCount
                        
                        self.myGalleryData.removeObject(at: selection.tag)
                        self.myGalleryData.insert(galleryData, at: Int(selection.tag))
                        
                        
                        let indexPath = IndexPath(item: selection.tag, section: 0)
                        self.tblGallery.reloadRows(at: [indexPath], with: .top)
                        
                        
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
                
                print("post darshan--",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    
                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    let jsonObject1 = data![0]
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        
                        let total_darshan = jsonObject1.object(forKey: "total_darshan") as? String
                        
                        
                        var updateGallery =  self.myGalleryData[selection.tag] as! MyGalleryPostModel
                        
                        var galleryData = MyGalleryPostModel()
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
                        galleryData.anumodan_liked = updateGallery.anumodan_liked
                        galleryData.darshanCount = total_darshan
                        galleryData.anumodnaCount = updateGallery.anumodnaCount
                        galleryData.commentsCount = updateGallery.commentsCount
                        
                        self.myGalleryData.removeObject(at: selection.tag)
                        self.myGalleryData.insert(galleryData, at: Int(selection.tag))
                        
                        
                        let indexPath = IndexPath(item: selection.tag, section: 0)
                        self.tblGallery.reloadRows(at: [indexPath], with: .top)
                        
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
    
    
    func getMyGalleryData(){
         let parameters = "member_id="+UserDefaults.standard.getUserID()
        //let parameters = "member_id=200"
        let url = URL(string:ServerUrl.get_gallery_by_id)!
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
                
                let message = json?.object(forKey: "message") as? String;
                if (message == "success")
                {
                    
                    
                    let  mybusinessData = json?.object(forKey: "result") as? [NSDictionary]
                    for j in 0..<mybusinessData!.count{
                        let jsonObject = mybusinessData?[j]
                        var mygalleryData = MyGalleryPostModel()

                        
                        mygalleryData.gallery_id = jsonObject?.object(forKey: "gallery_id") as? String
                        mygalleryData.name = jsonObject?.object(forKey: "name") as? String
                        mygalleryData.member_photo = jsonObject?.object(forKey: "member_photo") as? String
                        mygalleryData.title = jsonObject?.object(forKey: "title") as? String
                        mygalleryData.date = jsonObject?.object(forKey: "date") as? String
                        mygalleryData.location = jsonObject?.object(forKey: "location") as? String
                        mygalleryData.larg_image = jsonObject?.object(forKey: "larg_image") as? String
                        mygalleryData.small_image = jsonObject?.object(forKey: "small_image") as? String
                        mygalleryData.darshan_liked = jsonObject?.object(forKey: "darshan_liked") as? String
                        mygalleryData.anumodan_liked = jsonObject?.object(forKey: "anumodan_liked") as? String
                        mygalleryData.darshanCount = jsonObject?.object(forKey: "darshanCount") as? String
                        mygalleryData.anumodnaCount = jsonObject?.object(forKey: "anumodnaCount") as? String
                        mygalleryData.commentsCount = jsonObject?.object(forKey: "commentsCount") as? String
                        //mygalleryData.latest_comments = jsonObject?.object(forKey: "anumodnaCount") as? String
                        
                        
                        self.myGalleryData.add(mygalleryData)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tblGallery.reloadData()
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
