//
//  KnowledgeCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class KnowledgeCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var knowledgeName = [String]()
    
    
    @IBOutlet weak var knowledgeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Knowledge"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
          knowledgeTable.separatorStyle = .none
        getKnowledgeData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return knowledgeName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = knowledgeTable.dequeueReusableCell(withIdentifier: "knowledgeBodyIdentifer", for:indexPath) as! KnowledgeTableViewCell
        cell.selectionStyle = .none
        cell.mainView.frame = CGRect(x:0,y:10,width:self.view.frame.width,height:60)
        cell.lblKnowledge.frame = CGRect(x:10,y:18,width:cell.mainView.frame.width-20,height:30)
        cell.lblAdded.frame = CGRect(x:cell.mainView.frame.width-85,y:18,width:65,height:30)
        cell.lblKnowledge.text = knowledgeName[indexPath.row]
        cell.mainView.addSubview((cell.lblKnowledge)!)
        cell.mainView.addSubview((cell.lblAdded)!)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = knowledgeTable.dequeueReusableCell(withIdentifier: "knowledgeFooterIdentifier") as! KnowledgeFooterTableViewCell
    
        footerCell.mainView.frame = CGRect(x:0,y:10,width:self.view.frame.width,height:80)
        footerCell.txtKnowledge.frame = CGRect(x:10,y:10,width:footerCell.mainView.frame.width-110,height:50)
        
        footerCell.txtKnowledge.addTarget(self, action: #selector(KnowledgeCntr.textFieldDidChange(_:)),
                            for: UIControlEvents.editingChanged)
        
        footerCell.btnAdded.frame = CGRect(x:footerCell.mainView.frame.width-85,y:18,width:65,height:30)
        
        footerCell.btnAdded.addTarget(self, action: #selector(KnowledgeCntr.AddKnowledge(_:)), for: UIControlEvents.touchUpInside)
        
        footerCell.mainView.addSubview((footerCell.txtKnowledge)!)
        footerCell.mainView.addSubview((footerCell.btnAdded)!)

        return footerCell
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        GlobalVariables.addknowledge = textField.text!
    }
    @objc func AddKnowledge(_ sender : UIButton){
       
        if(GlobalVariables.addknowledge == ""){
            self.view.makeToast("Please Add Some Knowledge", duration: 3.0, position: .center)
        }else{
        print("knowledge to Add",GlobalVariables.addknowledge)
        
        let parameters = "knowledge=\(String(describing: GlobalVariables.addknowledge))&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.post_knowledge_url)!
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
                        self.alert(message: "Nirjara Ap", title: "Knowledge Added")
                        GlobalVariables.addknowledge = ""
                        self.knowledgeName.append(GlobalVariables.addknowledge)
                        self.knowledgeTable.reloadData()
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
    }
    
    
    func getKnowledgeData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang="+GlobalVariables.selectedLanguage+"&member_id="+(UserDefaults.standard.getUserID())
        let url = URL(string:ServerUrl.get_knowledge)!
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
                        self.hideActivityIndicator()
                        
                        self.knowledgeTable.reloadData()
                        
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
