//
//  EditBusinessViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import JHTAlertController
import IQKeyboardManagerSwift
class EditBusinessViewCntr: UIViewController {

    
    var business_cat_id = [String]()
    var business_category = [String]()
    
    let chooseArticleDropDown = DropDown()
    
    @IBOutlet weak var lblPackage: UILabel!
    @IBOutlet weak var txtPackage: UITextField!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    
 
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblBusinessCat: UILabel!
    @IBOutlet weak var btnBusinessCat: UIButton!
    
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var txtProduct: UITextField!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txtTitle: UITextField!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    var businessData = MyPostModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Edit Business Information"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:16))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:16,length:11))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        // Do any additional setup after loading the view.
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        
        lblPackage.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        txtPackage.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:50)
        txtPackage.text = businessData.package_name
        lblPackage.text = "Package".localized1
        txtPackage.placeholder = "Package".localized1
        
        lblBusinessCat.frame = CGRect(x:10,y:txtPackage.frame.origin.y+txtPackage.frame.height+10,width:self.view.frame.width-20,height:25)
        btnBusinessCat.frame = CGRect(x:10,y:lblBusinessCat.frame.origin.y+lblBusinessCat.frame.height+10,width:self.view.frame.width-20,height:50)
        lblBusinessCat.text = "BusinessCategory".localized1
        
        lblTitle.frame = CGRect(x:10,y:btnBusinessCat.frame.origin.y+btnBusinessCat.frame.height+10,width:self.view.frame.width-20,height:25)
        txtTitle.frame = CGRect(x:10,y:lblTitle.frame.origin.y+lblTitle.frame.height+10,width:self.view.frame.width-20,height:50)
        txtTitle.text = businessData.business_title
        lblTitle.text = "Title".localized1
        txtTitle.placeholder = "Title".localized1
        
        lblProduct.frame = CGRect(x:10,y:txtTitle.frame.origin.y+txtTitle.frame.height+10,width:self.view.frame.width-20,height:25)
        txtProduct.frame = CGRect(x:10,y:lblProduct.frame.origin.y+lblProduct.frame.height+10,width:self.view.frame.width-20,height:50)
        txtProduct.text = businessData.product1
        lblProduct.text = "Products".localized1
        txtProduct.placeholder = "Products".localized1
        
        lblName.frame = CGRect(x:10,y:txtProduct.frame.origin.y+txtProduct.frame.height+10,width:self.view.frame.width-20,height:25)
        txtName.frame = CGRect(x:10,y:lblName.frame.origin.y+lblName.frame.height+10,width:self.view.frame.width-20,height:50)
        txtName.text = businessData.business_owner_name
        lblName.text = "Name".localized1
        txtName.placeholder = "Name".localized1
        
        lblAddress.frame = CGRect(x:10,y:txtName.frame.origin.y+txtName.frame.height+10,width:self.view.frame.width-20,height:25)
        txtAddress.frame = CGRect(x:10,y:lblAddress.frame.origin.y+lblAddress.frame.height+10,width:self.view.frame.width-20,height:50)
        txtAddress.text = businessData.address
        lblAddress.text = "Address".localized1
        txtAddress.placeholder = "Address".localized1
        
        lblEmail.frame = CGRect(x:10,y:txtAddress.frame.origin.y+txtAddress.frame.height+10,width:self.view.frame.width-20,height:25)
        txtEmail.frame = CGRect(x:10,y:lblEmail.frame.origin.y+lblEmail.frame.height+10,width:self.view.frame.width-20,height:50)
        txtEmail.text = businessData.email_id
        lblEmail.text = "Email".localized1
        txtEmail.placeholder = "Email".localized1
        
        lblPhone.frame = CGRect(x:10,y:txtEmail.frame.origin.y+txtEmail.frame.height+10,width:self.view.frame.width-20,height:25)
        txtPhone.frame = CGRect(x:10,y:lblPhone.frame.origin.y+lblPhone.frame.height+10,width:self.view.frame.width-20,height:50)
        txtPhone.text = businessData.contact_no
        lblPhone.text = "Phone".localized1
        txtPhone.placeholder = "Phone".localized1
        
        
        btnSubmit.frame = CGRect(x:10,y:txtPhone.frame.origin.y+txtPhone.frame.height+25,width:self.view.frame.width-20,height:50)
        btnSubmit.setTitle("Submit".localized1, for: .normal)
       btnSubmit.addTarget(self, action: #selector(editBusiness), for: UIControlEvents.touchUpInside)
        
        
        
        getBusinessCategory()
        setupChooseArticleDropDown()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func btnCategoryClicked(_ sender: Any) {
          chooseArticleDropDown.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @objc func editBusiness(_ sender : UIButton){
        
        if(btnBusinessCat.currentTitle == "Select"){
            self.view.makeToast("Please Select Business Category", duration: 2.0, position: .top)
        }
        else if(txtTitle.text == ""){
            self.view.makeToast("Please Enter Business Title", duration: 2.0, position: .top)
        }
        else if(txtProduct.text == ""){
            self.view.makeToast("Please Enter Product Name", duration: 2.0, position: .top)
        }
        else if(txtName.text == ""){
            self.view.makeToast("Please enter Contact Persone name", duration: 2.0, position: .top)
        }
        else if(txtAddress.text == ""){
            self.view.makeToast("Please Enter Address", duration: 2.0, position: .top)
        }
        else if(txtEmail.text == ""){
            self.view.makeToast("Please Enter Email", duration: 2.0, position: .top)
        }
        else if(txtPhone.text == ""){
            self.view.makeToast("Please Enter Mobile No", duration: 2.0, position: .top)
        }
        
            
        else{
            
            var businesSelectId : String = "0"
            if(btnBusinessCat.currentTitle == "Select"){
            }else{
                let indexofdesName = business_category.index(of: btnBusinessCat.currentTitle!)
                businesSelectId  = business_cat_id[indexofdesName!]
            }
           

            let title = btnBusinessCat.currentTitle!
            
            let parameters = "member_id=\(UserDefaults.standard.getUserID())&business_owner_name=\(txtName.text!)&contact_no=\(txtPhone.text!)&business_title=\(title)&business_description=\(businessData.business_description!)&member_name=\(UserDefaults.standard.getMemberName())&address=\(txtAddress.text!)&email_id=\(txtEmail.text!)&product1=\(txtProduct.text!)&business_cat_id=\(businessData.business_cat_id!)&package_id=\(businessData.package_id!)&business_id=\(businessData.business_id!)"
            
            
            let url = URL(string:ServerUrl.edit_my_business)!
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
                            
                           
                            //  let last_inserted_id = json?.object(forKey: "last_inserted_id") as? String;
                            
                            self.hideActivityIndicator()
                            // self.showAlert(title: "Well Done", message: "Your Business Added Successfuly Proceed to Payment")
                            
                            
                            let alertController = JHTAlertController(title: "Well Done", message:"Your Business Updated Successfuly", preferredStyle: .alert)
                            
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
    }
    
    
    
    func getBusinessCategory(){
        
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_business_cat)!
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
                        
                        
                        let busCatId = jsonObject?.object(forKey: "business_cat_id") as? String
                        let busCatName = jsonObject?.object(forKey: "business_category") as? String
                        
                        
                        self.business_cat_id.append(busCatId!)
                        self.business_category.append(busCatName!)
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseArticleDropDown.dataSource = self.business_category
                        
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
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnBusinessCat
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnBusinessCat.setTitle(item, for: .normal)
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
