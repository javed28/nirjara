//
//  JainPopulationCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/13/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import AlamofireImage
import ImageSlideshow
class JainPopulationCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    
//    var knowledgeName = ["Java","Swift","Html","JQuery","Ajax","Others"]
//    var count = ["12","30","34","1","2","4"]
    var populationData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var jainPopulation: UITableView!
    
    @IBOutlet weak var addsSlideShow: ImageSlideshow!
    var globalbanServerData : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jain Population"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:7,length:10))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
        self.addShadowToBarMap()
        //addsSlideShow.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.lightgray), opacity: 1, offSet: CGSize(width: -1, height: 0.1), radius: 0.1, scale: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
        globalbanServerData.removeAllObjects()
        populationData.removeAllObjects()
        getGlobalAddAdvertiseMent()
        getPopulation()
    }else{
    showAlert(title: "OOp's", message: "No Internet Connection")
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return populationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jainPopulation.dequeueReusableCell(withIdentifier: "jainPopulationIdentifier", for:indexPath) as! JianPopulationTableViewCell
        cell.selectionStyle = .none
        
        let populationData = self.populationData[indexPath.row] as! JainPopulationModel
        
        cell.mainView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:50)
        cell.mainView.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.lblName.frame = CGRect(x:10,y:10,width:cell.mainView.frame.width-75,height:30)
        cell.lblCount.frame = CGRect(x:cell.mainView.frame.width-70,y:10,width:55,height:30)
        cell.lblName.text = populationData.sub_group_name
        cell.lblCount.text = populationData.num_of_follower
        
        cell.mainView.addSubview((cell.lblCount)!)
        cell.mainView.addSubview((cell.lblName)!)
        
        return cell
    }
    
        func getGlobalAddAdvertiseMent(){
           // let parameters = "adv_location=population_graph"
            
            var parameters = String()
            if(UserDefaults.standard.isKeyPresentInUserDefaults(key : "lastAddress")){
                parameters = "adv_location=population_graph&location=\(UserDefaults.standard.getLastAddress())"
            }else{
                parameters = "adv_location=population_graph&location="
            }
            let url = URL(string:ServerUrl.advertiseGlobalUrl)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // self.showActivityIndicator()
            
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
                            bottomhome.adv_banner = jsonObject?.object(forKey: "adv_banner") as? String
                            bottomhome.name = jsonObject?.object(forKey: "adv_title") as? String
                            bottomhome.external_link = jsonObject?.object(forKey: "external_link") as? String
                            self.globalbanServerData.add(bottomhome)
  
                        }
                        
                        DispatchQueue.main.async {
                            
                            var images = [InputSource]()
                            for i in 0..<self.globalbanServerData.count{
                                var bannerData  = self.globalbanServerData[i] as! bottomBanner
                                var bannerImage : String = bannerData.adv_banner
                                let alamofireSource = AlamofireSource(urlString: bannerImage)!
                                images.append(alamofireSource)
                            }
                            
                            
                            self.addsSlideShow.setImageInputs(images)
                            
                            //self.addsSlideShow.backgroundColor = UIColor.white
                            self.addsSlideShow.slideshowInterval = 3.5
                            //   self.addsSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
                            self.addsSlideShow.pageControl.isHidden = true
                            
                            self.addsSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
                            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTap))
                            self.addsSlideShow.addGestureRecognizer(gestureRecognizer)
                            
                        }
                    }else if (Status == "fail")
                    {
                        DispatchQueue.main.async {
                            self.topSpace.constant = 0
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                         
                        }
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    @objc func didTap() {
        
        // addsSlideShow.presentFullScreenController(from: self)
        
        var AddsData = globalbanServerData[addsSlideShow.currentPage] as! bottomBanner
        
        updateHit(addId: AddsData.id)
        
        UIApplication.shared.open(URL(string : AddsData.external_link)!, options: [:], completionHandler: { (status) in
            
        })
    }
    func updateHit(addId : String){
        let parameters = "advertise_id=\(addId)"
        let url = URL(string:ServerUrl.post_hit_count)!
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
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getPopulation(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_population_chart)!
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
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var populationModel = JainPopulationModel()
                        populationModel.sub_group_id = jsonObject?.object(forKey: "state_id") as? String
                        populationModel.num_of_follower = jsonObject?.object(forKey: "count") as? String
                        populationModel.sub_group_name = jsonObject?.object(forKey: "state") as? String
                        self.populationData.add(populationModel)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.jainPopulation.reloadData()
                        
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
