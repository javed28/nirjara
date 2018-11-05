//
//  jewellaryPurchaseCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/13/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import IQKeyboardManagerSwift

class jewellaryPurchaseCntr: UIViewController,SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var lblJewellery: UILabel!
    var jewelleryRadioButton: SSRadioButtonsController?
    @IBOutlet weak var btnGold: SSRadioButton!
    @IBOutlet weak var btnDiamond: SSRadioButton!
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var txtQty: UITextField!
    
    @IBOutlet weak var lblBillion: UILabel!
    @IBOutlet weak var txtBillion: UITextField!
    
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var txtBudget: UITextField!
    
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    
    
    @IBOutlet weak var lblFrom: UILabel!
   
    @IBOutlet weak var txtFrom: UIButton!
    
   
    
    @IBOutlet weak var lblTo: UILabel!
   
    @IBOutlet weak var txtTo: UIButton!
    
    
    @IBOutlet weak var btnSendEnquiry: UIButton!
    var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jewellery Purchase"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:12))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:12,length:8))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        jewelleryRadioButton = SSRadioButtonsController(buttons: btnGold, btnDiamond)
        jewelleryRadioButton!.delegate = self
        jewelleryRadioButton!.shouldLetDeSelect = true
        
        lblJewellery.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        btnGold.frame = CGRect(x:10,y:40,width:self.view.frame.width/2-20,height:50)
        btnDiamond.frame = CGRect(x:self.view.frame.width/2-10,y:40,width:self.view.frame.width/2-20,height:50)
        
        lblJewellery.text = "Jewellery".localized1
        btnGold.setTitle("Gold".localized1, for: .normal)
        btnDiamond.setTitle("Diamond".localized1, for: .normal)
        lblQty.frame = CGRect(x:10,y:100,width:self.view.frame.width-20,height:25)
        txtQty.frame = CGRect(x:10,y:130,width:self.view.frame.width-20,height:50)
        lblQty.text = "Quantity".localized1
        txtQty.placeholder = "Quantity".localized1
        lblBillion.frame = CGRect(x:10,y:190,width:self.view.frame.width-20,height:25)
        txtBillion.frame = CGRect(x:10,y:220,width:self.view.frame.width-20,height:50)
        lblBillion.text = "Bullion".localized1
        txtBillion.placeholder = "Bullion".localized1
        lblBudget.frame = CGRect(x:10,y:280,width:self.view.frame.width-20,height:25)
        txtBudget.frame = CGRect(x:10,y:310,width:self.view.frame.width-20,height:50)
        lblBudget.text = "Budget".localized1
        lblCity.frame = CGRect(x:10,y:370,width:self.view.frame.width-20,height:25)
        txtCity.frame = CGRect(x:10,y:400,width:self.view.frame.width-20,height:50)
        lblCity.text = "City".localized1
        txtCity.placeholder = "City".localized1
        lblFrom.frame = CGRect(x:10,y:460,width:self.view.frame.width-20,height:25)
        txtFrom.frame = CGRect(x:10,y:490,width:self.view.frame.width-20,height:50)
        lblFrom.text = "From".localized1
        lblTo.frame = CGRect(x:10,y:560,width:self.view.frame.width-20,height:25)
        txtTo.frame = CGRect(x:10,y:590,width:self.view.frame.width-20,height:50)
        lblTo.text = "To".localized1
        
        btnSendEnquiry.frame = CGRect(x:10,y:660,width:self.view.frame.width-20,height:50)
        btnSendEnquiry.addTarget(self, action: #selector(AddJewelleryEnquiry), for: UIControlEvents.touchUpInside)
        btnSendEnquiry.setTitle("SendEnquiry".localized1, for: .normal)
        // Do any additional setup after loading the view.
        
        containerController = revealViewController().frontViewController as? ContainerViewController
        
        txtFrom.addTarget(self, action: #selector(btnDateFromClicked(_:)), for: UIControlEvents.touchUpInside)
        txtTo.addTarget(self, action: #selector(btnDateToClicked(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func btnDateFromClicked(_ sender: UIButton) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "jewelleryPurchaseFrom"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    @objc func btnDateToClicked(_ sender: UIButton) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "jewelleryPurchaseTo"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        txtFrom.setTitle(GlobalVariables.selectedJewerallyFrom, for:.normal)
        txtTo.setTitle(GlobalVariables.selectedJewerallyTo, for:.normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        print(selectedButton)
    }
    
   
    @objc func AddJewelleryEnquiry(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(jewelleryRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Jeqellery Type", duration: 2.0, position: .top)
        }
        else if(txtQty.text! == ""){
            self.view.makeToast("Please Enter Quantity", duration: 2.0, position: .top)
        }
        else if(txtBillion.text! == ""){
            self.view.makeToast("Please Enter Billion", duration: 2.0, position: .top)
        }
        else if(txtBudget.text! == ""){
            self.view.makeToast("Please Enter Budget", duration: 2.0, position: .top)
        }
        else if(txtCity.text! == ""){
            self.view.makeToast("Please Enter City", duration: 2.0, position: .top)
        }
        else if(self.stringToDate(takeDate: GlobalVariables.selectedJewerallyFrom) > (self.stringToDate(takeDate: GlobalVariables.selectedJewerallyTo))){
            self.view.makeToast("To Date should be more than current date", duration: 3.0, position: .top)
        }
        else{
 
          
            
            var jewelData = String()
            if(jewelleryRadioButton?.selectedButton()?.currentTitle == ""){
                jewelData = ""
            }else{
                jewelData = (jewelleryRadioButton?.selectedButton()?.currentTitle)!
            }
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let second = calendar.component(.second, from: date)
            let finalTime =  String(hour)  + ":" + String(minute) + ":" +  String(second)
            
            
            let parameters = "jwellery_type=\(jewelData)&member_id=\(UserDefaults.standard.getUserID())&city=\(txtCity.text!)&from_date=\(dateToString(dateString: GlobalVariables.selectedJewerallyFrom, fromFormat: "dd-MM-yyyy", toFormat: "YYYY-MM-dd")+" "+finalTime)&to_date=\(dateToString(dateString: GlobalVariables.selectedJewerallyTo, fromFormat: "dd-MM-yyyy", toFormat: "YYYY-MM-dd")+" "+finalTime)&budget=\(txtBudget.text!)&message=Testing&quantity=\(txtQty.text!)&bullion=\(txtBillion.text!)"
            
           
            let url = URL(string:ServerUrl.post_jewellery_url)!
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
