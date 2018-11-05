//
//  SecurityViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import MessageUI

class SecurityViewController: UIViewController,MFMessageComposeViewControllerDelegate {
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //var contact_no : [String] = []
    var contact_no = [String]()
    
   // var firstNumber = String()
    
    @IBOutlet weak var btnSecurity: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setTopMenu()
       self.addShadowToBar()
        
       
        
       btnSecurity.setTitle("SendSurityMessage".localized1, for: .normal)
       
         sideMenu()
       
        // Do any additional setup after loading the view.
    }
    
    
    func setTopMenu(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        if(UserDefaults.standard.getLanguage() == "en"){
            var myString:NSString = "  Send Security Message"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:16))
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:16,length:7))
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }else if(UserDefaults.standard.getLanguage() == "hi"){
            var myString:NSString = "  आपका सन्देश भेजें"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:2))
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            var myString:NSString = "  સુરક્ષા ચેતવણી તમારો સંદેશો"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:16))
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:16,length:3))
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points".localized1, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
        
    }
    
    @IBAction func btnSendSecuirty(_ sender: Any) {
        self.sendMsg()
    }
    
    func sendMsg(){
        if (MFMessageComposeViewController.canSendText()) {
           
            if(contact_no == nil){
                showAlert(title: "Send Sms", message: "No Security Alert Number")
                
            }else{
                
                let controller = MFMessageComposeViewController()
                controller.messageComposeDelegate = self
                var contactNumber = String()
               
                for index in 0..<contact_no.count {
                    if(index == 0){
                        contactNumber = contact_no[index]
                    }else{
                        contactNumber = contactNumber+","+contact_no[index]
                    }
                  }
                let recipientsArray = contactNumber.components(separatedBy: ",")
                controller.recipients = recipientsArray
                controller.body = "Need a help Urgently Kindly contact"
                self.present(controller, animated: true, completion: nil)
               
            }
            
        }else{
            print("unable to send")
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contact_no.removeAll()
       getSecurityNumber()
       //sendMsg()
        
    }
    func sideMenu(){
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 180
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSecurityNumber(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_guru_contacts)!
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
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
//                        if(i == 0){
//                            self.firstNumber = (jsonObject?.object(forKey: "contact_no") as? String)!
//                        }
                        
                        let contactNumber = jsonObject?.object(forKey: "contact_no") as? String
                        self.contact_no.append(contactNumber!)
                    }
                    DispatchQueue.main.async {
                        
                        
                       // self.sendMsg()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
