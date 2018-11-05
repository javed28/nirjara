//
//  mobilePurchaseCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/13/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import Toast_Swift
import JHTAlertController
import IQKeyboardManagerSwift
class mobilePurchaseCntr: UIViewController {

    
    
    @IBOutlet weak var lblBrand: UILabel!
   

    @IBOutlet weak var btnBrand: UIButton!
    @IBOutlet weak var lblModelName: UILabel!
   
    @IBOutlet weak var btnModelName: UIButton!
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var lblFrom: UILabel!
    
    @IBOutlet weak var txtFrom: UIButton!
    
    
    @IBOutlet weak var lblTo: UILabel!
    
    @IBOutlet weak var txtTo: UIButton!
    
    
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var txtContact: UITextField!
    
    @IBOutlet weak var btnSendEnquiry: UIButton!
    
    let chooseArticleDropDown = DropDown()
    let chooseSubBrand = DropDown()
    
    var brandId = [String]()
    var brandList = [String]()
    
    var mobile_model_id = [String]()
    var mobile_model_name = [String]()
    var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Mobile Purchase"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:9,length:8))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        lblBrand.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        btnBrand.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:50)
        lblBrand.text = "BRAND".localized1+" "+"Name".localized1
        lblModelName.frame = CGRect(x:10,y:100,width:self.view.frame.width-20,height:25)
        btnModelName.frame = CGRect(x:10,y:130,width:self.view.frame.width-20,height:50)
        lblModelName.text = "ModelName".localized1
        lblCity.frame = CGRect(x:10,y:190,width:self.view.frame.width-20,height:25)
        txtCity.frame = CGRect(x:10,y:220,width:self.view.frame.width-20,height:50)
        lblCity.text = "City".localized1
        txtCity.placeholder = "City".localized1
        lblFrom.frame = CGRect(x:10,y:280,width:self.view.frame.width-20,height:25)
        txtFrom.frame = CGRect(x:10,y:310,width:self.view.frame.width-20,height:50)
        lblFrom.text = "From".localized1
        lblTo.frame = CGRect(x:10,y:370,width:self.view.frame.width-20,height:25)
        txtTo.frame = CGRect(x:10,y:400,width:self.view.frame.width-20,height:50)
        lblTo.text = "To".localized1
        lblContact.frame = CGRect(x:10,y:460,width:self.view.frame.width-20,height:25)
        txtContact.frame = CGRect(x:10,y:490,width:self.view.frame.width-20,height:50)
        lblContact.text = "Contact".localized1
        txtContact.placeholder = "Contact".localized1
        
