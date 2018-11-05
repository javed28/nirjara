//
//  AddSecurityAlertCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
class AddSecurityAlertCntr: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var SecurityData : NSMutableArray = NSMutableArray()
    var guruSecirtyNumber = String()
    var currentIndexPath = Int()
    
    @IBOutlet weak var secuirtyCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Add Security Number"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:6,length:15))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
            self.updateBackButton()
        //self.addShadowToBar()
        lblName.frame = CGRect(x:10,y:18,width:self.view.frame.width-20,height:25)
        txtName.frame = CGRect(x:10,y:lblName.frame.origin.y+lblName.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        lblContactNo.frame = CGRect(x:10,y:txtName.frame.origin.y+txtName.frame.height+15,width:self.view.frame.width-20,height:25)
        txtContactNo.frame = CGRect(x:10,y:lblContactNo.frame.origin.y+lblContactNo.frame.height+10,width:self.view.frame.width-20,height:45)
        btnSubmit.frame = CGRect(x:10,y:txtContactNo.frame.origin.y+txtContactNo.frame.height+25,width:self.view.frame.width-20,height:50)
        
        // Do any additional setup after loading the view.
        
        
        lblName.text = "Name".localized1
        lblContactNo.text = "ContactNumber".localized1
        
        border(textname: txtName,placholderText:"Name".localized1)
        border(textname: txtContactNo,placholderText:"ContactNumber".localized1)
        
        btnSubmit.addTarget(self, action: #selector(AddSecurityAlertCntr.AddSecurity(_:)), for: UIControlEvents.touchUpInside)
        btnSubmit.setTitle("Add".localized1+" "+"Number".localized1, for: .normal)
        secuirtyCollection.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: secuirtyCollection, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10))
      
        view.addConstraint(NSLayoutConstraint(item: secuirtyCollection, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: secuirtyCollection, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: btnSubmit.frame.origin.y+btnSubmit.frame.height+10))
        
        view.addConstraint(NSLayoutConstraint(item: secuirtyCollection, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom,multiplier: 1, constant: -50))
        
        self.view.addSubview(secuirtyCollection)
        self.lblNoRecord.frame = CGRect(x:10,y:btnSubmit.frame.origin.y+btnSubmit.frame.height+10,width:self.view.frame.width-20,height:30)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        SecurityData.removeAllObjects()
        self.secuirtyCollection.reloadData()
        self.lblNoRecord.alpha = 0
        self.secuirtyCollection.alpha = 0
        getSecurityNumber()
    }
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        return CGSize(width: self.secuirtyCollection.frame.width/2-5, height: 100)
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width
        
        return CGSize(width: collectionViewSize/2-5, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func border(textname : UITextField,placholderText : String){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 4, y : textname.frame.height-1,width:self.view.frame.width-28, height : 1.0)
        let color = UIColor.rgb(hexcolor:"#DCDCDC").cgColor
        bottomLine.backgroundColor = color
        textname.setTextLeftPadding(left: 10)
        
        textname.attributedPlaceholder = NSAttributedString(string:placholderText, attributes:[NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "DCDCDC"),NSAttributedStringKey.font :UIFont(name: "Helvetica", size: 18)!])
        textname.borderStyle = UITextBorderStyle.none
        textname.layer.addSublayer(bottomLine)
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
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "data") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var securityData = securityNumberModel()
                        
                        
                            securityData.guru_security_contact_id = jsonObject?.object(forKey: "guru_security_contact_id") as? String!
                            securityData.contact_person_name = jsonObject?.object(forKey: "contact_person_name") as? String!
                            securityData.contact_no = jsonObject?.object(forKey: "contact_no") as? String!
                        
                        self.SecurityData.add(securityData)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 0
                        self.secuirtyCollection.alpha = 1
                        self.secuirtyCollection.reloadData()
                        // self.sendMsg()
                    }
                }else if(Status == "fail"){
                    DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.lblNoRecord.alpha = 1
                    self.secuirtyCollection.alpha = 0
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SecurityData.count
    }
    
 
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = secuirtyCollection.dequeueReusableCell(withReuseIdentifier: "securityIdentifier", for: indexPath) as! SecurityNumberCollectionViewCell
        
        
        let securityData = SecurityData[indexPath.row] as! securityNumberModel
        
        cell.lblName.text = securityData.contact_person_name
        cell.lblContact.setFAText(prefixText: "", icon: .FAMobile, postfixText: " "+securityData.contact_no, size: 15)
        
        cell.lblName?.frame = CGRect(x:15,y:10,width:self.secuirtyCollection.frame.width,height:28)
       
        cell.lblContact?.frame = CGRect(x:15,y:40,width:self.secuirtyCollection.frame.width,height:28)
        
        cell.btnEdit?.frame = CGRect(x:15,y:70,width:25,height:25)
       
        cell.btnDelete?.frame = CGRect(x:self.secuirtyCollection.frame.width/2-45,y:70,width:25,height:25)
        
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
  
        cell.btnEdit.setFAIcon(icon: .FAEdit, iconSize: 18, forState: .normal)
        cell.btnDelete.setFAIcon(icon: .FATrash, iconSize: 18, forState: .normal)
        cell.btnEdit.setFATitleColor(color: UIColor.rgb(hexcolor: "#FF9800"), forState: .normal)
        cell.btnDelete.setFATitleColor(color: UIColor.rgb(hexcolor: "#FF9800"), forState: .normal)
        
        cell.btnEdit.addTarget(self, action: #selector(editSecuirty(_:)), for: UIControlEvents.touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(deleteSecuirty(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    @objc func editSecuirty(_ sender : UIButton){
         var data = SecurityData[sender.tag] as! securityNumberModel
        txtName.text = data.contact_person_name
        txtContactNo.text = data.contact_no
        self.guruSecirtyNumber = data.guru_security_contact_id
        self.currentIndexPath = sender.tag
        btnSubmit.tag = 1
        
    }
    @objc func deleteSecuirty(_ sender : UIButton){
        
        if isConnectedToNetwork() {
        let alertController = JHTAlertController(title: "Delete Number", message:"Are you sure you want to delete this Number?", preferredStyle: .alert)
        
        alertController.titleTextColor = .black
        alertController.titleFont = .systemFont(ofSize: 18)
        alertController.titleViewBackgroundColor = .white
        alertController.messageTextColor = .black
        alertController.alertBackgroundColor = .white

        
        let cancelAction = JHTAlertAction(title: "cancel", style: .cancel,  handler: nil)
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonBackgroundColorFor(.cancel, to: .white)
        
        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
            self.deleteNumber(indexID: sender.tag)
        }
        alertController.setButtonTextColorFor(.default, to: .white)
        alertController.setButtonBackgroundColorFor(.default, to: UIColor.rgb(hexcolor: "#387ef5"))
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }


    }
    
    func deleteNumber(indexID : Int){
        var data = SecurityData[indexID] as! securityNumberModel
        let parameters = "guru_security_contact_id=\(data.guru_security_contact_id!)&member_id=\(UserDefaults.standard.getUserID())"
        print("secuityr params",parameters)
        let url = URL(string:ServerUrl.delete_guru_contact)!
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
                print("security Response",json)
                let Success = json?.object(forKey: "message") as? String;
                if (Success == "success")
                {
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        self.SecurityData.removeObject(at: indexID)
                        self.secuirtyCollection.reloadData()
                        
                        self.showAlert(title: "Nirjara Ap", message: "Security Number Deleted Succesfully")
                        if(self.SecurityData.count == 0){
                            
                                self.lblNoRecord.alpha = 1
                                self.secuirtyCollection.alpha = 0
                            
                        }else{
                            self.lblNoRecord.alpha = 0
                            self.secuirtyCollection.alpha = 1
                        }
                        
                        
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
    
    
    @objc func AddSecurity(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(btnSubmit.tag == 1){
            if(txtName.text == ""){
                self.view.makeToast("Please Enter Name", duration: 2.0, position: .top)
            }else if(!txtContactNo.text!.isPhone()){
                self.view.makeToast("Please Enter Correct Mobile No", duration: 2.0, position: .top)
            }
            else{
                
                let parameters = "guru_security_contact_id=\(self.guruSecirtyNumber)&contact_person_name=\(txtName.text!)&member_id=\(UserDefaults.standard.getUserID())&contact_no=\(txtContactNo.text!)"
                print("secuityr params",parameters)
                let url = URL(string:ServerUrl.edit_guru_contact)!
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
                        print("security Response",json)
                        let Success = json?.object(forKey: "message") as? String;
                        if (Success == "success")
                        {
                            DispatchQueue.main.async {
                                self.hideActivityIndicator()
                                self.btnSubmit.tag = 0
                                
                                var data = self.SecurityData[sender.tag] as! securityNumberModel
                                var securityData = securityNumberModel()
                                
                                
                                securityData.guru_security_contact_id = data.guru_security_contact_id
                                securityData.contact_person_name = self.txtName.text!
                                securityData.contact_no = self.txtContactNo.text!
                                
                                self.self.SecurityData.removeObject(at: self.currentIndexPath)
                                self.self.SecurityData.insert(securityData, at: self.currentIndexPath)
                                
                                let indexPath = IndexPath(item: self.currentIndexPath, section: 0)
                                self.secuirtyCollection.reloadItems(at: [indexPath])
                                
                                self.showAlert(title: "Nirjara Ap", message: "Security Number Updated Succesfully")
                                
                                
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
        
        if(txtName.text == ""){
            self.view.makeToast("Please Enter Name", duration: 2.0, position: .top)
        }else if(!txtContactNo.text!.isPhone()){
            self.view.makeToast("Please Enter Correct Mobile No", duration: 2.0, position: .top)
        }
        else{
            
            let parameters = "contact_person_name=\(txtName.text!)&member_id=\(UserDefaults.standard.getUserID())&contact_no=\(txtContactNo.text!)"
            print("secuityr params",parameters)
            let url = URL(string:ServerUrl.post_security_number)!
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
                    print("security Response",json)
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "success")
                    {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
//                            self.showAlert(title: "Nirjara Ap", message: "Added Security Number")

                            
                            let alertController = JHTAlertController(title: "Success", message:"Added Security Number Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                                            self.SecurityData.removeAllObjects()
                                                            self.secuirtyCollection.reloadData()
                                                            self.getSecurityNumber()
                                
                
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.alert(message: "Nirjara Ap", title: "Something Went Wrong")
                            //self.alert(message: "Invalid Credential", title:"Nirjara Ap")
                        }
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
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
