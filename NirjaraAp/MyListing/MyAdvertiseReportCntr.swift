//
//  MyAdvertiseReportCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyAdvertiseReportCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
//    var name = ["hello","hello1","dhjsadhaj88"]
//    var date = ["12 march 2017","15 july 2017","10 October 2018"]
    
    @IBOutlet weak var lblNoRecord: UILabel!
    
    var myAddData : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var advertiseTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNoRecord.alpha = 0
        advertiseTable.alpha = 1
        getAddsData()
        advertiseTable.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 489
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAddData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = advertiseTable.dequeueReusableCell(withIdentifier: "adverIdentifier", for: indexPath) as! AdvertiseTableViewCell
        cell.selectionStyle = .none
         let adsData = myAddData[indexPath.row] as? myaddlistingModel
        cell.lblAdvertiseName.text = adsData?.adv_title
        cell.lblDate.text = adsData?.date_added
        
        
        let url = URL(string:(adsData?.adv_banner)!)
        let placeholderImage = UIImage(named: "default-icon")!
        cell.imgWhoPost.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        
        let postUrl = URL(string:(adsData?.adv_banner)!)
        cell.imgWhatpost.af_setImage(withURL: postUrl!, placeholderImage: placeholderImage)
        
        
        cell.imgWhoPost.frame = CGRect(x:10,y:10,width:50,height:50)
        cell.imgWhoPost.layer.cornerRadius = cell.imgWhoPost.bounds.size.width / 2.0
        cell.imgWhoPost.clipsToBounds = true
        
        
        cell.lblAdvertiseName.frame = CGRect(x:65,y:5,width:view.frame.width-65,height:30)
        cell.lblDate.frame = CGRect(x:65,y:25,width:view.frame.width-65,height:30)
        
        cell.lineView.frame = CGRect(x:0,y:63,width:view.frame.width,height:1)
        cell.imgWhatpost.frame = CGRect(x:10,y:80,width:view.frame.width-20,height:365)
        
        cell.lblViews.frame = CGRect(x:10,y:445,width:100,height:50)
        cell.lblBalance.frame = CGRect(x:120,y:445,width:150,height:50)
        
    

        cell.lblViews.text = "Views".localized1+"("+(adsData?.hit_count)!+")"
        cell.lblBalance.text = "Balance".localized1+"("+(adsData?.amount)!+")"

        cell.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.lightgray).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.frame = CGRect(x:10,y:485,width:view.frame.width-20,height:2)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 0
        cell.layer.masksToBounds = false
        return cell
    }
    
    
    func getAddsData(){
        let parameters = "member_id="+UserDefaults.standard.getUserID()
       // let parameters = "member_id=200"
        let url = URL(string:ServerUrl.get_advertisement_by_member)!
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
                        var myAdsData = myaddlistingModel()

                        myAdsData.advertisement_id = jsonObject?.object(forKey: "advertisement_id") as? String
                        myAdsData.adv_title = jsonObject?.object(forKey: "adv_title") as? String
                        myAdsData.adv_type = jsonObject?.object(forKey: "adv_type") as? String
                        myAdsData.adv_location = jsonObject?.object(forKey: "adv_location") as? String
                        myAdsData.description = jsonObject?.object(forKey: "description") as? String
                        myAdsData.external_link = jsonObject?.object(forKey: "external_link") as? String
                        myAdsData.date_added = jsonObject?.object(forKey: "date_added") as? String
                        myAdsData.location = jsonObject?.object(forKey: "location") as? String
                        myAdsData.amount = jsonObject?.object(forKey: "amount") as? String
                        myAdsData.balance_remaining = jsonObject?.object(forKey: "balance_remaining") as? String
                        myAdsData.adv_banner = jsonObject?.object(forKey: "adv_banner") as? String
                        myAdsData.hit_count = jsonObject?.object(forKey: "hit_count") as? String
                        
                        
                        self.myAddData.add(myAdsData)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.advertiseTable.reloadData()
                        self.lblNoRecord.alpha = 0
                        self.advertiseTable.alpha = 1
                    }
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                    self.lblNoRecord.alpha = 1
                    self.advertiseTable.alpha = 0
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
