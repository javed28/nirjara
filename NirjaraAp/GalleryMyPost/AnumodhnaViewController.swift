//
//  AnumodhnaViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class AnumodhnaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var anumodhnaTable: UITableView!
    
    var member_name = [String]()
    var profile_photo = [String]()
    var gallery_id = String()
    var tapasvi_id = String()
    var tapassya_id = String()
    var fromWhere = String()
    @IBOutlet weak var lblNoRecord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Anumodhna"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        anumodhnaTable.separatorStyle = .none
        self.lblNoRecord.alpha = 0
        self.anumodhnaTable.alpha = 1
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
        member_name.removeAll()
        profile_photo.removeAll()
        getAnumodhnaData()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.fromWhere == "Tapassavi" ||  self.fromWhere == "profileTap"){
        return 40
        }else{
        return 110
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return member_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = anumodhnaTable.dequeueReusableCell(withIdentifier: "anumodhnaIdentifier", for: indexPath) as! AnumodhnaTableViewCell
        
        cell.selectionStyle = .none
    
        
        if(self.fromWhere == "Tapassavi" || self.fromWhere == "profileTap"){
            
            cell.member_name.frame = CGRect(x:20,y:5,width:view.frame.width-40,height:30)
            cell.member_name.text = member_name[indexPath.row]
            cell.member_photo.alpha = 0
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 2
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            //let borderColor: UIColor = (member_name[indexPath.row] == "inStock") ? .red : .green
            cell.layer.borderColor = UIColor.rgb(hexcolor: "#D8D8D8").cgColor
            return cell
        }else{
            cell.member_photo.frame = CGRect(x:10,y:10,width:80,height:80)
            cell.member_photo.layer.cornerRadius = cell.member_photo.bounds.size.width / 2.0
            cell.member_photo.clipsToBounds = true
            
            let url = URL(string:profile_photo[indexPath.row])
            let placeholderImage = UIImage(named: "default-icon")!
            cell.member_photo.af_setImage(withURL: url!, placeholderImage: placeholderImage)
            
            cell.member_name.frame = CGRect(x:120,y:40,width:view.frame.width-120,height:30)
            cell.member_name.text = member_name[indexPath.row]
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 2
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            //let borderColor: UIColor = (member_name[indexPath.row] == "inStock") ? .red : .gra
            cell.layer.borderColor = UIColor.rgb(hexcolor: "#D8D8D8").cgColor
            return cell
        }
        
        
    }
    
    func getAnumodhnaData(){
        
        var parameters  = String()
        var url  : URL!
        if(fromWhere == "Tapassavi"){
            parameters = "tapasvi_id=\(tapasvi_id)&tapassya_id=\(tapassya_id)&lang=\(GlobalVariables.selectedLanguage)"
            url = URL(string:ServerUrl.get_tapasvi_likes_details)!
        }
        if(fromWhere == "profileTap"){
            parameters = "tid=\(tapasvi_id)&member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
            url = URL(string:ServerUrl.get_like_details_profile)!
        }else{
            parameters = "gallery_id=\(gallery_id)"
            url = URL(string:ServerUrl.get_anumodnas)!
        }
       
        
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
                    
                     if(self.fromWhere == "Tapassavi" || self.fromWhere == "profileTap"){
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
                        let member_name = jsonObject?.object(forKey: "member_name") as? String
                        self.member_name.append(member_name!)
                    }
                    
                     }else{
                        let jobData = json?.object(forKey: "data") as? [NSDictionary]
                        for i in 0..<jobData!.count{
                            let jsonObject = jobData?[i]
                            
                            let member_name = jsonObject?.object(forKey: "member_name") as? String
                            let profile_photo = jsonObject?.object(forKey: "profile_photo") as? String
                            if(member_name == nil){
                                self.member_name.append("No Name")
                            }else{
                                self.member_name.append(member_name!)
                                
                            }
                            self.profile_photo.append(profile_photo!)
                            
                            
                        }
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.anumodhnaTable.reloadData()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 1
                        self.anumodhnaTable.alpha = 0
                        
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
