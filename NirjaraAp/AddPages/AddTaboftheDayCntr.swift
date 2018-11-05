//
//  AddTaboftheDayCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController

class AddTaboftheDayCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //var CategoryArray = ["Buyansu","Ekansu","Nivi","Ayambil","Upvas1","Upvas2","Upvas3","Upvas4","Upvas5","Upvas6","Upvas7","Upvas8","Upvas9","Upvas10","Upvas11","Upvas12","Upvas13","Upvas14","Upvas15","Upvas16","Upvas17","Upvas18","Upvas19","Upvas20"]
    
    
    var tabData = [String]()
    var tapassya_id = [String]()
    
    
    var AlreadyAddedtapassya_id = [String]()
    
    @IBOutlet weak var tapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Add Tap of the Day"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:17))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:17,length:3))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
        
        getParticularUserTapassviData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

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
        return 60
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tabData.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tapTableView.dequeueReusableCell(withIdentifier: "tapIdentifier") as! TapTableViewCell!
        cell?.backgroundColor = UIColor.rgb(hexcolor: "#f5f5f5")
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let isIndexValid = AlreadyAddedtapassya_id.indices.contains(0)
        if(isIndexValid){
            print("after ading---"+AlreadyAddedtapassya_id[0])
            if(AlreadyAddedtapassya_id[0] == tapassya_id[indexPath.row]){
                cell?.btnTapAdd?.frame = CGRect(x:self.view.frame.width-130,y:15,width:125,height:35)
                cell?.btnTapAdd.tag = indexPath.row
                cell?.btnTapAdd.accessibilityLabel = tapassya_id[indexPath.row]+"::"+tabData[indexPath.row]+"::"+"1"
                
                cell?.btnTapAdd.setTitle("AddToRecord".localized1, for: .normal)
                cell?.btnTapAdd.backgroundColor = UIColor.rgb(hexcolor: "#006400")
            }else{
            cell?.btnTapAdd?.frame = CGRect(x:self.view.frame.width-110,y:15,width:90,height:35)
            cell?.btnTapAdd.tag = indexPath.row
           
            cell?.btnTapAdd.setTitle("Add".localized1, for: .normal)
            cell?.btnTapAdd.backgroundColor = UIColor.rgb(hexcolor: GlobalVariables.orangeColor)
            cell?.btnTapAdd.accessibilityLabel = tapassya_id[indexPath.row]+"::"+tabData[indexPath.row]+"::"+"0"
            }
            cell?.lblTapName?.text = tabData[indexPath.row]
            cell?.lblTapName?.textColor = UIColor.rgb(hexcolor: "#666")
            cell?.lblTapName?.frame = CGRect(x:20,y:8,width:self.view.frame.width-100,height:40)
            cell?.btnTapAdd.addTarget(self, action: #selector(showTapAlert(_:)), for: UIControlEvents.touchUpInside)
            return cell!
                
        }else{
        
        cell?.lblTapName?.text = tabData[indexPath.row]
        cell?.lblTapName?.textColor = UIColor.rgb(hexcolor: "#666")
        cell?.lblTapName?.frame = CGRect(x:20,y:8,width:self.view.frame.width-100,height:40)
        cell?.btnTapAdd?.frame = CGRect(x:self.view.frame.width-110,y:15,width:90,height:35)
        cell?.btnTapAdd.tag = indexPath.row
        cell?.btnTapAdd.setTitle("Add".localized1, for: .normal)
        cell?.btnTapAdd.backgroundColor = UIColor.rgb(hexcolor: GlobalVariables.orangeColor)
        cell?.btnTapAdd.accessibilityLabel = tapassya_id[indexPath.row]+"::"+tabData[indexPath.row]+"::"+"0"
        
        cell?.btnTapAdd.addTarget(self, action: #selector(showTapAlert(_:)), for: UIControlEvents.touchUpInside)
        return cell!
        }
    }
    
    
    @objc func showTapAlert(_ selection : UIButton){
        
        let ids: String = selection.accessibilityLabel!
        let seperateIds = ids.components(separatedBy: "::")
        
        if(seperateIds[2] == "0"){

    
        let alertController = JHTAlertController(title: "Add Tap", message:"Are you sure you want to add this "+seperateIds[1]+" tap ?", preferredStyle: .alert)
        
        alertController.titleTextColor = .black
        alertController.titleFont = .systemFont(ofSize: 18)
        alertController.titleViewBackgroundColor = .white
        alertController.messageTextColor = .black
        alertController.alertBackgroundColor = .white
        
       // alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
        
        
        let cancelAction = JHTAlertAction(title: "cancel", style: .cancel,  handler: nil)
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonBackgroundColorFor(.cancel, to: .white)
        
        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
            self.postTapOftheDay(id: seperateIds[0],indexOfRow: selection.tag)
        }
        alertController.setButtonTextColorFor(.default, to: .white)
        alertController.setButtonBackgroundColorFor(.default, to: UIColor.rgb(hexcolor: "#387ef5"))
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        }else{
            let alertController = JHTAlertController(title: "Add Tap to Record", message:"Are you sure you want to add this "+seperateIds[1]+" tap To your Record?", preferredStyle: .alert)
            
            alertController.titleTextColor = .black
            alertController.titleFont = .systemFont(ofSize: 18)
            alertController.titleViewBackgroundColor = .white
            alertController.messageTextColor = .black
            alertController.alertBackgroundColor = .white
            
            // alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
            
            
            let cancelAction = JHTAlertAction(title: "cancel", style: .cancel,  handler: nil)
            alertController.setButtonTextColorFor(.cancel, to: .black)
            alertController.setButtonBackgroundColorFor(.cancel, to: .white)
            
            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                self.postTapToRecord(id: seperateIds[0],indexOfRow: selection.tag)
            }
            alertController.setButtonTextColorFor(.default, to: .white)
            alertController.setButtonBackgroundColorFor(.default, to: UIColor.rgb(hexcolor: "#387ef5"))
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    @objc func postTapToRecord(id : String,indexOfRow : Int){
        if isConnectedToNetwork() {
        let parameters = "tapassya_id=\(id)&member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)&key=add_tap&tap_status=done"
        print("post parrrr--",parameters)
        let url = URL(string:ServerUrl.post_add_tapasya)!
        print("post tappsaya--",url)
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
                
                print("post Tapp Data-==--",json)
                let message = json?.object(forKey: "message") as? String;
                if (message == "success")
                {
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.showAlert(title: "Well done", message: "Tapassaya Added to your Record")
                        self.AlreadyAddedtapassya_id.removeAll()
                        self.tapassya_id.removeAll()
                        self.tabData.removeAll()
                        self.tapTableView.reloadData()
                        self.getTapassviData()
//                        let indexPath = IndexPath(item: indexOfRow, section: 0)
//                        self.tapTableView.reloadRows(at: [indexPath], with: .top)
                    }
                  
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.showAlert(title: "Oop's", message: "Tapassya already added for the day")
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
    
    
    @objc func postTapOftheDay(id : String,indexOfRow : Int){
        if isConnectedToNetwork() {
        //tap_status=add_to_record"
        let parameters = "tapassya_id=\(id)&member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)&key=add_tap"
        print("post parrrr--",parameters)
        let url = URL(string:ServerUrl.post_add_tapasya)!
        print("post tappsaya--",url)
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
                
                print("Post Tab data Reponseee-",json)
                let message = json?.object(forKey: "message") as? String;
                if (message == "success")
                {
                    DispatchQueue.main.async {
                         self.hideActivityIndicator()
                        
                        self.showAlert(title: "Well done", message: "Tapassaya Added for the Day")
                        
                        self.tapassya_id.removeAll()
                        self.tabData.removeAll()
                        self.tapTableView.reloadData()
                        self.getParticularUserTapassviData()
                        
//                        let indexPath = IndexPath(item: indexOfRow, section: 0)
//                        self.tapTableView.reloadRows(at: [indexPath], with: .top)
                    }
                    //                    let data = json?.object(forKey: "data") as? [NSDictionary]
                    //                    let jsonObject1 = data![0]
                    //
                    //
                    //                    DispatchQueue.main.async {
                    //                        self.hideActivityIndicator()
                    //                        let total_anumodan = jsonObject1.object(forKey: "total_anumodan") as? String
                    //
                    //                        var updateTapData =  self.tapassiviData[selection.tag] as! tapassviModel
                    //
                    //                        var tapData = tapassviModel()
                    //                        tapData.tapasvi_id =  updateTapData.tapasvi_id
                    //                        tapData.tapassya_id = updateTapData.tapassya_id
                    //                        tapData.tapasvi_age = updateTapData.tapasvi_age
                    //                        tapData.tapasvi_name  = updateTapData.tapasvi_name
                    //                        tapData.main_group_name = updateTapData.main_group_name
                    //                        tapData.tapassya_name = updateTapData.tapassya_name
                    //                        tapData.tapasvi_image = updateTapData.tapasvi_image
                    //                        tapData.contact = updateTapData.contact
                    //                        tapData.total_likes = total_anumodan
                    //                        tapData.total_comment = updateTapData.total_comment
                    //
                    //
                    //                        self.tapassiviData.removeObject(at: selection.tag)
                    //                        self.tapassiviData.insert(updateTapData, at: Int(selection.tag))
                    //
                    //
                    //                        let indexPath = IndexPath(item: selection.tag, section: 0)
                    //                        self.tapTableView.reloadRows(at: [indexPath], with: .top)
                    //
                    
                    //   }
                }else if(message == "fail"){
                     DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.showAlert(title: "Oop's", message: "Tapassya already added for the day")
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
    
    
    func getParticularUserTapassviData(){
       
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)&key=get_tap"
        print("post parrrr--",parameters)
        let url = URL(string:ServerUrl.post_add_tapasya)!
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
                print("Tappsavi Data---Which----",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
                        self.AlreadyAddedtapassya_id.append((jsonObject?.object(forKey: "tapassya_id") as? String)!)
                       
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.getTapassviData()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.getTapassviData()
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func getTapassviData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang="+GlobalVariables.selectedLanguage
        let url = URL(string:ServerUrl.get_tapassya_all)!
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
                print("Tappsavi Data",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        let name = (jsonObject?.object(forKey: "tapassya_name") as? String)?.capitalized
                        self.tapassya_id.append((jsonObject?.object(forKey: "tapassya_id") as? String)!)
                        self.tabData.append(name!)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tapTableView.reloadData()
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
