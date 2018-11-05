//
//  TapasviSukhCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class TapasviSukhCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var lblNoRecord: UILabel!
    var tapassiviData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var tapTableView: UITableView!
     var titleNote : String = "करेने वाला, कराने वाला और अनुमोदना करने वाला सब का फल एक सामान बताया गया है। तपस्वी यहां पर अपने प्रतिदिन की तपस्या ADD करे और सम्पूर्ण समाज को प्रेरणा दे। जो तप न कर सके वे कम से कम तपस्वीओं की अनुमोदना करे, उनका मनोबल बढाये और अनुमोदना का लाभ प्राप्त करे।"
    var note_color : String = "#001669"
    var note_font_color : String = "#f4ff00"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Tapasvi Sukh Satha"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:15))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:15,length:5))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        self.addShadowToBarMap()
        sideMenu()
        // Do any additional setup after loading the view.
    }
    @objc func addTapped(){
        
    }
    override func viewWillAppear(_ animated: Bool) {
         if isConnectedToNetwork() {
        tapassiviData.removeAllObjects()
        self.tapTableView.alpha = 1
        self.lblNoRecord.alpha = 0
        getTapssaviData()
         }else{
            
        }
        
    }
    func sideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tapassiviData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "detailsIdentifier", sender: self)
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tapTableView.dequeueReusableCell(withIdentifier: "tapasiviIHeaderdentifier") as! TapassiviHeaderTableViewCell
        
        headerView.backView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:140)
        headerView.lblNote.text = self.titleNote
        
        let greet4Height = headerView.lblNote.optimalHeight
        headerView.lblNote.frame = CGRect(x:10,y:0,width:headerView.backView.frame.width-20,height:greet4Height)
        headerView.lblNote.lineBreakMode = .byWordWrapping
        headerView.lblNote.numberOfLines = 0
        //headerView.lblNote.textColor = UIColor.rgb(hexcolor: "#fafb00")
        headerView.backView.backgroundColor = UIColor.rgb(hexcolor: note_color)
        headerView.lblNote.textColor = UIColor.rgb(hexcolor: note_font_color)
        
        headerView.backView.addSubview(headerView.lblNote)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tapTableView.dequeueReusableCell(withIdentifier: "tapasiviIdentifier", for: indexPath) as? TapassviTableViewCell
        
        let tapData = self.tapassiviData[indexPath.row] as? tapassviModel
        
        cell?.selectionStyle = .none
        cell?.tapasvi_name?.text = tapData?.tapasvi_name
        var agetext = String(describing: tapData?.tapasvi_age!)
        agetext = agetext.replacingOccurrences(of: "Optional", with: "")
        agetext = agetext.replacingOccurrences(of: "(", with: "")
        agetext = agetext.replacingOccurrences(of: ")", with: "")
        
        
        let To = agetext
        let boldTextTo  = "Age".localized1 + " : "
        let attrsTo = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        var boldStringTo = NSMutableAttributedString(string: boldTextTo, attributes:attrsTo)
        let attributedStringTo = NSMutableAttributedString(string:To)
        boldStringTo.append(attributedStringTo)
        cell?.tapasvi_age?.attributedText = boldStringTo
        
        let normalTextVenue = tapData?.tapassya_name
        let boldTextVenue  = "Tap".localized1 + " : "
        let attrsVenue = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        var boldStringVenue = NSMutableAttributedString(string: boldTextVenue, attributes:attrsVenue)
        let attributedStringVenue = NSMutableAttributedString(string:normalTextVenue!)
        boldStringVenue.append(attributedStringVenue)
        cell?.tapassya_name?.attributedText = boldStringVenue
        
        if(tapData?.place == nil){
            
            let From = " "
            let FromText  = "Place".localized1 + " : "
            let attrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
            var boldStringFrom = NSMutableAttributedString(string: FromText, attributes:attrsFrom)
            let attributedStringFrom = NSMutableAttributedString(string:From)
            boldStringFrom.append(attributedStringFrom)
            cell?.place?.attributedText = boldStringFrom
        }else{
            
            let From = tapData?.place
            let FromText  = "Place".localized1 + " : "
            let attrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
            var boldStringFrom = NSMutableAttributedString(string: FromText, attributes:attrsFrom)
            let attributedStringFrom = NSMutableAttributedString(string:From!)
            boldStringFrom.append(attributedStringFrom)
            cell?.place?.attributedText = boldStringFrom
        }
        

        
        cell?.total_comment?.setTitle((tapData?.total_comment)!+"  "+"Comments".localized1, for: .normal)
        cell?.total_likes?.setTitle((tapData?.total_likes)!+"  "+"Anumodna".localized1, for: .normal)
        
        //let imageView = UIImageView()
        let url = URL(string:(tapData?.tapasvi_image)!)
        let placeholderImage = UIImage(named: "default-icon")!
        
        if(url == nil || tapData?.tapasvi_image == ""){
            cell?.tapasvi_image.image = placeholderImage
        }else{
            cell?.tapasvi_image.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }
        
        if(tapData?.main_group_name == "Terapanthi"){
            let image : UIImage = UIImage(named: "terapanthi")!
            cell?.imgMainGroup.image = image
        }else  if(tapData?.main_group_name == "Digamber"){
            let image : UIImage = UIImage(named: "digamber")!
            cell?.imgMainGroup.image = image
        }else  if(tapData?.main_group_name == "Sthanakwasi"){
            let image : UIImage = UIImage(named: "sthanakwasi")!
            cell?.imgMainGroup.image = image
        }else  if(tapData?.main_group_name == "Murtipujak"){
            let image : UIImage = UIImage(named: "murtipujak")!
            cell?.imgMainGroup.image = image
        }else {
            cell?.imgMainGroup.alpha = 0
        }

        
        cell?.tapasvi_image.frame=CGRect(x:10,y:10,width:100,height:100)
        //let greet4Height = cell?.tapasvi_name.optimalHeight
        cell?.tapasvi_name.frame=CGRect(x:115,y:6,width:self.view.frame.width-235,height:37)
        
        cell?.tapasvi_age.frame=CGRect(x:115,y:(cell?.tapasvi_name.frame.origin.y)!+(cell?.tapasvi_name.frame.height)!,width:self.view.frame.width-115,height:20)
     
        cell?.place.frame=CGRect(x:115,y:(cell?.tapasvi_age.frame.origin.y)!+(cell?.tapasvi_age.frame.height)!+3,width:self.view.frame.width-115,height:20)
        cell?.tapassya_name.frame = CGRect(x:115,y:(cell?.place.frame.origin.y)!+(cell?.place.frame.height)!+3,width:self.view.frame.width-135,height:20)
        cell?.imgMainGroup.frame=CGRect(x:self.view.frame.width-100,y:10,width:90,height:50)
        
        
        cell?.btnAnumodhnaLike.frame=CGRect(x:10,y:110,width:50,height:50)
        cell?.btnAnumodhnaLike.tag = indexPath.row
        cell?.btnAnumodhnaLike.accessibilityLabel = (tapData?.tapasvi_id!)!+"::"+(tapData?.tapassya_id!)!
        
        
        cell?.total_likes.frame=CGRect(x:65,y:110,width:(cell?.total_likes.intrinsicContentSize.width)!,height:50)
        cell?.total_likes.tag = indexPath.row

        cell?.total_likes.accessibilityLabel = (tapData?.tapasvi_id!)!+"::"+(tapData?.tapassya_id!)!
        
        cell?.btnComment.frame=CGRect(x:self.view.frame.width/2,y:110,width:50,height:50)
        cell?.btnComment.tag = indexPath.row
        
        cell?.btnComment.accessibilityLabel = (tapData?.tapasvi_id!)!+"::"+(tapData?.tapassya_id!)!
        cell?.total_comment.accessibilityLabel = (tapData?.tapasvi_id!)!+"::"+(tapData?.tapassya_id!)!
        
        cell?.total_comment.frame=CGRect(x:self.view.frame.width/2+65,y:110,width:(cell?.total_comment.intrinsicContentSize.width)!,height:50)
        cell?.total_comment.tag = indexPath.row
       
        if(tapData?.likedUnliked == true){
            let likeIcon = UIImage(named : "namskar-icon-like")
            cell?.btnAnumodhnaLike.setImage(likeIcon, for: .normal)
            cell?.total_likes.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
        }else{
            let unlikeIcon = UIImage(named : "unlikeTap")
           cell?.btnAnumodhnaLike.setImage(unlikeIcon, for: .normal)
            cell?.total_likes.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.titleColor), for: .normal)
        }
        
        cell?.btnAnumodhnaLike.addTarget(self, action: #selector(postAnumodhna(_:)), for: UIControlEvents.touchUpInside)
        cell?.total_likes.addTarget(self, action: #selector(gotoAnuModna(_:)), for: UIControlEvents.touchUpInside)
        cell?.btnComment.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
        cell?.total_comment.addTarget(self, action: #selector(gotoComment(_:)), for: UIControlEvents.touchUpInside)
        
        cell?.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.lightgray).cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell?.layer.shadowOpacity = 1
        cell?.layer.shadowRadius = 0
        cell?.layer.masksToBounds = false
        
        return cell!
    }
    
    @objc func gotoAnuModna(_ selection : UIButton){
        
        let anumodhnaPage = storyboard?.instantiateViewController(withIdentifier: "anumodhnaStoryBoardId") as? AnumodhnaViewController
        let ids: String = selection.accessibilityLabel!
        let seperateIds = ids.components(separatedBy: "::")
        anumodhnaPage?.tapasvi_id = seperateIds[0]
        anumodhnaPage?.tapassya_id = seperateIds[1]
        anumodhnaPage?.fromWhere = "Tapassavi"
        navigationController?.pushViewController(anumodhnaPage!, animated: true)
   
    }
    
    @objc func gotoComment(_ selection : UIButton){
        
        let commentPage = storyboard?.instantiateViewController(withIdentifier: "commentStoryBoardId") as? CommentViewController
        let ids: String = selection.accessibilityLabel!
        let seperateIds = ids.components(separatedBy: "::")
        commentPage?.tapasvi_id = seperateIds[0]
        commentPage?.tapassya_id = seperateIds[1]
        commentPage?.fromWhere = "Tapassavi"
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
                                                tapData.place = updateTapData.place
                                                tapData.tapasvi_image = updateTapData.tapasvi_image
                                                tapData.contact = updateTapData.contact
                                                tapData.total_likes = (Int(updateTapData.total_likes)! + 1).description
                                                tapData.total_comment = updateTapData.total_comment
                                                tapData.likedUnliked = true
                       
                     self.tapassiviData.removeObject(at: selection.tag)
                     self.tapassiviData.insert(tapData, at: Int(selection.tag))
                     let indexPath = IndexPath(item: selection.tag, section: 0)
                     self.tapTableView.reloadRows(at: [indexPath], with: .none)
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
                    tapData.place = updateTapData.place
                    tapData.contact = updateTapData.contact
                    tapData.total_likes = (Int(updateTapData.total_likes)! - 1).description
                    tapData.total_comment = updateTapData.total_comment
                    
                    
                        tapData.likedUnliked = false
                    
                    self.tapassiviData.removeObject(at: selection.tag)
                    self.tapassiviData.insert(tapData, at: Int(selection.tag))
                    let indexPath = IndexPath(item: selection.tag, section: 0)
                    self.tapTableView.reloadRows(at: [indexPath], with: .none)
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
    
    func getTapssaviData(){
        
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_tapasvi_detail_with_like)!
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
                self.titleNote = (json?.object(forKey: "note") as? String)!
                self.note_color = (json?.object(forKey: "note_color") as? String)!
                self.note_font_color = (json?.object(forKey: "note_font_color") as? String)!
                let  message = json?.object(forKey: "message") as? String!
                if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tapTableView.reloadData()
                        self.lblNoRecord.alpha = 1
                    }
                }else if(message == "success"){
                    DispatchQueue.main.async {
                        self.lblNoRecord.alpha = 0
                    let tapData = json?.object(forKey: "result") as? [NSDictionary]
                        for i in 0..<tapData!.count{
                        let tapModelDat = tapData![i]
                        var tapaivviModel = tapassviModel()
                        tapaivviModel.tapasvi_id = tapModelDat.object(forKey: "tapasvi_id") as? String
                        tapaivviModel.tapassya_id = tapModelDat.object(forKey: "tapassya_id") as? String
                        tapaivviModel.tapasvi_age = tapModelDat.object(forKey: "tapasvi_age") as? Int
                        tapaivviModel.tapasvi_name = tapModelDat.object(forKey: "tapasvi_name") as? String
                        tapaivviModel.main_group_name = tapModelDat.object(forKey: "main_group_name") as? String
                        tapaivviModel.tapassya_name = tapModelDat.object(forKey: "tapassya_name") as? String
                        tapaivviModel.tapasvi_image = tapModelDat.object(forKey: "tapasvi_image") as? String
                        tapaivviModel.place = tapModelDat.object(forKey: "place") as? String
                        tapaivviModel.contact = tapModelDat.object(forKey: "contact") as? String
                        tapaivviModel.total_likes = tapModelDat.object(forKey: "total_likes") as? String
                        tapaivviModel.total_comment = tapModelDat.object(forKey: "total_comment") as? String
                
                        if(tapModelDat.object(forKey: "likeUnlike") as? String == "1"){
                            tapaivviModel.likedUnliked = true
                        }else{
                            tapaivviModel.likedUnliked = false
                        }
                             self.tapassiviData.add(tapaivviModel)
                    }
                       
                        self.hideActivityIndicator()
                        self.tapTableView.reloadData()
              //  self.GetDataFromServer(tapModelDat: tapData!)

                }
                    
                }else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tapTableView.reloadData()
                        self.tapTableView.alpha = 0
                        self.lblNoRecord.alpha = 1
                    }
                }
               
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func GetDataFromServer(tapModelDat : [NSDictionary]){
        
        for i in 0..<tapModelDat.count{
            let jsonObject = tapModelDat[i]
            
           
            if((i+1) == tapModelDat.count){
                self.checkTapLikeUnlike(tapModelDat: tapModelDat[i],tapassya_id: (jsonObject.object(forKey: "tapassya_id") as? String)!,done: true)
            }else{
                self.checkTapLikeUnlike(tapModelDat: tapModelDat[i],tapassya_id: (jsonObject.object(forKey: "tapassya_id") as? String)!,done: false)
                
            }
        }
    }
    
    func checkTapLikeUnlike(tapModelDat : NSDictionary,tapassya_id:String,done:Bool){
        
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)&tapassya_id=\(tapassya_id)"
        let url = URL(string:ServerUrl.get_tapasvi_likes_detail_check)!
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
                
                  DispatchQueue.main.async {
                var tapaivviModel = tapassviModel()
                tapaivviModel.tapasvi_id = tapModelDat.object(forKey: "tapasvi_id") as? String
                tapaivviModel.tapassya_id = tapModelDat.object(forKey: "tapassya_id") as? String
                tapaivviModel.tapasvi_age = tapModelDat.object(forKey: "tapasvi_age") as? Int
                tapaivviModel.tapasvi_name = tapModelDat.object(forKey: "tapasvi_name") as? String
                tapaivviModel.main_group_name = tapModelDat.object(forKey: "main_group_name") as? String
                tapaivviModel.tapassya_name = tapModelDat.object(forKey: "tapassya_name") as? String
                tapaivviModel.tapasvi_image = tapModelDat.object(forKey: "tapasvi_image") as? String
                tapaivviModel.place = tapModelDat.object(forKey: "place") as? String
                tapaivviModel.contact = tapModelDat.object(forKey: "contact") as? String
                tapaivviModel.total_likes = tapModelDat.object(forKey: "total_likes") as? String
                tapaivviModel.total_comment = tapModelDat.object(forKey: "total_comment") as? String
                
                 let message = json?.object(forKey: "message") as? String!
                   // print("message---",message)
                if(message == "fail"){
                     tapaivviModel.likedUnliked = false
                }else{
                     tapaivviModel.likedUnliked = true
                }
                self.tapassiviData.add(tapaivviModel)
                    if(done == true){
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.tapTableView.reloadData()
                        }
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
