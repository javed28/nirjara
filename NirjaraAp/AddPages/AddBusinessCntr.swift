//
//  AddBusinessCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class AddBusinessCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
//    var businessName = ["Regular","Silver","Gold"]
//    var businessPaper = ["Black & White Ad","Colored Ad","Top 5 Ad with Images"]
//    var businessPrice = ["3700/-","7300/-","25000/-"]
    var businessData : NSMutableArray = NSMutableArray()
    @IBOutlet weak var businessTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Business Package"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        businessTableView.separatorStyle = .none
        self.updateBackButton()
        businessTableView?.backgroundColor = UIColor.rgb(hexcolor: "#f5f5f5")
        getBusiness()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return businessData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = businessTableView.dequeueReusableCell(withIdentifier: "businessIdentifier") as! BusinessTableViewCell!
        
         let businessDataa = self.businessData[indexPath.row] as! businessModel
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.rgb(hexcolor: "#f5f5f5")
        cell?.mainView.frame = CGRect(x:20,y:20,width:self.view.frame.width-40,height:130)
        cell?.mainView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell?.lblMainTitle?.text = businessDataa.package_title
        cell?.lblMainTitle?.frame = CGRect(x:15,y:8,width:(cell?.mainView.frame.width)!,height:25)
        
       
        if(businessDataa.package_title == "Regular"){
            cell?.lblAgainTitle?.text = "Black & White Ad"
                cell?.lblAgainTitle?.frame = CGRect(x:15,y:35,width:(cell?.mainView.frame.width)!,height:20)
        }else if(businessDataa.package_title == "Silver"){
            cell?.lblAgainTitle?.text = "Colored Ad"
                cell?.lblAgainTitle?.frame = CGRect(x:15,y:35,width:(cell?.mainView.frame.width)!,height:20)
        }else if(businessDataa.package_title == "Gold"){
            cell?.lblAgainTitle?.text = "Top 5 Ad with Images"
                cell?.lblAgainTitle?.frame = CGRect(x:15,y:35,width:(cell?.mainView.frame.width)!,height:20)
        }
        else {
            cell?.lblAgainTitle?.text = businessDataa.package_title
            cell?.lblAgainTitle?.frame = CGRect(x:15,y:35,width:(cell?.mainView.frame.width)!,height:20)
        }
        cell?.lblSubTitle?.text = businessDataa.package_description
        cell?.lblSubTitle?.frame = CGRect(x:15,y:60,width:(cell?.mainView.frame.width)!,height:20)
        
        cell?.lblPrice?.text = "\u{20B9} "+businessDataa.cost+" /-"
        cell?.lblPrice?.frame = CGRect(x:15,y:91,width:(cell?.mainView.frame.width)!,height:20)
        
        
        cell?.mainView.addSubview((cell?.lblMainTitle)!)
        cell?.mainView.addSubview((cell?.lblSubTitle)!)
        cell?.mainView.addSubview((cell?.lblAgainTitle)!)
        cell?.mainView.addSubview((cell?.lblPrice)!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let businessDataa = self.businessData[indexPath.row] as! businessModel
        let gotoPostBusines = storyboard?.instantiateViewController(withIdentifier: "enterBusinessStory") as? PostBusinessCntr
        gotoPostBusines?.whichPackage = businessDataa.package_title
        gotoPostBusines?.packageId = businessDataa.package_id
       
        navigationController?.pushViewController(gotoPostBusines!, animated: true)
        
    }
    
    
    
    func getBusiness(){
        if isConnectedToNetwork() {
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=en"
        let url = URL(string:ServerUrl.get_business_package_url)!
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
                        var businessMModel = businessModel()
                        
                        
                        businessMModel.package_id = jsonObject?.object(forKey: "package_id") as? String
                        businessMModel.package_title = jsonObject?.object(forKey: "package_title") as? String
                        businessMModel.package_description = jsonObject?.object(forKey: "package_description") as? String
                        businessMModel.cost = jsonObject?.object(forKey: "cost") as? String
                        self.businessData.add(businessMModel)
 
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.businessTableView.reloadData()
                        
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
    }else{
    showAlert(title: "OOp's", message: "No Internet Connection")
    }

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
