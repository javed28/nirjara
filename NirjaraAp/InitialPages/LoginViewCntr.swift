//
//  LoginViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class LoginViewCntr: UIViewController {

    @IBOutlet weak var fogotlockIcon: UIImageView!
    @IBOutlet weak var topLogo: UIImageView!
     @IBOutlet weak var imgLocLogo: UIImageView!
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var userPassword: HideShowPasswordTextField!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        topLogo.frame = CGRect(x:70,y:85,width:self.view.frame.width-140,height:150)
    
        txtUserName.frame = CGRect(x:20,y:topLogo.frame.origin.y+185,width:self.view.frame.width-40,height:45)
        userPassword.frame = CGRect(x:20,y:topLogo.frame.origin.y+245,width:self.view.frame.width-40,height:45)
        btnLogin.frame = CGRect(x:20,y:topLogo.frame.origin.y+320,width:self.view.frame.width-40,height:55)
        btnRegister.frame = CGRect(x:20,y:topLogo.frame.origin.y+440,width:self.view.frame.width-40,height:55)
        
        imgLocLogo.frame = CGRect(x:20,y:topLogo.frame.origin.y+382,width:40,height:45)
        btnForgotPassword.frame = CGRect(x:80,y:topLogo.frame.origin.y+382,width:180,height:45)
        
        
        txtUserName.setRightViewFAIcon(icon: .FAUser)
        userPassword.setRightViewFAIcon(icon: .FAUnlock)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        
      //  UserDefaults.standard.set(true, forKey: "UserLoggedIn")
        if(txtUserName.text == ""){
            self.view.makeToast("Please Enter User Name", duration: 2.0, position: .bottom)
        }else if(userPassword.text == ""){
            self.view.makeToast("Please Enter Password", duration: 2.0, position: .bottom)
        }else{
             if isConnectedToNetwork() {
        Login(strEmail: txtUserName.text!,strPassword: userPassword.text!)
             }else{
                showAlert(title: "Oop's", message: "No Internet Connection")
            }
        }
    }
    
    
    func Login(strEmail :String,strPassword :String){
        let parameters = "username=\(strEmail)&password=\(strPassword)"
        let url = URL(string:ServerUrl.loginUrl)!
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
                print("Json----",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let data = json?.object(forKey: "result") as? [NSDictionary]
                    let jsonObject1 = data![0]
                    print(jsonObject1)
                    
                    let member_id = jsonObject1.object(forKey: "member_id") as? String
                    let member_name = jsonObject1.object(forKey: "member_name") as? String
                    let gender = jsonObject1.object(forKey: "gender") as? String
                    let email_id = jsonObject1.object(forKey: "email_id") as? String
                    let language = jsonObject1.object(forKey: "language") as? String
                    let member_type = jsonObject1.object(forKey: "member_type") as? String
                     let adithana = jsonObject1.object(forKey: "adithana") as? String
                    let contact = jsonObject1.object(forKey: "contact") as? String
                    let intro_checked = jsonObject1.object(forKey: "intro_checked") as? String
                    
                    if(adithana == "null" || adithana == "<null>" || adithana == nil){
                        
                    }else{
                        UserDefaults.standard.setAdhithana(value: adithana!)
                    }
                    if(contact?.description == "null" || contact?.description == "<null>" || contact?.description == nil){
                        
                    }else{
                        print("mobilenumber---",contact!.description)
                        UserDefaults.standard.setMobileNumber(value: contact!.description)
                    }
//                    if(contact?.description == "null" || contact?.description == "<null>" || contact?.description == nil){
//
//                    }else{
//                        print("mobilenumber---",contact!.description)
//                        UserDefaults.standard.setMobileNumber(value: contact!.description)
//                    }
                    
                    
                    UserDefaults.standard.setUserID(value: member_id!)
                    UserDefaults.standard.setLoggedIn(value: true)
                    UserDefaults.standard.setMemberName(value: member_name!)
                    UserDefaults.standard.setMemberType(value: member_type!)
                    UserDefaults.standard.setLanguage(value: language!)
                    GlobalVariables.selectedLanguage = language!
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       // self.performSegue(withIdentifier: "logintointro", sender: self)
                        if(intro_checked == "0"){
                            self.performSegue(withIdentifier: "loginToVideoIntro", sender: self)
                        }else{
                        UserDefaults.standard.setIntroLoggedIn(value: true)
                        self.performSegue(withIdentifier: "LogintoHome", sender: self)
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       
                        self.showAlert(title: "Nirjara Ap", message: "Invalid Credential")
                    }
                }

            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    

    
    @IBAction func btnForgotClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToForgot", sender: self)
    }
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToRegister", sender: self)
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

extension LoginViewCntr: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, textField string: String) -> Bool {
        return userPassword.textField(textField, shouldChangeCharactersInRange: range, replacementString: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userPassword.textFieldDidEndEditing(textField)
    }
}

// MARK: HideShowPasswordTextFieldDelegate
// Implementing this delegate is entirely optional.
// It's useful when you want to show the user that their password is valid.
extension LoginViewCntr: HideShowPasswordTextFieldDelegate {
    func isValidPassword(_ password: String) -> Bool {
        return password.characters.count > 7
    }
}

