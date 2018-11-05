//
//  AddJobCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import Toast_Swift
import JHTAlertController
import IQKeyboardManagerSwift
class AddJobCntr: UIViewController {

    @IBOutlet weak var lblJobtitle: UILabel!
    @IBOutlet weak var txtJobTitle: UITextField!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var txtCompanyName: UITextField!
    
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var txtExperience: UITextField!
    
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var lblJobInfor: UILabel!
    @IBOutlet weak var txtJobInforma: UITextView!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var btnAddJob: UIButton!
    
    var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Add Job"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:6,length:3))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        lblJobtitle.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        txtJobTitle.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:50)
        
        
        lblJobtitle.text = "JobTitle".localized1
        txtJobTitle.placeholder = "JobTitle".localized1
        
        lblCompanyName.frame = CGRect(x:10,y:100,width:self.view.frame.width-20,height:25)
        txtCompanyName.frame = CGRect(x:10,y:130,width:self.view.frame.width-20,height:50)
        
        lblCompanyName.text = "CompanyName".localized1
        txtCompanyName.placeholder = "CompanyName".localized1
        
        lblExperience.frame = CGRect(x:10,y:190,width:self.view.frame.width-20,height:25)
        txtExperience.frame = CGRect(x:10,y:220,width:self.view.frame.width-20,height:50)
        
        lblExperience.text = "Experiance".localized1
        txtExperience.placeholder = "Experiance".localized1
        
        lblMobile.frame = CGRect(x:10,y:280,width:self.view.frame.width-20,height:25)
        txtMobile.frame = CGRect(x:10,y:310,width:self.view.frame.width-20,height:50)
        
        lblMobile.text = "Mobile".localized1
        txtMobile.placeholder = "Mobile".localized1
        
        lblContactNo.frame = CGRect(x:10,y:370,width:self.view.frame.width-20,height:25)
        txtContactNo.frame = CGRect(x:10,y:400,width:self.view.frame.width-20,height:50)
        
        lblContactNo.text = "ContactPerson".localized1
        txtContactNo.placeholder = "ContactPerson".localized1
        
        lblJobInfor.frame = CGRect(x:10,y:460,width:self.view.frame.width-20,height:25)
        txtJobInforma.frame = CGRect(x:10,y:490,width:self.view.frame.width-20,height:120)
        
        lblJobInfor.text = "JobInformation".localized1
        
        
        lblLocation.frame = CGRect(x:10,y:620,width:self.view.frame.width-20,height:25)
        txtLocation.frame = CGRect(x:10,y:650,width:self.view.frame.width-20,height:50)
        
        lblLocation.text = "Location".localized1
        txtLocation.placeholder = "Location".localized1
        
        btnAddJob.frame = CGRect(x:10,y:720,width:self.view.frame.width-20,height:50)
        btnAddJob.addTarget(self, action: #selector(AddJobCntr.AddJob(_:)), for: UIControlEvents.touchUpInside)
        btnAddJob.setTitle("Add".localized1+" "+"AddJob".localized1, for: .normal)
        containerController = revealViewController().frontViewController as? ContainerViewController
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func AddJob(_ sender : UIButton){
        if isConnectedToNetwork() {
        if( txtJobTitle.text! == ""){
            self.view.makeToast("Please Enter Job Title", duration: 2.0, position: .top)
        }else if(txtCompanyName.text! == ""){
            self.view.makeToast("Please Enter Company Name", duration: 2.0, position: .top)
        } else if(txtExperience.text! == ""){
            self.view.makeToast("Please Enter Experience", duration: 2.0, position: .top)
            }
        else if(txtMobile.text! == ""){
            self.view.makeToast("Please Enter Mobile No.", duration: 2.0, position: .top)
        }
        else if(txtMobile.text!.isPhone()){
            self.view.makeToast("Please Enter Correct Mobile No.", duration: 2.0, position: .top)
        }
        else if(txtContactNo.text!.isPhone()){
            self.view.makeToast("Please Enter Contact Person Name", duration: 2.0, position: .top)
        }
        else if(txtJobInforma.text! == ""){
            self.view.makeToast("Please Enter Contact Job Information", duration: 2.0, position: .top)
        }else if(txtLocation.text! == ""){
            self.view.makeToast("Please Enter Location", duration: 2.0, position: .top)
        }
        else{
            
            let parameters = "job_position=\(txtJobTitle.text!)&company_name=\(txtCompanyName.text!)&member_id=\(UserDefaults.standard.getUserID())&experiance_required=\(txtExperience.text!)&mobile_number=\(txtMobile.text!)&contact_person=\(txtContactNo.text!)&job_details=\(txtJobInforma.text!)&job_location=\(txtLocation.text!)"
            
           
            let url = URL(string:ServerUrl.add_new_job)!
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
                    if (Success == "Success")
                    {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            //self.showAlert(title: "Well Done", message: "Job Added Added Succesfully")
                            let alertController = JHTAlertController(title: "Success", message:"Job Added Added Succesfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
                                
                                
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
