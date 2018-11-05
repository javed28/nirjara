//
//  ContactUsCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/28/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import DropDown
import IQKeyboardManagerSwift

class ContactUsCntr: UIViewController {
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var lblAboutQuery: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtMessage: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
      let chooseArticleDropDown = DropDown()
    
    var queryName = ["Business","Suggestion","Advestisement","Jain GuruTracking","Vihar Stay","Temple and Sthanak","Tapasvi SukhSatha","Vrath Pachachakhan","Jain Mantras","Donation","Jain Library","Events","Active Samaj Seva","Chaturmas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Contact Us"
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:10,length:2))
        
        titleLabel.attributedText = myMutableString
        
        // titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        lblName.frame = CGRect(x:10,y:20,width:self.view.frame.width-20,height:25)
        txtName.frame = CGRect(x:10,y:lblName.frame.origin.y+lblName.frame.height+10,width:self.view.frame.width-20,height:50)
        lblMobile.frame = CGRect(x:10,y:txtName.frame.origin.y+txtName.frame.height+10,width:self.view.frame.width-20,height:25)
        txtMobile.frame = CGRect(x:10,y:lblMobile.frame.origin.y+lblMobile.frame.height+10,width:self.view.frame.width-20,height:50)
        lblAboutQuery.frame = CGRect(x:10,y:txtMobile.frame.origin.y+txtMobile.frame.height+10,width:self.view.frame.width-20,height:25)
        btnSelect.frame = CGRect(x:10,y:lblAboutQuery.frame.origin.y+lblAboutQuery.frame.height+10,width:self.view.frame.width-20,height:50)
        lblMessage.frame = CGRect(x:10,y:btnSelect.frame.origin.y+btnSelect.frame.height+10,width:self.view.frame.width-20,height:25)
        txtMessage.frame = CGRect(x:10,y:lblMessage.frame.origin.y+lblMessage.frame.height+10,width:self.view.frame.width-20,height:50)
        
        btnSubmit.frame = CGRect(x:10,y:txtMessage.frame.origin.y+txtMessage.frame.height+25,width:self.view.frame.width-20,height:50)
        
        btnSubmit.addTarget(self, action: #selector(addContactData), for: UIControlEvents.touchUpInside)
        sideMenuClicked()
        setupChooseArticleDropDown()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.chooseArticleDropDown.dataSource = queryName
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnQueryClicked(_ sender: Any) {
        chooseArticleDropDown.show()
    }
    
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnSelect
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnSelect.setTitle(item, for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenuClicked(){
        if revealViewController() != nil{
            sideMenu.target = revealViewController()
           
            sideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    @objc func addContactData(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtName.text! == ""){
            self.view.makeToast("Please Enter Name", duration: 2.0, position: .top)
        }
        else if(txtMobile.text == ""){
            self.view.makeToast("Please Enter Mobile Number", duration: 2.0, position: .top)
        }
        else if(btnSelect.currentTitle == "Select"){
            self.view.makeToast("Please Select Query", duration: 2.0, position: .top)
        }
        else if(txtMessage.text == ""){
            self.view.makeToast("Please Enter Message", duration: 2.0, position: .top)
        }
        
        else{

            
            let parameters = "member_name=\(txtName.text!)&member_id=\(UserDefaults.standard.getUserID())&contact_no=\(txtMobile.text!)&message=\(txtMessage.text!)&subject=\(btnSelect.currentTitle!)"
            
            
            let url = URL(string:ServerUrl.post_Enquiry)!
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
                            
                            
                            
                            let alertController = JHTAlertController(title: "Thank you", message:"Your Feedback Taken", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let gotoHome = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                                self.navigationController?.pushViewController(gotoHome!, animated: true)
                                
                                
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
