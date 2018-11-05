//
//  VrathPachkanCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import ImageSlideshow
class VrathPachkanCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
//    var pachkanTitle = ["Loren epsum","Loren epsum","Loren epsum","Loren epsum"]
//    var pachkanText = ["Loren epsum","Loren epsum","Loren epsum","Loren epsum"]

    var PachkanData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var vrathPachKanTable: UITableView!
    
    var addsData : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Vrath Pachkan"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:8))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:8,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        vrathPachKanTable.separatorStyle = .none
        self.addShadowToBarMap()
       // imageSlideShow.addBorder(toSide: .Top, withColor: UIColor.rgb(hexcolor: "#e9e9e9").cgColor, andThickness: 5)
       imageSlideShow.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
       // imageSlideShow.frame = CGRect(x:10,y:75,width:self.view.frame.width-20,height:205)
        //vrathPachKanTable.frame = CGRect(x:0,y:290,width:self.view.frame.width,height:self.view.frame.height)
       
        
        //addsData.removeAllObjects()
         if isConnectedToNetwork() {
        getAdvertiseMent()
         }else{
            
        }
        
        sideMenu()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         if isConnectedToNetwork() {
         self.getSunriSet()
         }else{
            
        }
    }
    @objc func didTap() {
        imageSlideShow.presentFullScreenController(from: self)
    }
    @objc func addTapped(){
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PachkanData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vrathPachKanTable.dequeueReusableCell(withIdentifier: "PachkanBodyIdentifier", for: indexPath) as! PachKanBodyTableViewCell

        
        let vrathData = PachkanData[indexPath.row] as? vrathPachkanModel
        let widthofCell : CGFloat = self.view.frame.width/4
        
        cell.selectionStyle = .none
        
        cell.lblTitleView.frame = CGRect(x:0,y:10,width:widthofCell+65,height:62)
        cell.btnPlay1View.frame = CGRect(x:widthofCell+65,y:10,width:widthofCell,height:62)
        cell.btnPlay2View.frame = CGRect(x:(widthofCell * 2)+50 ,y:10,width:widthofCell,height:62)
        cell.btnReadView.frame = CGRect(x:(widthofCell * 3)+35,y:10,width:widthofCell,height:62)
        
        
        cell.lblTitle.text = (vrathData?.Title)!+"\n"+(vrathData?.Time)!
        //let greet4Height = cell.lblTitle.optimalHeight
        cell.lblTitle.frame = CGRect(x:0,y:0,width:cell.lblTitleView.frame.width,height:62)
        cell.lblTitle.numberOfLines = 2
        cell.lblTitle.textAlignment = NSTextAlignment.center
        
    
        
        cell.btnPlay1.frame = CGRect(x:20,y:13,width:30,height:30)
        cell.btnPlay1.tag = indexPath.row
        cell.btnPlay1.accessibilityLabel = vrathData?.temple_audio
        cell.btnPlay1.addTarget(self, action: #selector(gotoTempleAudioPlay(_:)), for: UIControlEvents.touchUpInside)
        
      
        cell.btnRead.frame = CGRect(x:15,y:13,width:30,height:30)
        cell.btnRead.accessibilityLabel = vrathData?.pachkan_mantra
        cell.btnRead.addTarget(self, action: #selector(showPachkanMantras(_:)), for: UIControlEvents.touchUpInside)
       
        cell.btnPlay2.frame = CGRect(x:20,y:13,width:30,height:30)
        cell.btnPlay2.tag = indexPath.row
        cell.btnPlay2.accessibilityLabel = vrathData?.sthanak_audio
        cell.btnPlay2.addTarget(self, action: #selector(gotoSthanakAudioPlay(_:)), for: UIControlEvents.touchUpInside)
        
       // cell.lblTitleView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.btnPlay1View.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.btnPlay2View.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.btnReadView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        

        
        cell.lblTitleView.addSubview(cell.lblTitle)
        cell.btnPlay1View.addSubview(cell.btnPlay1)
        cell.btnPlay2View.addSubview(cell.btnPlay2)
        cell.btnReadView.addSubview(cell.btnRead)
        
        
      
        
        //cell.footerView.layer.borderColor = UIColor.lightGray.cgColor
        //cell.footerView.layer.borderWidth = 0.5
        cell.footerView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.footerView.frame = CGRect(x:0,y:65,width:self.view.frame.width,height:55)
    
        cell.lblFooterText.text = vrathData?.note
        let pachtitleFooterHeight = cell.lblFooterText.optimalHeight
        cell.lblFooterText.frame = CGRect(x:5,y:5,width:cell.footerView.frame.width-10,height:pachtitleFooterHeight)
        cell.lblFooterText.numberOfLines = 0
        cell.footerView.addSubview(cell.lblFooterText)
        
        return cell
    }
    
    @objc func showPachkanMantras(_ sender : UIButton){

        var data = PachkanData[sender.tag] as! vrathPachkanModel
        self.showAlert(title: "Vrath Pachkan", message: data.pachkan_mantra)
        
    }
    
    @objc func gotoTempleAudioPlay(_ sender : UIButton){
        
        var data = PachkanData[sender.tag] as! vrathPachkanModel
        
        let audioCntr = storyboard?.instantiateViewController(withIdentifier: "audioStoryIdentifer") as! AudioPlayViewCntr
        audioCntr.audioLink = sender.accessibilityLabel!
        audioCntr.packhanMessage = data.pachkan_mantra
        audioCntr.titleString = data.Title
        self.navigationController?.pushViewController(audioCntr, animated: true)
  
    }
    @objc func gotoSthanakAudioPlay(_ sender : UIButton){
        var data = PachkanData[sender.tag] as! vrathPachkanModel
        let audioCntr = storyboard?.instantiateViewController(withIdentifier: "audioStoryIdentifer") as! AudioPlayViewCntr
        audioCntr.audioLink = sender.accessibilityLabel!
        audioCntr.packhanMessage = data.pachkan_mantra
        audioCntr.titleString = data.Title
        self.navigationController?.pushViewController(audioCntr, animated: true)
  
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = vrathPachKanTable.dequeueReusableCell(withIdentifier: "PachkanHeaderIdentifier") as! PachKanHeaderTableViewCell
        
        headerCell.viewlblPachkan.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:30)
        headerCell.lblTodayPachText.frame = CGRect(x:10,y:0,width:headerCell.viewlblPachkan.frame.width-20,height:30)
        headerCell.lblTodayPachText.text = "Prathyakhans".localized1
        headerCell.viewlblPachkan.addSubview(headerCell.lblTodayPachText)
        
        
        headerCell.mainTitleView.frame = CGRect(x:0,y:30,width:self.view.frame.width,height:60)
        
        let widthofCell : CGFloat = headerCell.mainTitleView.frame.width/4
    
        headerCell.lblTitle.frame = CGRect(x:5,y:12,width:widthofCell+60,height:30)
        headerCell.lblTemple.frame = CGRect(x:widthofCell+60,y:12,width:widthofCell,height:30)
        headerCell.lblSthanak.frame = CGRect(x:(widthofCell * 2) + 45,y:12,width:widthofCell,height:30)
        headerCell.lblRead.frame = CGRect(x:(widthofCell * 3) + 35,y:12,width:widthofCell,height:30)
        
        headerCell.lblTitle.text = "Title".localized1
        headerCell.lblTemple.text = "TempleMantr".localized1
        headerCell.lblSthanak.text = "Sthanak".localized1
        headerCell.lblRead.text = "Read".localized1
        
        headerCell.lblTitle.textAlignment = NSTextAlignment.center
        headerCell.lblTemple.textAlignment = NSTextAlignment.center
        headerCell.lblSthanak.textAlignment = NSTextAlignment.center
        //headerCell.lblRead.textAlignment = NSTextAlignment.center
        
       
        

        headerCell.mainTitleView.addSubview(headerCell.lblTitle)
        headerCell.mainTitleView.addSubview(headerCell.lblTemple)
        headerCell.mainTitleView.addSubview(headerCell.lblSthanak)
        headerCell.mainTitleView.addSubview(headerCell.lblRead)
        return headerCell
    }
    
    
    func getAdvertiseMent(){
        let parameters = "adv_location=notification"
        let url = URL(string:ServerUrl.advertiseGlobalUrl)!
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<recommendData!.count{
                        let jsonObject = recommendData?[i]
                        var bottomhome = bottomBanner()
                        bottomhome.id = jsonObject?.object(forKey: "advertisement_id") as? String
                        bottomhome.imageSrc = jsonObject?.object(forKey: "adv_banner") as? String
                        bottomhome.name = jsonObject?.object(forKey: "adv_title") as? String
                        self.addsData.add(bottomhome)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        var images = [InputSource]()
                        for i in 0..<self.addsData.count{
                            var bannerData  = self.addsData[i] as! bottomBanner
                            var bannerImage : String = bannerData.imageSrc
                            let alamofireSource = AlamofireSource(urlString: bannerImage)!
                            images.append(alamofireSource)
                        }
                        
                        
                        self.imageSlideShow.setImageInputs(images)
                        self.imageSlideShow.backgroundColor = UIColor.white
                        self.imageSlideShow.slideshowInterval = 4.0
                        //self.imageSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
                       // self.imageSlideShow.pageControl.pageIndicatorTintColor = UIColor.white
                        self.imageSlideShow.pageControl.isHidden = true
                        self.imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
                       
                        
                    }
                  
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       // self.getVrathData()
                         self.getSunriSet()
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

    
    
    
    func getSunriSet(){
        
        let parameters = "latitude=\(GlobalVariables.currentLat)&longitude=\(GlobalVariables.currentLong)"
        let url = URL(string:ServerUrl.getTimeZone)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print("locaiton",parameters)
        
        
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
                
                //print("Googl response",json)
                let status = json?.object(forKey: "status") as? String;
                
                if(status == "OK"){
                    let timeZoneId = json?.object(forKey: "timeZoneId") as? String;
                    DispatchQueue.main.async {
                        self.PachkanData.removeAllObjects()
                        self.vrathPachKanTable.reloadData()
                        self.getVrathData(timeZone: timeZoneId!)
                        
                    }
                }else if(status == "INVALID_REQUEST"){
                    print("falsee")
                }
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
   
    
    
    func getVrathData(timeZone : String){
        //let parameters = "longitude=72.8295767&latitude=19.18449&timezone=Asia/Calcutta"
        let parameters = "longitude=\(GlobalVariables.currentLong)&latitude=\(GlobalVariables.currentLat)&timezone=\(timeZone)"
        let url = URL(string:ServerUrl.get_vrath_pachkan)!
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<recommendData!.count{
                        let jsonObject = recommendData?[i]
                        
                        
                        if(jsonObject?.object(forKey: "Title") as? String == "Sunrise" || jsonObject?.object(forKey: "Title") as? String == "Sunset" || jsonObject?.object(forKey: "Title") as? String == "Navkarmala"){
                            
                        }else{
                            var vrathPachkanData = vrathPachkanModel()
                            vrathPachkanData.vrat_pachkan_id = jsonObject?.object(forKey: "vrat_pachkan_id") as? String
                            vrathPachkanData.Title = jsonObject?.object(forKey: "Title") as? String
                            vrathPachkanData.time_interval = jsonObject?.object(forKey: "time_interval") as? String
                            vrathPachkanData.sthanak_audio = jsonObject?.object(forKey: "sthanak_audio") as? String
                            vrathPachkanData.temple_audio = jsonObject?.object(forKey: "temple_audio") as? String
                            
                            let string = jsonObject?.object(forKey: "pachkan_mantra") as? String
                            let str = string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                            vrathPachkanData.pachkan_mantra = str
                            vrathPachkanData.pachkan_information = jsonObject?.object(forKey: "pachkan_information") as? String
                            vrathPachkanData.Time = jsonObject?.object(forKey: "Time") as? String
                            vrathPachkanData.Time2 = jsonObject?.object(forKey: "Time2") as? String
                            vrathPachkanData.note = jsonObject?.object(forKey: "note") as? String
                            
                            self.PachkanData.add(vrathPachkanData)
                        }
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       self.vrathPachKanTable.reloadData()
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
