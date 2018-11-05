//
//  ForgotViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import IQKeyboardManagerSwift
class ForgotViewCntr: UIViewController {

    
    @IBOutlet weak var topLogo: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var btnAlready: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        topLogo.frame = CGRect(x:70,y:80,width:self.view.frame.width-140,height:150)
        
        lblUserName.frame = CGRect(x:20,y:topLogo.frame.origin.y+topLogo.frame.height+15,width:self.view.frame.width-40,height:45)
        txtUserName.frame = CGRect(x:20,y:lblUserName.frame.origin.y+lblUserName.frame.height,width:self.view.frame.width-40,height:45)
        lblMobileNumber.frame = CGRect(x:20,y:txtUserName.frame.origin.y+txtUserName.frame.height+10,width:self.view.frame.width-40,height:45)
        txtMobileNo.frame = CGRect(x:20,y:lblMobileNumber.frame.origin.y+lblMobileNumber.frame.height,width:self.view.frame.width-40,height:55)
        
        
        btnForgotPassword.frame = CGRect(x:20,y:txtMobileNo.frame.origin.y+txtMobileNo.frame.height+30,width:self.view.frame.width-40,height:55)
       btnAlready.frame = CGRect(x:20,y:btnForgotPassword.frame.origin.y+btnForgotPassword.frame.height+30,width:self.view.frame.width-40,height:55)
        
        
        txtUserName.setRightViewFAIcon(icon: .FAUser)
        txtMobileNo.setRightViewFAIcon(icon: .FAMobile)
        
        btnForgotPassword.addTarget(self, action: #selector(forgotPassword), for: UIControlEvents.touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    @objc func forgotPassword(){
        if isConnectedToNetwork() {
        if(txtUserName.text! == ""){
            self.view.makeToast("Please Enter UserName", duration: 3.0, position: .top)
        }else if(txtMobileNo.text! == ""){
            self.view.makeToast("Please Enter Mobile Number", duration: 3.0, position: .top)
        }else{
        
        let parameters = "username=\(txtUserName.text!)&contact=\(txtMobileNo.text!)"
        let url = URL(string:ServerUrl.forgot_password_url)!
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
                       
                        let data = json?.object(forKey: "data") as? String;
                        
                        
                       
                       
                        let alertController = JHTAlertController(title:"Now Go to Login", message:"Your Login Password is : "+data!, preferredStyle: .alert)
                        
                        alertController.titleTextColor = .black
                        alertController.titleFont = .systemFont(ofSize: 18)
                        alertController.titleViewBackgroundColor = .white
                        alertController.messageTextColor = .black
                        alertController.alertBackgroundColor = .white
                        alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                        
                        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                           //  DispatchQueue.main.async {
                            //self.performSegue(withIdentifier: "ForgotpassToLogin", sender: self)
                           // }
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let gotoLogin = self.storyboard?.instantiateViewController(withIdentifier: "loginCntr") as? LoginViewCntr
//                            self.navigationController?.pushViewController(gotoLogin!, animated: true)
                            
                        }
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       
                        self.showAlert(title: "Invalid Credential", message: error_msg!)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
