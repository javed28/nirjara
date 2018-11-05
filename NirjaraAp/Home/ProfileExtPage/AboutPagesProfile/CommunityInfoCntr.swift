//
//  CommunityInfoCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import JHTAlertController
class CommunityInfoCntr: UIViewController {

    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblBankText: UILabel!
    
    @IBOutlet weak var btnReligion: UIButton!
    @IBOutlet weak var btnSampradhay: UIButton!
    @IBOutlet weak var btnSubgroup: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    var containerController: ContainerViewController?
    
    let chooseReligion = DropDown()
    let chooseSampradhay = DropDown()
    let chooseSubGroup = DropDown()
    var items = [[String : String]]()
    var sampradhayData = ["Sthanakwasi".localized1,"Murtipujak".localized1,"Terapanthi".localized1,"Digambar".localized1,"Only "+"Jain".localized1+" (Open for All)"]
    var religionData = ["Jain".localized1,"Other".localized1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Community Information"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:12))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:12,length:11))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        updateBackButton()
        
        topView.frame = CGRect(x:10,y:topbarHeight+8,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblBankText.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView.addSubview(imgLogo)
        topView.layer.cornerRadius = 5
        topView.addSubview(lblBankText)
        btnReligion.frame = CGRect(x:10,y:topView.frame.origin.y+topView.frame.height+12,width:self.view.frame.width-20,height:50)
        btnSampradhay.frame = CGRect(x:10,y:btnReligion.frame.origin.y+btnReligion.frame.height+12,width:self.view.frame.width-20,height:50)
        btnSubgroup.frame = CGRect(x:10,y:btnSampradhay.frame.origin.y+btnSampradhay.frame.height+12,width:self.view.frame.width-20,height:50)
        btnSubmit.frame = CGRect(x:10,y:btnSubgroup.frame.origin.y+btnSubgroup.frame.height+25,width:self.view.frame.width-20,height:50)
        btnSubmit.layer.cornerRadius = 5
        btnReligion.layer.cornerRadius = 5
        btnSampradhay.layer.cornerRadius = 5
        btnSubgroup.layer.cornerRadius = 5
        
        btnSubmit.setTitle("Submit".localized1, for: .normal)
        btnSubmit.addTarget(self, action: #selector(updateReligion(_:)), for: .touchUpInside)
       
    
        if(GlobalVariables.religion == ""){
             btnReligion.setTitle("Religion".localized1, for: .normal)
        }else{
             btnReligion.setTitle(GlobalVariables.religion, for: .normal)
        }
        if(GlobalVariables.main_group_name == ""){
            btnSampradhay.setTitle("Sampraday".localized1, for: .normal)
        }else{
            btnSampradhay.setTitle(GlobalVariables.main_group_name, for: .normal)
        }
        
        if(GlobalVariables.sub_group_name == ""){
            btnSubgroup.setTitle("SubGroup".localized1, for: .normal)
        }else{
            btnSubgroup.setTitle(GlobalVariables.sub_group_name, for: .normal)
        }
        
        // Do any additional setup after loading the view.
        setupChooseSampradhay()
        setupChooseReligion()
        setupChooseSubGroup()
        getSubGroupData()
        containerController = revealViewController().frontViewController as? ContainerViewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func updateReligion(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(btnReligion.currentTitle == "Religion"){
            self.view.makeToast("Please Select Religion", duration: 2.0, position: .top)
        }else if(btnSampradhay.currentTitle == "Select"){
            self.view.makeToast("Please Select Sampradhay", duration: 2.0, position: .top)
        }else if(btnSubgroup.currentTitle == "Sub Group"){
            self.view.makeToast("Please Select Subgroup", duration: 2.0, position: .top)
        }
        else{
            
            var mainGroup : Int = 0
            var subGroupId : String = "0"
            if(btnSampradhay.currentTitle == "Sthanakwasi".localized1){
                mainGroup = 0
            }else if(btnSampradhay.currentTitle == "Murtipujak".localized1){
                mainGroup = 1
            }else  if(btnSampradhay.currentTitle == "Digambar".localized1){
                mainGroup = 2
            }else if(btnSampradhay.currentTitle == "Terapanthi".localized1){
                mainGroup = 3
            }else if(btnSampradhay.currentTitle == "Only "+"Jain".localized1+" (Open for All)"){
                mainGroup = 4
            }
            
            if(btnSubgroup.currentTitle == "Select"){
                
            }else{
                for (name, path) in items[mainGroup] {
                    if(path == btnSubgroup.currentTitle){
                        subGroupId = name
                    }
                }
            }
            
            if(mainGroup == 0){
                mainGroup = 1
            }else if(mainGroup == 1){
                mainGroup = 2
            }
            else if(mainGroup == 2){
                mainGroup = 3
            }
            else if(mainGroup == 3){
                mainGroup = 4
            }
            else if(mainGroup == 4){
                mainGroup = 5
            }
            
            let parameters = "religion=\(btnReligion.currentTitle!)&member_id=\(UserDefaults.standard.getUserID())&main_group_id=\(mainGroup)&sub_group_id=\(subGroupId)"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.update_community)!
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
                           GlobalVariables.religion =  self.btnReligion.currentTitle!
                            GlobalVariables.main_group_name =  self.btnSampradhay.currentTitle!
                            GlobalVariables.sub_group_name =  self.btnSubgroup.currentTitle!
                            self.hideActivityIndicator()
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:"Community data Updated", preferredStyle: .alert)
                            
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

    
    @IBAction func btnReligionClk(_ sender: Any) {
        chooseReligion.show()
    }
    
    
    @IBAction func btnSampradhayClk(_ sender: Any) {
        chooseSampradhay.show()
    }
    
    @IBAction func btnSubgroupClk(_ sender: Any) {
        chooseSubGroup.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupChooseReligion() {
        chooseReligion.dataSource = religionData
        chooseReligion.anchorView = btnReligion
        chooseReligion.selectionAction = { [weak self] (index, item) in
            self?.btnReligion.setTitle(item, for: .normal)
        }
    }
    
    func setupChooseSampradhay() {
        chooseSampradhay.dataSource = sampradhayData
        chooseSampradhay.anchorView = btnSampradhay
        chooseSampradhay.selectionAction = { [weak self] (index, item) in
            self?.btnSampradhay.setTitle(item, for: .normal)
            if(self?.items == nil){
                
            }else{
            var dropDownData = [String]()
            for (name, path) in (self?.items[index])! {
                dropDownData.append(path)
            }
            self?.chooseSubGroup.dataSource = dropDownData
            self?.btnSubgroup.setTitle("SubGroup".localized1, for: .normal)
            }
        }
    }
    func setupChooseSubGroup() {
       
        chooseSubGroup.anchorView = btnSubgroup
        chooseSubGroup.selectionAction = { [weak self] (index, item) in
            self?.btnSubgroup.setTitle(item, for: .normal)
            
        }
    }
    
    
    func getSubGroupData(){
        
        let parameters = "lang=\(UserDefaults.standard.getLanguage())"
        let url = URL(string:ServerUrl.get_guru_data)!
        
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
                    
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var subgroupDa : [String : String]  = [:]
                        let sub_group_data = jsonObject?.object(forKey: "sub_group_data") as? [NSDictionary]
                        for j in 0..<sub_group_data!.count{
                            let subGroupData = sub_group_data?[j]
                            let sub_group_name = (subGroupData?.object(forKey: "sub_group_name") as? String)?.capitalized
                            let sub_group_id = subGroupData?.object(forKey: "sub_group_id") as? String
                            subgroupDa.updateValue(sub_group_name!, forKey: sub_group_id!)
                        }
                        self.items.append(subgroupDa)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
