//
//  WithdrawMoneyCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class WithdrawMoneyCntr: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var txtPoints: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtBank: UITextField!
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var txtIfsc: UITextField!
    @IBOutlet weak var lblIfsc: UILabel!
    @IBOutlet weak var txtBAnkAcc: UITextField!
    @IBOutlet weak var lblBankAcc: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblAvailabelPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         sideMenu()
        
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  WithDraw Money"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:5))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        mainView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:self.view.frame.height-20)
       
        lblAvailabelPoints.frame = CGRect(x:mainView.frame.width-190,y:10,width:180,height:25)
        
        
        lblPoints.text = "Available".localized1+" "+"OnlyPoints".localized1
        lblPoints.frame = CGRect(x:10,y:45,width:mainView.frame.width-20,height:25)
        txtPoints.frame = CGRect(x:10,y:80,width:mainView.frame.width-20,height:50)
        
        lblPoints.text = "OnlyPoints".localized1
        txtPoints.placeholder = "OnlyPoints".localized1
        
        lblBankAcc.frame = CGRect(x:10,y:145,width:mainView.frame.width-20,height:25)
        txtBAnkAcc.frame = CGRect(x:10,y:175,width:mainView.frame.width-20,height:50)
        lblBankAcc.text = "AccountNumber".localized1
        txtBAnkAcc.placeholder = "AccountNumber".localized1
        
        lblIfsc.frame = CGRect(x:10,y:240,width:mainView.frame.width-20,height:25)
        txtIfsc.frame = CGRect(x:10,y:275,width:mainView.frame.width-20,height:50)
        
        lblIfsc.text = "IFSC".localized1
        txtIfsc.placeholder = "IFSC".localized1
        lblBank.frame = CGRect(x:10,y:340,width:mainView.frame.width-20,height:25)
        txtBank.frame = CGRect(x:10,y:375,width:mainView.frame.width-20,height:50)
        lblBank.text = "BankName".localized1
        txtBank.placeholder = "BankName".localized1
        
        btnSave.frame = CGRect(x:10,y:450,width:mainView.frame.width-20,height:50)
        btnSave.setTitle("Save".localized1, for: .normal)
        btnSave.addTarget(self, action: #selector(withDrawMoney), for: UIControlEvents.touchUpInside)
        
        mainView.addSubview(lblPoints)
        mainView.addSubview(txtPoints)
        mainView.addSubview(lblAvailabelPoints)
        mainView.addSubview(lblBankAcc)
        mainView.addSubview(txtBAnkAcc)
        mainView.addSubview(lblIfsc)
        mainView.addSubview(txtIfsc)
        mainView.addSubview(lblBank)
        mainView.addSubview(txtBank)
        mainView.addSubview(btnSave)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func withDrawMoney(){
        if isConnectedToNetwork() {
        if(txtPoints.text! == ""){
            self.view.makeToast("Please Enter Points", duration: 3.0, position: .top)
        }else if(txtBAnkAcc.text! == ""){
            self.view.makeToast("Please Enter Bank Account Number", duration: 3.0, position: .top)
        }else if(txtIfsc.text! == ""){
            self.view.makeToast("Please Enter IFSC Code", duration: 3.0, position: .top)
        }else if(txtBank.text! == ""){
            self.view.makeToast("Please Enter Bank Name", duration: 3.0, position: .top)
        }else{
            
            let parameters = "amount=\(txtPoints.text!)&account_number=\(txtBAnkAcc.text!)&ifsc_code=\(txtIfsc.text!)&bank_name=\(txtBank.text!)&member_id=\(UserDefaults.standard.getUserID())"
            let url = URL(string:ServerUrl.request_withdraw_my_points)!
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
                    let error_msg = json?.object(forKey: "error_msg") as? String;
                    
                    if (Status == "success")
                    {
                        
                        
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            
                            self.showAlert(title: "Nirjara Ap", message: "Payment Withdrawal Request Accepted")
                            
                            
                        }
  
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            
                            self.showAlert(title: "Nirjara Ap", message: error_msg!)
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
