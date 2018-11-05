//
//  MyTapRecordCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/3/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController

class MyTapRecordCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tapTableView: UITableView!
    var tapData = [String]()
    var tapassya_id = [String]()
    var tapassya_count = [String]()
    var AlreadyAddedtapassya_id = [String]()
    var AlreadyAddedtapassya_id_Count = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tapTableView.separatorStyle = .none
        
        getTapassviData()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tapData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tapTableView.dequeueReusableCell(withIdentifier: "tapIdentifier", for: indexPath) as? TapViewCell
        cell?.selectionStyle = .none
        
        cell?.mainView.frame = CGRect(x:10,y:5,width:tapTableView.frame.width-20,height:50)
        
        cell?.lblTapName.frame = CGRect(x:10,y:5,width:(cell?.mainView.frame.width)!-10,height:40)
        cell?.btnCount.frame = CGRect(x:(cell?.mainView.frame.width)!-60,y:5,width:40,height:40)
        
//        if(AlreadyAddedtapassya_id.count == 0){
//
//        }else{
        
//        let isIndexValid = AlreadyAddedtapassya_id.indices.contains(0)
//        if(isIndexValid){
        
            if(tapassya_count[indexPath.row] == "0"){
                
                 cell?.btnCount.setTitle("", for: .normal)
            }else{
                cell?.btnCount.setTitle(tapassya_count[indexPath.row], for: .normal)
                
            }
        cell?.btnCount.tag = indexPath.row
        cell?.btnCount.addTarget(self, action: #selector(showGetUserName(_:)), for: .touchUpInside)
        cell?.lblTapName.text = tapData[indexPath.row]
//        }else{
//            cell?.btnCount.isHidden = true
//            cell?.lblTapName.text = tapData[indexPath.row]
//            cell?.btnCount.setTitle(tapData[indexPath.row], for: .normal)
//
//        }
     //   }
    
        cell?.mainView.addSubview((cell?.lblTapName)!)
        cell?.mainView.addSubview((cell?.btnCount)!)
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getTapassviCounData(){
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_tapassya_for_profile)!
        //print("tappasya record---",parameters)
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
                       
                        let tapassya_count = jsonObject?.object(forKey: "tapassya_count") as? Int
                        self.AlreadyAddedtapassya_id_Count.append((tapassya_count?.description)!)
                        self.AlreadyAddedtapassya_id.append((jsonObject?.object(forKey: "tapassya_id") as? String)!)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
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
    
    
    func getTapassviData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_tapassya_all_new)!
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
                //print("Tappsavi Data",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        self.tapassya_id.append((jsonObject?.object(forKey: "tapassya_id") as? String)!)
                        self.tapassya_count.append((jsonObject?.object(forKey: "count") as? String)!)
                        let name = (jsonObject?.object(forKey: "tapassya_name") as? String)?.capitalized
                        self.tapData.append(name!)
                    }
                    DispatchQueue.main.async {
                       
                        self.tapTableView.reloadData()
                        //self.getTapassviCounData()
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
    @objc func showGetUserName(_ sender : UIButton) {
        
        let tabName = tapData[sender.tag]
        let tabCountValue = tapassya_count[sender.tag]
        
        let alertController = UIAlertController(title: tabName, message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            
            if fNameField.text == "" {
                //self.view.makeToast("Please Enter Tap Count", duration: 2.0, position: .top)
                                let errorAlert = UIAlertController(title: "Error", message: "Please Enter Tap Count", preferredStyle: .alert)
                                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                                    alert -> Void in
                                    self.present(alertController, animated: true, completion: nil)
                                }))
                                self.present(errorAlert, animated: true, completion: nil)
               // self.newUser = User(fn: fNameField.text!, ln: lNameField.text!)
                //TODO: Save user data in persistent storage - a tutorial for another time
            } else {
                
                self.updateContactDetail(tapCount: fNameField.text!,tapId: self.tapassya_id[sender.tag])

                
                
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
           
        }))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = tabCountValue
            textField.textAlignment = .left
        })
    
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func updateContactDetail(tapCount : String, tapId : String){
        if isConnectedToNetwork() {
            let parameters = "tapassya_count=\(tapCount)&member_id=\(UserDefaults.standard.getUserID())&tapassya_id=\(tapId)"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.post_tapassya_count)!
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
                    
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "success")
                    {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:"Tap Count Updated", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                //                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                //                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[1])
                                //                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                self.tapData.removeAll()
                                self.tapassya_id.removeAll()
                                self.tapassya_count.removeAll()
                                self.getTapassviData()
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.showAlert(title: "Nirjara Ap", message: "Something Went Wrong")
                            //self.alert(message: "Invalid Credential", title:"Nirjara Ap")
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
