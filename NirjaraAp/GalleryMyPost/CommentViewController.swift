//
//  CommentViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class CommentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var commentTable: UITableView!
    
    @IBOutlet weak var txtComment: UITextField!
    var member_name = [String]()
    var comment = [String]()
    var gallery_id = String()
    var tapasvi_id = String()
    var tapassya_id = String()
    

    @IBOutlet weak var lblNoRecordFound: UILabel!
    var fromWhere = String()
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNoRecordFound.alpha = 0
        self.commentTable.alpha = 1
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Comments"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
       
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        commentTable.separatorStyle = .none
        btnSubmit.setTitle("Submit".localized1, for: .normal)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if(fromWhere == "Tapassavi"){
            bottomSpace.constant = 120
            bottomView.alpha = 1
        }else if(fromWhere == "profileTap"){
             bottomSpace.constant = 50
            bottomView.alpha = 0
        }else{
            bottomSpace.constant = 120
            bottomView.alpha = 1
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
            self.member_name.removeAll()
            self.comment.removeAll()
             getComments()
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
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return member_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTable.dequeueReusableCell(withIdentifier: "commentsIdentifier", for: indexPath) as! CommentTableViewCell
        
        cell.selectionStyle = .none
        
        
        cell.member_name.frame = CGRect(x:20,y:10,width:self.view.frame.width-40,height:30)
        cell.comment.frame = CGRect(x:20,y:40,width:self.view.frame.width-40,height:30)
        cell.member_name.text = member_name[indexPath.row]
        
        let data1 = comment[indexPath.row].data(using: String.Encoding.utf8)
        let messageString = String(data : data1!,encoding : String.Encoding.nonLossyASCII)
        
        cell.comment.text = messageString
        cell.separatorLine.frame = CGRect(x:0,y:79,width:self.view.frame.width,height:1)
        
        return cell
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        if(txtComment.text == ""){
            self.view.makeToast("Please Enter Comment First", duration: 3.0, position: .top)
        }else{
            if isConnectedToNetwork() {
            postComment(strComments: txtComment.text!)
            }else{
                showAlert(title: "OOp's", message: "No Internet Connection")
            }
        }
        
    }
    
    
    func getComments(){
        var parameters  = String()
        var url  : URL!
        if(fromWhere == "Tapassavi"){
            parameters = "tapasvi_id=\(tapasvi_id)&tapassya_id=\(tapassya_id)&lang=\(GlobalVariables.selectedLanguage)"
             url = URL(string:ServerUrl.get_tapasvi_comments)!
        }else if(fromWhere == "profileTap"){
            parameters = "tid=\(tapasvi_id)&member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
            url = URL(string:ServerUrl.get_comment_details_profile)!
        }else{
             parameters = "gallery_id=\(gallery_id)"
            url = URL(string:ServerUrl.get_comments)!
        }
        
        print("param---",parameters)
        print("param---",url)
        
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
                
                print("comment Tapp Response--",json)
                if(self.fromWhere == "Tapassavi" ){
                    let message = json?.object(forKey: "message") as? String;
                    if(message == "Success"){
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]

                        
                        let member_name = jsonObject?.object(forKey: "member_name") as? String
                        let tapasvi_comments = jsonObject?.object(forKey: "tapasvi_comments") as? String
                        if(member_name == nil){
                            self.member_name.append("")
                        }else{
                            self.member_name.append(member_name!)
                        }
                        
                        
                        self.comment.append(tapasvi_comments!)
                        
                    }
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.commentTable.reloadData()
                            self.lblNoRecordFound.alpha = 0
                            self.commentTable.alpha = 1
                        }
                }else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.commentTable.reloadData()
                            self.lblNoRecordFound.alpha = 1
                            self.commentTable.alpha = 0
                        }
                    }
                    
                    
                }
                else if(self.fromWhere == "profileTap"){
                    let message = json?.object(forKey: "message") as? String;
                    if (message == "success")
                    {
                        let jobData = json?.object(forKey: "result") as? [NSDictionary]
                        for i in 0..<jobData!.count{
                            let jsonObject = jobData?[i]
                            
                            let member_name = jsonObject?.object(forKey: "member_name") as? String
                            let gallery_comments = jsonObject?.object(forKey: "comments") as? String
                            
                            self.member_name.append(member_name!)
                            self.comment.append(gallery_comments!)
                            
                        }
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.commentTable.reloadData()
                            self.lblNoRecordFound.alpha = 0
                            self.commentTable.alpha = 1
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.commentTable.reloadData()
                            self.lblNoRecordFound.alpha = 1
                            self.commentTable.alpha = 0
                        }
                    }
                    
                }
                
            
                else{
                 let message = json?.object(forKey: "message") as? String;
                if (message == "success")
                {
                     let jobData = json?.object(forKey: "data") as? [NSDictionary]
                        for i in 0..<jobData!.count{
                            let jsonObject = jobData?[i]
                            
                            let member_name = jsonObject?.object(forKey: "member_name") as? String
                            let gallery_comments = jsonObject?.object(forKey: "gallery_comments") as? String
                            
                            self.member_name.append(member_name!)
                            self.comment.append(gallery_comments!)
                            
                        }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.commentTable.reloadData()
                        self.lblNoRecordFound.alpha = 0
                        self.commentTable.alpha = 1
                    }
                }else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.commentTable.reloadData()
                        self.lblNoRecordFound.alpha = 1
                        self.commentTable.alpha = 0
                    }
                    }
                    
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

    
    
    
    func postComment(strComments :String){
        if isConnectedToNetwork() {
        
        let data = strComments.data(using: String.Encoding.nonLossyASCII)
        let message = String(data : data!,encoding : String.Encoding.utf8)
        let encodedString = message?.replacingOccurrences(of: "\\", with: "\\\\")
        
        var parameters  = String()
        var url  : URL!
        if(fromWhere == "Tapassavi"){
            parameters = "tapasvi_id=\(tapasvi_id)&tapassya_id=\(tapassya_id)&lang=\(GlobalVariables.selectedLanguage)&comments=\(encodedString!)&member_id=\(UserDefaults.standard.getUserID())"
            url = URL(string:ServerUrl.post_tapasvi_comments)!
        }else{
            parameters = "gallery_id=\(gallery_id)&member_id=\(UserDefaults.standard.getUserID())&comments=\(encodedString!)"
            url = URL(string:ServerUrl.post_comments)!
        }
        print("sending comment---\(parameters)")
        print("url comment---\(parameters)")
        
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
                    self.member_name.removeAll()
                    self.comment.removeAll()
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var member_name = String()
                        var gallery_comments = String()
                        if(self.fromWhere == "Tapassavi"){
                            member_name = (jsonObject?.object(forKey: "member_name") as? String)!
                            gallery_comments = (jsonObject?.object(forKey: "tapasvi_comments") as? String)!
                        }else{
                            member_name = (jsonObject?.object(forKey: "member_name") as? String)!
                            gallery_comments = (jsonObject?.object(forKey: "gallery_comments") as? String)!
                        }
                        self.member_name.append(member_name)
                        self.comment.append(gallery_comments)
                        
                    }
            
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecordFound.alpha = 0
                        self.commentTable.alpha = 1
                       self.commentTable.reloadData()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecordFound.alpha = 0
                        self.commentTable.alpha = 1
                        
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