        btnSendEnquiry.frame = CGRect(x:10,y:560,width:self.view.frame.width-20,height:50)
        btnSendEnquiry.addTarget(self, action: #selector(AddMobileEnquiry), for: UIControlEvents.touchUpInside)
        btnSendEnquiry.setTitle("SendEnquiry".localized1, for: .normal)
        // Do any additional setup after loading the view.
        getModileBRand()
        setupChooseArticleDropDown()
        setUpSubBrand()
        
        
        txtFrom.addTarget(self, action: #selector(btnDateFromClicked(_:)), for: UIControlEvents.touchUpInside)
        txtTo.addTarget(self, action: #selector(btnDateToClicked(_:)), for: UIControlEvents.touchUpInside)
        
       
         containerController = revealViewController().frontViewController as? ContainerViewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func btnDateFromClicked(_ sender: UIButton) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "mobilePurchaseFrom"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    @objc func btnDateToClicked(_ sender: UIButton) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "mobilePurchaseTo"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        txtFrom.setTitle(GlobalVariables.selectedMobileFrom, for:.normal)
        txtTo.setTitle(GlobalVariables.selectedMobileTo, for:.normal)
    }
   
    
    
    @objc func AddMobileEnquiry(_ sender : UIButton){
        if isConnectedToNetwork() {
        if( btnBrand.currentTitle == "Select"){
            self.view.makeToast("Please Select Brand", duration: 2.0, position: .center)
        }else if(btnModelName.currentTitle == "Select"){
            self.view.makeToast("Please Select Sub Brand", duration: 2.0, position: .center)
        }
        else if(txtCity.text == ""){
            self.view.makeToast("Please Enter City", duration: 2.0, position: .top)
        }
//        else if(txtContact.text == ""){
//            self.view.makeToast("Please Enter Mobile No", duration: 2.0, position: .top)
//        }else if(txtContact.text?.isPhone())!{
//            self.view.makeToast("Please Enter Correct Mobile No", duration: 2.0, position: .top)
//        }
        else if(self.stringToDate(takeDate: GlobalVariables.selectedMobileFrom) > (self.stringToDate(takeDate: GlobalVariables.selectedMobileTo))){
            self.view.makeToast("To Date should be more than current date", duration: 3.0, position: .top)
        }
        else{

           
              let indexofBrand  =  brandList.index(of: btnBrand.currentTitle!)
              let brandIdSel  = brandId[indexofBrand!]
              let indexofdesName = mobile_model_name.index(of: btnModelName.currentTitle!)
              let modileIdSel  = mobile_model_id[indexofdesName!]
            var contact = String()
            if(txtContact.text == ""){
                contact = ""
            }else{
                contact = txtContact.text!
            }
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let second = calendar.component(.second, from: date)
            let finalTime =  String(hour)  + ":" + String(minute) + ":" +  String(second)
            
            let parameters = "mobile_brand=\(brandIdSel)&mobile_model=\(modileIdSel)&member_id=\(UserDefaults.standard.getUserID())&city=\(txtCity.text!)&from_date=\(dateToString(dateString: GlobalVariables.selectedMobileFrom, fromFormat: "dd-MM-yyyy", toFormat: "YYYY-MM-dd")+" "+finalTime)&to_date=\(dateToString(dateString: GlobalVariables.selectedMobileTo, fromFormat: "dd-MM-yyyy", toFormat: "YYYY-MM-dd")+" "+finalTime)&contact_no=\(contact)&message=Done&member_name=\(UserDefaults.standard.getMemberName())"
            
           
            let url = URL(string:ServerUrl.post_mobile_url)!
        
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
                            //self.showAlert(title: "Well Done", message: "Your Enquiry was send Successfuly")
                            
                            let alertController = JHTAlertController(title: "Success", message:"Your Enquiry was send Successfully", preferredStyle: .alert)
                            
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
                            self.showAlert(title: "Something Went Wrong", message: "Nirjara Ap")
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
    
    @IBAction func btnBrandClicked(_ sender: Any) {
        chooseArticleDropDown.show()
    }
    
    @IBAction func btnSubBRandClicked(_ sender: Any) {
        chooseSubBrand.show()
    }
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnBrand
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnBrand.setTitle(item, for: .normal)
            //let data : [String] =  [self!.brandId[index]]
           // self?.chooseSubBrand.dataSource = data
            self?.mobile_model_id.removeAll()
            self?.mobile_model_name.removeAll()
            self?.getModileSubBrand(Id: self!.brandId[index])
            self?.btnModelName.setTitle("Select", for: .normal)
        }
    }
    
    func setUpSubBrand() {
        chooseSubBrand.anchorView = btnModelName
        chooseSubBrand.selectionAction = { [weak self] (index, item) in
            self?.btnModelName.setTitle(item, for: .normal)
        }
    }
    
    func getModileBRand(){
        let parameters = "lang=en"
        let url = URL(string:ServerUrl.get_mobile_brand)!
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
                        self.brandId.append((jsonObject?.object(forKey: "mobile_brand_id") as? String)!)
                        self.brandList.append((jsonObject?.object(forKey: "mobile_brand_name") as? String)!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseArticleDropDown.dataSource = self.brandList
                        
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
    func getModileSubBrand(Id : String){
        let parameters = "key=model&mobile_brand_id=\(Id)"
        let url = URL(string:ServerUrl.get_mobile_brand)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        self.showActivityIndicator()
        print("mobile purchase param----",parameters)
        print("mobile purchase url----",url)
        
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
                        self.mobile_model_id.append((jsonObject?.object(forKey: "mobile_model_id") as? String)!)
                        self.mobile_model_name.append((jsonObject?.object(forKey: "mobile_model_name") as? String)!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                   self.chooseSubBrand.dataSource = self.mobile_model_name
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
