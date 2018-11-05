//
//  FamilyInfoCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
class FamilyInfoCntr: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    
    @IBOutlet weak var topView1: UIView!
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblFamilyDet: UILabel!
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topline: UIView!
    @IBOutlet weak var bottomline: UIView!
    
    @IBOutlet weak var lblFamilymember: UILabel!
    @IBOutlet weak var btnAddMember1: UIButton!
    @IBOutlet weak var btnAddmember2: UIButton!
    
    @IBOutlet weak var relationCollection: UICollectionView!
    
    var familyData = ["Father","Mother","Wife/Husband","Kid 1","Kid 2","Kid 3"]
    //var familyActualName = [GlobalVariables.fathers_name,GlobalVariables.mothers_name,GlobalVariables.wife_name,GlobalVariables.kids1_name,GlobalVariables.kids2_name,GlobalVariables.kids3_name]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Family & Relations"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:9))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        
        topView1.frame = CGRect(x:10,y:topbarHeight+8,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblFamilyDet.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView1.addSubview(imgLogo)
        topView1.addSubview(lblFamilyDet)
        topView1.layer.cornerRadius = 5
        
        topView.frame = CGRect(x:10,y:topView1.frame.origin.y+topView1.frame.height+10,width:self.view.frame.width-20,height:110)
        lblFamilymember.frame = CGRect(x:10,y:10,width:self.topView.frame.width-20,height:30)
        topline.frame = CGRect(x:10,y:lblFamilymember.frame.origin.y+lblFamilymember.frame.height+5,width:self.topView.frame.width-20,height:1)
        btnAddMember1.frame = CGRect(x:10,y:lblFamilymember.frame.origin.y+lblFamilymember.frame.height+8,width:50,height:50)
        btnAddmember2.frame = CGRect(x:75,y:lblFamilymember.frame.origin.y+lblFamilymember.frame.height+8,width:150,height:50)
        bottomline.frame = CGRect(x:10,y:btnAddmember2.frame.origin.y+btnAddmember2.frame.height+5,width:self.topView.frame.width-20,height:1)
        topView.addSubview(topline)
        topView.addSubview(lblFamilymember)
        topView.addSubview(btnAddMember1)
        topView.addSubview(btnAddmember2)
        topView.addSubview(bottomline)
        topView.layer.cornerRadius = 5
        topView.alpha = 1
        updateBackButton()
        
        relationCollection.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: relationCollection, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10))
        
        view.addConstraint(NSLayoutConstraint(item: relationCollection, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: relationCollection, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .top, multiplier: 1, constant: topView.frame.origin.y+topView1.frame.height))
        
        view.addConstraint(NSLayoutConstraint(item: relationCollection, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom,multiplier: 1, constant: -50))
        
        self.view.addSubview(relationCollection)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width
        
        return CGSize(width: collectionViewSize/2-5, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return familyData.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = relationCollection.dequeueReusableCell(withReuseIdentifier: "FamilyIdentifier", for: indexPath) as! FamilyCollectionCell
        
        if(indexPath.row == 0){
            if(GlobalVariables.fathers_name == ""){
                cell.lblName.text = "No Data"
            }else{
                cell.lblName.text = GlobalVariables.fathers_name
            }
            
        }else if(indexPath.row == 1){
            if(GlobalVariables.mothers_name == ""){
                cell.lblName.text = "No Data"
            }else{
                cell.lblName.text = GlobalVariables.mothers_name
            }
        }else if(indexPath.row == 2){
            if(GlobalVariables.wife_name == ""){
                cell.lblName.text = "No Data"
            }else{
                cell.lblName.text = GlobalVariables.wife_name
            }
        }else if(indexPath.row == 3){
            if(GlobalVariables.kids1_name == ""){
                cell.lblName.text = "No Data"
            }else{
                cell.lblName.text = GlobalVariables.kids1_name
            }
        }else if(indexPath.row == 4){
            if(GlobalVariables.kids2_name == "" ){
                cell.lblName.text = "No Data"
            }else{
                cell.lblName.text = GlobalVariables.kids2_name
            }
        }else if(indexPath.row == 5){
            if(GlobalVariables.kids3_name == ""){
                cell.lblName.text = "No Data"
            }else{
                cell.lblName.text = GlobalVariables.kids3_name
            }
        }
        
        
        //cell.lblRelation.setFAText(prefixText: "", icon: .FAUsers, postfixText: " "+familyData[indexPath.row], size: 15)
        cell.lblRelation.text = familyData[indexPath.row]
        cell.lblName?.frame = CGRect(x:65,y:10,width:self.relationCollection.frame.width,height:28)
        
        cell.lblRelation?.frame = CGRect(x:65,y:35,width:self.relationCollection.frame.width,height:28)
        cell.btnEdit?.frame = CGRect(x:15,y:15,width:50,height:50)
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(addFamilyAlert(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func addFamilyAlert(_ sender : UIButton) {
        
        
        var whichName = String()
        if(sender.tag == 0){
            
            whichName = "Father Name"
        }else if(sender.tag == 1){
            
            whichName = "Mother Name"
        }else if(sender.tag == 2){
           
            whichName = "Wife/Husban Name"
        }else if(sender.tag == 3){
            
            whichName = "Kid's 1 Name"
        }else if(sender.tag == 4){
           
            whichName = "Father Name"
        }else if(sender.tag == 5){
            
            whichName = "Kid's 3 Name"
        }
        
        let alertController = UIAlertController(title: "Add "+whichName, message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            
            if fNameField.text == "" {
                //self.view.makeToast("Please Enter Tap Count", duration: 2.0, position: .top)
                let errorAlert = UIAlertController(title: "Error", message: "Please Enter "+whichName, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
                // self.newUser = User(fn: fNameField.text!, ln: lNameField.text!)
                //TODO: Save user data in persistent storage - a tutorial for another time
            } else {
                if(sender.tag == 0){
                    self.updateFamilyData(which: "fathers_name",dataNew: fNameField.text!,position: sender.tag,whichUPdated: "Father Name")
                }else if(sender.tag == 1){
                    self.updateFamilyData(which: "mothers_name",dataNew: fNameField.text!,position: sender.tag,whichUPdated: "Mother Name")
                }else if(sender.tag == 2){
                    self.updateFamilyData(which: "wife_name",dataNew: fNameField.text!,position: sender.tag,whichUPdated: "Wife/Husband Name")
                }else if(sender.tag == 3){
                    self.updateFamilyData(which: "kids1_name",dataNew: fNameField.text!,position: sender.tag,whichUPdated: "Kid's 1 Name")
                }else if(sender.tag == 4){
                    self.updateFamilyData(which: "kids2_name",dataNew: fNameField.text!,position: sender.tag,whichUPdated: "Kid's 2 Name")
                }else if(sender.tag == 5){
                    self.updateFamilyData(which: "kids3_name",dataNew: fNameField.text!,position: sender.tag,whichUPdated: "Kid's 3 Name")
                }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder =  "Add "+whichName
            textField.textAlignment = .left
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func updateFamilyData(which : String,dataNew : String,position : Int,whichUPdated : String){
        if isConnectedToNetwork() {
            let parameters = "relation_type=\(which)&relation_name=\(dataNew)&member_id=\(UserDefaults.standard.getUserID())"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.update_user_family_members)!
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
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:whichUPdated+" Name updated Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                               
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                            if(position == 0){
                                GlobalVariables.fathers_name = dataNew
                            }else if(position == 1){
                                GlobalVariables.mothers_name = dataNew
                            }else if(position == 2){
                                GlobalVariables.wife_name = dataNew
                            }else if(position == 3){
                                GlobalVariables.kids1_name = dataNew
                            }else if(position == 4){
                                GlobalVariables.kids2_name = dataNew
                            }else if(position == 5){
                                GlobalVariables.kids3_name = dataNew
                            }
                            self.relationCollection.reloadData()
                            
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
