//
//  BankDetailCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController

class BankDetailCntr: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblBankText: UILabel!
    
    
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtBranchName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtAccountNo: UITextField!
    @IBOutlet weak var txtIfsc: UITextField!
    @IBOutlet weak var txtAccountType: UITextField!
    var containerController: ContainerViewController?
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Bank Details"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:7,length:7))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        updateBackButton()
        
        topView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblBankText.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView.addSubview(imgLogo)
        topView.layer.cornerRadius = 5
        topView.addSubview(lblBankText)
        txtBankName.frame = CGRect(x:10,y:topView.frame.origin.y+topView.frame.height+10,width:self.view.frame.width-20,height:40)
        txtAccountNo.frame = CGRect(x:10,y:txtBankName.frame.origin.y+txtBankName.frame.height+10,width:self.view.frame.width-20,height:40)
        txtIfsc.frame = CGRect(x:10,y:txtAccountNo.frame.origin.y+txtAccountNo.frame.height+10,width:self.view.frame.width-20,height:40)
       // txtBranchName.frame = CGRect(x:10,y:txtBankName.frame.origin.y+txtBankName.frame.height+10,width:self.view.frame.width-20,height:40)
       // txtAddress.frame = CGRect(x:10,y:txtBranchName.frame.origin.y+txtBranchName.frame.height+10,width:self.view.frame.width-20,height:40)
        //txtAccountType.frame = CGRect(x:10,y:txtIfsc.frame.origin.y+txtIfsc.frame.height+10,width:self.view.frame.width-20,height:40)
        
        containerController = revealViewController().frontViewController as? ContainerViewController
        txtBankName.text = GlobalVariables.bank_name
        txtAccountNo.text = GlobalVariables.account_number
        txtIfsc.text = GlobalVariables.ifsc
        
        btnSubmit.frame = CGRect(x:10,y:txtIfsc.frame.origin.y+txtIfsc.frame.height+25,width:self.view.frame.width-20,height:50)
        btnSubmit.layer.cornerRadius = 5
        txtBranchName.alpha = 0
        txtAddress.alpha = 0
        txtAccountType.alpha = 0
        txtBankName.placeholder = "Add".localized1+" "+"BankName".localized1
        txtBranchName.placeholder = "Add Branch Name"
        txtAddress.placeholder = "Add".localized1+" "+"Address".localized1
        txtAccountNo.placeholder = "Add".localized1+" "+"AccountNumber".localized1
        txtIfsc.placeholder = "Add".localized1+" "+"IFSC".localized1
        txtAccountType.placeholder = "Add Account Type Current/Saving"
        btnSubmit.setTitle("Submit".localized1, for: .normal)
        btnSubmit.addTarget(self, action: #selector(updateBankDetail(_:)), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func updateBankDetail(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtBankName.text == ""){
            self.view.makeToast("Please Add Bank Name", duration: 2.0, position: .top)
        }else if(txtAccountNo.text == ""){
            self.view.makeToast("Please Add Account Number", duration: 2.0, position: .top)
        }else if(txtIfsc.text == ""){
            self.view.makeToast("Please Add IFSC", duration: 2.0, position: .top)
        }
        else{
            
            let parameters = "bank_name=\(txtBankName.text!)&member_id=\(UserDefaults.standard.getUserID())&account_number=\(txtAccountNo.text!)&ifsc=\(txtIfsc.text!)"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.update_bank_detail)!
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
                            
                            GlobalVariables.bank_name = self.txtBankName.text!
                             GlobalVariables.account_number = self.txtAccountNo.text!
                             GlobalVariables.ifsc = self.txtIfsc.text!
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:"Bank Details Updated", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                self.navigationController?.popViewController(animated: true)
                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![3]
                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[4])
                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
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
