//
//  JobSeekerCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import Toast_Swift
class JobSeekerCntr: UIViewController,SSRadioButtonControllerDelegate {
    
    

   
    @IBOutlet weak var lblJob: UILabel!
    @IBOutlet weak var txtJobName: UITextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lblJainReligion: UILabel!
    
    
    @IBOutlet weak var btnReligionNo: SSRadioButton!
    @IBOutlet weak var btnReligionYes: SSRadioButton!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var txtEceprience: UITextField!
    
    @IBOutlet weak var lblWorkDetail: UILabel!
    @IBOutlet weak var txtWorkDetail: UITextView!
     var religonRadioButton: SSRadioButtonsController?
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Job Seeker"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:6,length:6))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
        religonRadioButton = SSRadioButtonsController(buttons: btnReligionNo, btnReligionYes)
        religonRadioButton!.delegate = self
        religonRadioButton!.shouldLetDeSelect = true
       
        lblJob.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        txtJobName.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:50)
        
        lblJob.text = "Name".localized1
        txtJobName.placeholder = "Name".localized1
        
        lblEmail.frame = CGRect(x:10,y:100,width:self.view.frame.width-20,height:25)
        txtEmail.frame = CGRect(x:10,y:130,width:self.view.frame.width-20,height:50)
        
        lblEmail.text = "Email".localized1
        txtEmail.placeholder = "Email".localized1
        
        lblJainReligion.frame = CGRect(x:10,y:190,width:self.view.frame.width-20,height:25)
        btnReligionYes.frame = CGRect(x:10,y:220,width:self.view.frame.width/2,height:50)
        btnReligionNo.frame = CGRect(x:self.view.frame.width/2,y:220,width:self.view.frame.width/2,height:50)
        
        lblJainReligion.text = "JainReligion".localized1
        btnReligionYes.setTitle("Yes".localized1, for: .normal)
        btnReligionNo.setTitle("No".localized1, for: .normal)
        
        lblExperience.frame = CGRect(x:10,y:280,width:self.view.frame.width-20,height:25)
        txtEceprience.frame = CGRect(x:10,y:310,width:self.view.frame.width-20,height:50)
        
        lblExperience.text = "Experiance".localized1
        txtEceprience.placeholder = "Experiance".localized1
        
        lblWorkDetail.frame = CGRect(x:10,y:370,width:self.view.frame.width-20,height:25)
        txtWorkDetail.frame = CGRect(x:10,y:400,width:self.view.frame.width-20,height:120)
        lblWorkDetail.text = "WorkDetails".localized1
        
        
        btnRegister.frame = CGRect(x:10,y:540,width:self.view.frame.width-20,height:50)
        btnRegister.addTarget(self, action: #selector(JobSeekerCntr.AddJobSeekerEnquiry(_:)), for: UIControlEvents.touchUpInside)
        btnRegister.setTitle("Register".localized1, for: .normal)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func AddJobSeekerEnquiry(_ sender : UIButton){
        if isConnectedToNetwork() {
        if( txtJobName.text! == ""){
            self.view.makeToast("Please Enter Job Name", duration: 2.0, position: .top)
        }else if(txtEmail.text! == ""){
            self.view.makeToast("Please Enter Email", duration: 2.0, position: .top)
        }
//        else if(txtEmail.text!.isValidEmail()){
//            self.view.makeToast("Please Enter Correct Email", duration: 2.0, position: .top)
//        }
        else if(religonRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Religion", duration: 2.0, position: .top)
        }
        else if(txtEceprience.text! == ""){
            self.view.makeToast("Please Enter Experience", duration: 2.0, position: .top)
        }else if(txtWorkDetail.text! == ""){
            self.view.makeToast("Please Enter Work Details", duration: 2.0, position: .top)
        }
        else{

            
           
            var religionData = String()
            if(religonRadioButton?.selectedButton()?.currentTitle == ""){
                religionData = ""
            }else{
                religionData = (religonRadioButton?.selectedButton()?.currentTitle)!
            }
            let parameters = "jobseeker_name=\(txtJobName.text!)&email_id=\(txtEmail.text!)&member_id=\(UserDefaults.standard.getUserID())&jain_religion=\(religionData)&experiance=\(txtEceprience.text!)&work_details=\(txtWorkDetail.text!)&message=\("done")"
            
          
            let url = URL(string:ServerUrl.post_job_seeker)!
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
                            self.showAlert(title: "Well Done", message: "Job Seeker Added Succesfully")
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
    func didSelectButton(selectedButton: UIButton?) {
        print("he")
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
