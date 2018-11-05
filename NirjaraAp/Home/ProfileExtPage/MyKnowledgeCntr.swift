//
//  MyKnowledgeCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/3/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class MyKnowledgeCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var knowledgeTableView: UITableView!
    //var knowledgeData : [String] = ["helloooo","daasDSA"]
    var knowledgeName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        knowledgeTableView.separatorStyle = .none
        
        getKnowledgeData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        GlobalVariables.addknowledge = textField.text!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knowledgeName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = knowledgeTableView.dequeueReusableCell(withIdentifier: "knowledgeIdentifier", for: indexPath) as? KnowledgeViewCell
      
        cell?.mainView.frame = CGRect(x:0,y:5,width:self.knowledgeTableView.frame.width,height:50)
        cell?.lblKnowledge.frame = CGRect(x:10,y:5,width:(cell?.mainView.frame.width)!-10,height:40)
        cell?.selectionStyle = .none
        cell?.lblKnowledge.text = knowledgeName[indexPath.row]
        cell?.btnAdded.frame = CGRect(x:(cell?.mainView.frame.width)!-95,y:10,width:85,height:30)
        cell?.btnAdded.setTitle("Added".localized1, for: .normal)
        cell?.mainView.addSubview((cell?.lblKnowledge)!)
        cell?.mainView.addSubview((cell?.btnAdded)!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerCell = knowledgeTableView.dequeueReusableCell(withIdentifier: "knowledgeHeaderIdentifier") as! KnowledgeHeaderViewCell
        
        footerCell.headerMainView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:60)
        footerCell.txtKnowledge.frame = CGRect(x:10,y:10,width:footerCell.headerMainView.frame.width-130,height:40)
        
        footerCell.txtKnowledge.addTarget(self, action: #selector(KnowledgeCntr.textFieldDidChange(_:)),
                                          for: UIControlEvents.editingChanged)
        footerCell.txtKnowledge.placeholder = "Add".localized1+" "+"Knowledge".localized1
        footerCell.btnAdd.frame = CGRect(x:footerCell.headerMainView.frame.width-100,y:10,width:85,height:40)
        footerCell.btnAdd.setTitle("Submit".localized1, for: .normal)
        footerCell.btnAdd.addTarget(self, action: #selector(KnowledgeCntr.AddKnowledge(_:)), for: UIControlEvents.touchUpInside)
        
        footerCell.headerMainView.addSubview((footerCell.txtKnowledge)!)
        footerCell.headerMainView.addSubview((footerCell.btnAdd)!)
        
        return footerCell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getKnowledgeData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_knowledge)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        print("pa---",parameters)
        
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
                print("knwoledge Data--",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "Success")
                {
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        let name = jsonObject?.object(forKey: "knowledge") as? String
                        if(name == nil || name == ""){
                            
                        }else{
                            self.knowledgeName.append(name!)
                        }
                    }
                    
                    DispatchQueue.main.async {
                       
                        
                        self.knowledgeTableView.reloadData()
                        
                    }
                }else if (Status == "Fail")
                {
                    
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
    @objc func AddKnowledge(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(GlobalVariables.addknowledge == ""){
            self.view.makeToast("Please Add Some Knowledge", duration: 3.0, position: .center)
        }else{
            print("knowledge to Add",GlobalVariables.addknowledge)
            
            let parameters = "knowledge=\(String(describing: GlobalVariables.addknowledge))&member_id=\(UserDefaults.standard.getUserID())"
            let url = URL(string:ServerUrl.post_knowledge_url)!
            print("Adding knowlege---\(url)?\(parameters)")
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
                    print("knowledge Add reponse",json)
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "Success")
                    {
                        
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.view.makeToast("Knowledge Added", duration: 3.0, position: .center)
                           
                            self.showAlert(title: "Success", message: "Knowledge Added")
    
                            self.knowledgeName.append(GlobalVariables.addknowledge)
                            GlobalVariables.addknowledge = ""
                        
                            self.knowledgeTableView.reloadData()
                        }
                    }
                    else if (Success == "Fail")
                    {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.showAlert(title: "Nirjara App", message: "knowledge already exist")
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            
                            //self.alert(message: "Invalid Credential", title:"Nirjara Ap")
                        }
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
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
