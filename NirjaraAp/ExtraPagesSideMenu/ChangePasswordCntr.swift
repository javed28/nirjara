//
//  ChangePasswordCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/10/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import IQKeyboardManagerSwift
class ChangePasswordCntr: UIViewController {

    @IBOutlet weak var lblOldPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        let myString:NSString = "  Change Password"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:9,length:8))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        mainView.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:440)
    
        lblOldPassword.frame = CGRect(x:10,y:20,width:mainView.frame.width-20,height:25)
        txtOldPassword.frame = CGRect(x:10,y:55,width:mainView.frame.width-20,height:50)
        
        
        lblNewPassword.frame = CGRect(x:10,y:120,width:mainView.frame.width-20,height:25)
        txtNewPassword.frame = CGRect(x:10,y:155,width:mainView.frame.width-20,height:50)
        
        lblConfirmPassword.frame = CGRect(x:10,y:220,width:mainView.frame.width-20,height:25)
        txtConfirmPassword.frame = CGRect(x:10,y:255,width:mainView.frame.width-20,height:50)
    
        
        btnSave.frame = CGRect(x:10,y:350,width:mainView.frame.width-20,height:50)
        
        btnSave.addTarget(self, action: #selector(changePassword), for: UIControlEvents.touchUpInside)
        
        mainView.addSubview(lblOldPassword)
        mainView.addSubview(txtOldPassword)
        mainView.addSubview(lblNewPassword)
        mainView.addSubview(txtNewPassword)
        mainView.addSubview(lblConfirmPassword)
        mainView.addSubview(txtConfirmPassword)
       
        mainView.addSubview(btnSave)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func changePassword(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtOldPassword.text! == ""){
            self.view.makeToast("Please Enter Old Password", duration: 2.0, position: .top)
        }else if(txtNewPassword.text! == ""){
            self.view.makeToast("Please Enter New Password", duration: 2.0, position: .top)
        } else if(txtConfirmPassword.text! == ""){
            self.view.makeToast("Please Enter Confirm Password", duration: 2.0, position: .top)
        }
        else if((txtNewPassword.text!) == (txtOldPassword.text!)){
            self.view.makeToast("New Password cannot be Same as Old Password", duration: 2.0, position: .top)
        }
        else if((txtNewPassword.text!) != (txtConfirmPassword.text!)){
            self.view.makeToast("New Password and Confirm Password Should be same", duration: 2.0, position: .top)
        }
        
        else{
            
            let parameters = "old_password=\(txtOldPassword.text!)&new_password=\(txtConfirmPassword.text!)&member_id=\(UserDefaults.standard.getUserID())"
            
            print("change Pass URl-",parameters)
            let url = URL(string:ServerUrl.get_current_password)!
            print("change Pass URl-",url)
            
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
                            // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                            self.hideActivityIndicator()
                            let alertController = JHTAlertController(title: "Success", message:"Password Changed successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let gotoHome = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                                self.navigationController?.pushViewController(gotoHome!, animated: true)
                                
                                
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
