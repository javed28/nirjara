//
//  ContactInfoCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DatePickerDialog
import JHTAlertController
class ContactInfoCntr: UIViewController {

    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblContactText: UILabel!
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var BirthDatePicker: UITextField!
    var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Contact Information"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:10,length:11))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        updateBackButton()
        
        BirthDatePicker.delegate = self
        topView.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblContactText.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView.addSubview(imgLogo)
        topView.layer.cornerRadius = 5
        topView.addSubview(lblContactText)
        lblName.frame = CGRect(x:10,y:topView.frame.origin.y+topView.frame.height+10,width:self.view.frame.width-20,height:25)
        txtName.frame = CGRect(x:10,y:lblName.frame.origin.y+lblName.frame.height+5,width:self.view.frame.width-20,height:40)
        
        lblEmail.frame = CGRect(x:10,y:txtName.frame.origin.y+txtName.frame.height+10,width:self.view.frame.width-20,height:25)
        txtEmail.frame = CGRect(x:10,y:lblEmail.frame.origin.y+lblEmail.frame.height+5,width:self.view.frame.width-20,height:40)
        
        lblMobile.frame = CGRect(x:10,y:txtEmail.frame.origin.y+txtEmail.frame.height+10,width:self.view.frame.width-20,height:25)
        txtMobile.frame = CGRect(x:10,y:lblMobile.frame.origin.y+lblMobile.frame.height+5,width:self.view.frame.width-20,height:40)
        
        lblDob.frame = CGRect(x:10,y:txtMobile.frame.origin.y+txtMobile.frame.height+10,width:self.view.frame.width-20,height:25)
        BirthDatePicker.frame = CGRect(x:10,y:lblDob.frame.origin.y+lblDob.frame.height+5,width:self.view.frame.width-20,height:40)
        
        btnSubmit.frame = CGRect(x:10,y:BirthDatePicker.frame.origin.y+BirthDatePicker.frame.height+25,width:self.view.frame.width-20,height:50)
        btnSubmit.layer.cornerRadius = 5
        
        
        txtName.text = GlobalVariables.member_name
        txtEmail.text = GlobalVariables.email_id
        txtMobile.text = GlobalVariables.contact
        
        lblName.text = "FullName".localized1
        lblEmail.text = "Email".localized1
        lblMobile.text = "MobileNumber".localized1
        lblDob.text = "DOB".localized1
        txtName.placeholder = "Add".localized1+" "+"FullName".localized1
        txtEmail.placeholder = "Add".localized1+" "+"Email".localized1
        txtMobile.placeholder = "Add".localized1+" "+"MobileNumber".localized1
        BirthDatePicker.placeholder = "Add".localized1+" "+"DOB".localized1
        
        btnSubmit.setTitle("Submit".localized1, for: .normal)
       // btnSubmit.addTarget(self, action: #selector(updateBankDetail(_:)), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        BirthDatePicker.setRightViewFAIcon(icon: .FABirthdayCake)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        self.BirthDatePicker.text! =  GlobalVariables.dob
         containerController = revealViewController().frontViewController as? ContainerViewController
        btnSubmit.addTarget(self, action: #selector(updateContactDetail(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func updateContactDetail(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtName.text == ""){
            self.view.makeToast("Please Add User Name", duration: 2.0, position: .top)
        }else if(txtMobile.text == ""){
            self.view.makeToast("Please Add Mobile Number", duration: 2.0, position: .top)
        }
        else{

            var birthDate = String()
            var email = String()
            
            if(BirthDatePicker.text == "Selected DOB"){
                birthDate = "00-00-0000"
            }else{
                
                birthDate = (BirthDatePicker.text?.convertDateForDob(BirthDatePicker.text!))!
            }
            
            if(txtEmail.text == ""){
                email = ""
            }else{
                email = txtEmail.text!
                
            }
            
            let parameters = "member_name=\(txtName.text!)&member_id=\(UserDefaults.standard.getUserID())&dob=\(birthDate)&email_id=\(email)&contact=\(txtMobile.text!)"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.update_user_personal_detail)!
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
                            
                              GlobalVariables.member_name =  self.txtName.text!
                              GlobalVariables.email_id = self.txtEmail.text!
                              GlobalVariables.contact = self.txtMobile.text!
                              GlobalVariables.dob = self.BirthDatePicker.text!
                            self.hideActivityIndicator()
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:"Profile Details Updated", preferredStyle: .alert)
                            
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
    
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = -99
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: UIColor.rgb(hexcolor: "#FF9800"),
                                          buttonColor: UIColor.rgb(hexcolor: "#FF9800"),
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Select Your BirthDate",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd-MM-yyyy"
                                
                                
                                self.BirthDatePicker.text = formatter.string(from: dt)
                                
                            }
                            
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
extension ContactInfoCntr: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.BirthDatePicker {
            datePickerTapped()
            return false
        }
        
        return true
    }
}
