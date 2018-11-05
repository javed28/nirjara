//
//  PersonalInformationCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
class PersonalInformationCntr: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblPersonal: UILabel!
    
    @IBOutlet weak var topView1: UIView!
    @IBOutlet weak var lblWork: UILabel!
    @IBOutlet weak var imgWork: UIImageView!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var bottomline: UIView!
    
    @IBOutlet weak var btnAddWorkPlace: UIButton!
    @IBOutlet weak var btnAddWorkPlace1: UIButton!
    
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnLocation1: UIButton!
    
    
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var imgaddress: UIImageView!
    @IBOutlet weak var lblAddAddress: UILabel!
    
    
    @IBOutlet weak var imgCity: UIImageView!
    @IBOutlet weak var btnCity: UIButton!
    
    @IBOutlet weak var imgState: UIImageView!
    @IBOutlet weak var btnState: UIButton!
    
    @IBOutlet weak var addressTopLine: UIView!
    @IBOutlet weak var addressBottomLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Personal Information"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:11))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        updateBackButton()
        
        
        topView.frame = CGRect(x:10,y:topbarHeight+8,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblPersonal.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView.addSubview(imgLogo)
        topView.addSubview(lblPersonal)
        topView.layer.cornerRadius = 5
        
        
        
        topView1.frame = CGRect(x:10,y:topView.frame.origin.y+topView.frame.height+10,width:self.view.frame.width-20,height:145)
        imgWork.frame = CGRect(x:10,y:5,width:30,height:30)
        lblWork.frame = CGRect(x:55,y:5,width:self.topView1.frame.width-20,height:30)
        
        topLine.frame = CGRect(x:10,y:lblWork.frame.origin.y+lblWork.frame.height+5,width:self.topView1.frame.width-20,height:1)
        
        btnAddWorkPlace.frame = CGRect(x:10,y:topLine.frame.origin.y+topLine.frame.height+10,width:30,height:30)
        btnAddWorkPlace1.frame = CGRect(x:55,y:topLine.frame.origin.y+topLine.frame.height,width:self.topView1.frame.width-150,height:50)
        
        bottomline.frame = CGRect(x:10,y:btnAddWorkPlace.frame.origin.y+btnAddWorkPlace.frame.height+10,width:self.topView1.frame.width-20,height:1)
        
        btnLocation.frame = CGRect(x:10,y:bottomline.frame.origin.y+bottomline.frame.height+10,width:30,height:30)
        btnLocation1.frame = CGRect(x:55,y:bottomline.frame.origin.y+bottomline.frame.height,width:self.topView1.frame.width-150,height:50)
        
        
        
        
        btnAddWorkPlace.addTarget(self, action: #selector(AddWork(_:)), for: .touchUpInside)
        btnAddWorkPlace1.addTarget(self, action: #selector(AddWork(_:)), for: .touchUpInside)
        btnLocation.addTarget(self, action: #selector(AddWorkPlace(_:)), for: .touchUpInside)
        btnLocation1.addTarget(self, action: #selector(AddWorkPlace(_:)), for: .touchUpInside)
        
        
        
        topView1.addSubview(imgWork)
        topView1.addSubview(lblWork)
        topView1.addSubview(topLine)
        topView1.addSubview(btnAddWorkPlace)
        topView1.addSubview(btnAddWorkPlace1)
        topView1.addSubview(bottomline)
        topView1.addSubview(btnLocation)
        topView1.addSubview(btnLocation1)
        topView1.layer.cornerRadius = 5

        
        
        addressView.frame = CGRect(x:10,y:topView1.frame.origin.y+topView1.frame.height+10,width:self.view.frame.width-20,height:150)
        imgaddress.frame = CGRect(x:10,y:5,width:30,height:30)
        lblAddAddress.frame = CGRect(x:55,y:5,width:self.addressView.frame.width-20,height:30)
        
        addressTopLine.frame = CGRect(x:10,y:imgaddress.frame.origin.y+imgaddress.frame.height+5,width:self.addressView.frame.width-20,height:1)
        
        imgCity.frame = CGRect(x:10,y:addressTopLine.frame.origin.y+addressTopLine.frame.height+10,width:30,height:30)
        btnCity.frame = CGRect(x:55,y:addressTopLine.frame.origin.y+addressTopLine.frame.height,width:self.addressView.frame.width-150,height:50)
        
        addressBottomLine.frame = CGRect(x:10,y:imgCity.frame.origin.y+imgCity.frame.height+10,width:self.addressView.frame.width-20,height:1)
        
        imgState.frame = CGRect(x:10,y:addressBottomLine.frame.origin.y+addressBottomLine.frame.height+10,width:30,height:30)
        btnState.frame = CGRect(x:55,y:addressBottomLine.frame.origin.y+addressBottomLine.frame.height,width:self.addressView.frame.width-150,height:50)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        imgCity.isUserInteractionEnabled = true
        imgCity.addGestureRecognizer(tapGestureRecognizer1)
        imgState.isUserInteractionEnabled = true
        imgState.addGestureRecognizer(tapGestureRecognizer)
        
        
        btnCity.addTarget(self, action: #selector(goToState(_:)), for: .touchUpInside)
        btnState.addTarget(self, action: #selector(goToState(_:)), for: .touchUpInside)
       
        
        addressView.addSubview(imgaddress)
        addressView.addSubview(lblAddAddress)
        addressView.addSubview(addressTopLine)
        addressView.addSubview(imgCity)
        addressView.addSubview(btnCity)
        addressView.addSubview(addressBottomLine)
        addressView.addSubview(imgState)
        addressView.addSubview(btnState)
        addressView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let stateGoto = storyBoard.instantiateViewController(withIdentifier: "gotoUpdateCityIndentifier1") as! UpdateCityState1Cntr
        self.navigationController?.pushViewController(stateGoto, animated: true)
        // Your action
    }
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let stateGoto = storyBoard.instantiateViewController(withIdentifier: "gotoUpdateCityIndentifier1") as! UpdateCityState1Cntr
        self.navigationController?.pushViewController(stateGoto, animated: true)
        // Your action
    }
    override func viewWillAppear(_ animated: Bool) {
        if(GlobalVariables.work == ""){
            btnAddWorkPlace1.setTitle("Add Work", for: .normal)
        }else{
            btnAddWorkPlace1.setTitle(GlobalVariables.work, for: .normal)
        }
        if(GlobalVariables.work_address == ""){
            btnLocation1.setTitle("Add WorkPlace", for: .normal)
        }else{
            btnLocation1.setTitle(GlobalVariables.work_address, for: .normal)
        }
        if(GlobalVariables.member_city == ""){
            btnCity.setTitle("Add City", for: .normal)
        }else{
            btnCity.setTitle(GlobalVariables.member_city, for: .normal)
        }
        if(GlobalVariables.state == ""){
            btnState.setTitle("Add State", for: .normal)
        }else{
            btnState.setTitle(GlobalVariables.state, for: .normal)
        }
    }
    @objc func goToState(_ sender : UIButton){
        //self.performSegue(withIdentifier: "updateStateCityIdentifier", sender: self)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let stateGoto = storyBoard.instantiateViewController(withIdentifier: "gotoUpdateCityIndentifier1") as! UpdateCityState1Cntr
        self.navigationController?.pushViewController(stateGoto, animated: true)
        
    }

    
    @objc func AddWork(_ sender : UIButton) {
        
        let alertController = UIAlertController(title: "Add Work", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            
            if fNameField.text == "" {
                //self.view.makeToast("Please Enter Tap Count", duration: 2.0, position: .top)
                let errorAlert = UIAlertController(title: "Error", message: "Please Enter Work", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
                // self.newUser = User(fn: fNameField.text!, ln: lNameField.text!)
                //TODO: Save user data in persistent storage - a tutorial for another time
            } else {
                self.updateWork(userWork: fNameField.text!)
                
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            if(GlobalVariables.work == ""){
                textField.placeholder = "Add Work "
            }else{
                textField.placeholder = GlobalVariables.work
            }
            textField.textAlignment = .left
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func AddWorkPlace(_ sender : UIButton) {
        
        let alertController = UIAlertController(title: "Add Work Place", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            
            if fNameField.text == "" {
                //self.view.makeToast("Please Enter Tap Count", duration: 2.0, position: .top)
                let errorAlert = UIAlertController(title: "Error", message: "Please Enter Work Place", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
                // self.newUser = User(fn: fNameField.text!, ln: lNameField.text!)
                //TODO: Save user data in persistent storage - a tutorial for another time
            } else {
                
                self.updateWorkAddress(userAddress:fNameField.text!)
                
                
                
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            
            if(GlobalVariables.work_address == ""){
               textField.placeholder = "Add Work Place"
            }else{
                textField.placeholder = GlobalVariables.work_address
                
            }
            
            textField.textAlignment = .left
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func updateWork(userWork : String){
        
        let parameters = "work=\(userWork)&member_id=\(UserDefaults.standard.getUserID())"
        print("paratemer samaj-----",parameters)
        let url = URL(string:ServerUrl.get_user_work_update)!
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
                        GlobalVariables.work = userWork
                        self.btnAddWorkPlace1.setTitle(userWork, for: .normal)
                        
                        //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                        let alertController = JHTAlertController(title: "Success", message:"Work Updated", preferredStyle: .alert)
                        
                        alertController.titleTextColor = .black
                        alertController.titleFont = .systemFont(ofSize: 18)
                        alertController.titleViewBackgroundColor = .white
                        alertController.messageTextColor = .black
                        alertController.alertBackgroundColor = .white
                        alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                        
                        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                            
                            //                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                            //                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[1])
                            //                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                        
                            
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
    
    @objc func updateWorkAddress(userAddress : String){
        if isConnectedToNetwork() {
        let parameters = "work_address=\(userAddress)&member_id=\(UserDefaults.standard.getUserID())"
        print("paratemer samaj-----",parameters)
        let url = URL(string:ServerUrl.get_user_workplace_address)!
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
                        
                        GlobalVariables.work_address = userAddress
                        self.btnLocation1.setTitle(GlobalVariables.work_address, for: .normal)
                        
                        self.hideActivityIndicator()
                        //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                        let alertController = JHTAlertController(title: "Success", message:"Work Place Updated", preferredStyle: .alert)
                        
                        alertController.titleTextColor = .black
                        alertController.titleFont = .systemFont(ofSize: 18)
                        alertController.titleViewBackgroundColor = .white
                        alertController.messageTextColor = .black
                        alertController.alertBackgroundColor = .white
                        alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                        
                        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                            
                            //                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                            //                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[1])
                            //                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                        
                            
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
