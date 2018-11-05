//
//  InternationalHolidayCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/13/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import JHTAlertController
import IQKeyboardManagerSwift

class InternationalHolidayCntr: UIViewController,SSRadioButtonControllerDelegate {
    
   
    @IBOutlet weak var btnDestination: UIButton!
    @IBOutlet weak var lblDest: UILabel!
    @IBOutlet weak var lblWhen: UILabel!
    @IBOutlet weak var lblHowmany: UILabel!
    @IBOutlet weak var txtHowMany: UITextField!
    @IBOutlet weak var lblNoOfDay: UILabel!
    @IBOutlet weak var txtNoOfDay: UITextField!
    @IBOutlet weak var txtWhen: UIButton!
    @IBOutlet weak var lblFood: UILabel!
    var foodRadioButton: SSRadioButtonsController?
    @IBOutlet weak var btnJain: SSRadioButton!
    @IBOutlet weak var btnNormal: SSRadioButton!
    
    let chooseArticleDropDown = DropDown()
    
    var destinationList = [String]()
    var destinationId = [String]()
    var containerController: ContainerViewController?
    @IBOutlet weak var btnSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  International Holiday's"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:16))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:16,length:9))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        foodRadioButton = SSRadioButtonsController(buttons: btnNormal, btnJain)
        foodRadioButton!.delegate = self
        foodRadioButton!.shouldLetDeSelect = true
        
        
        lblDest.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        btnDestination.frame = CGRect(x:10,y:40,width:self.view.frame.width-20,height:50)
        lblDest.text = "Destination".localized1
        
        lblWhen.frame = CGRect(x:10,y:100,width:self.view.frame.width-20,height:25)
        txtWhen.frame = CGRect(x:10,y:130,width:self.view.frame.width-20,height:50)
        lblWhen.text = "When".localized1
        lblHowmany.frame = CGRect(x:10,y:190,width:self.view.frame.width-20,height:25)
        txtHowMany.frame = CGRect(x:10,y:220,width:self.view.frame.width-20,height:50)
        lblHowmany.text = "HowManyPeople".localized1
        txtHowMany.placeholder = "HowManyPeople".localized1
        lblNoOfDay.frame = CGRect(x:10,y:280,width:self.view.frame.width-20,height:25)
        txtNoOfDay.frame = CGRect(x:10,y:310,width:self.view.frame.width-20,height:50)
        lblNoOfDay.text = "NoofDays".localized1
        txtNoOfDay.placeholder = "NoofDays".localized1
        lblFood.frame = CGRect(x:10,y:370,width:self.view.frame.width-20,height:25)
        lblFood.text = "TypeRequiredFood".localized1
        btnJain.frame = CGRect(x:10,y:400,width:self.view.frame.width/2-20,height:50)
        btnJain.setTitle("JainFood".localized1, for: .normal)
        btnNormal.frame = CGRect(x:self.view.frame.width/2-10,y:400,width:self.view.frame.width/2-20,height:50)
         btnNormal.setTitle("Normal".localized1, for: .normal)
        btnSave.frame = CGRect(x:10,y:475,width:self.view.frame.width-20,height:50)
        btnSave.setTitle("Save".localized1, for: .normal)
        btnSave.addTarget(self, action: #selector(AddHoliday), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
        getDestination()
        setupChooseArticleDropDown()
        
        
        txtWhen.addTarget(self, action: #selector(btnDateClicked(_:)), for: UIControlEvents.touchUpInside)
        
       containerController = revealViewController().frontViewController as? ContainerViewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtWhen.setTitle(GlobalVariables.selectedHolidayDateFrom, for: .normal)
    }
    
    @objc func btnDateClicked(_ sender: UIButton) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "internationalHoliday"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    

    
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = btnDestination
        chooseArticleDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnDestination.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnDestinationclicked(_ sender: Any) {
        chooseArticleDropDown.show()
    }
    
    
    @objc func AddHoliday(_ sender : UIButton){
         if isConnectedToNetwork() {
        if(btnDestination.currentTitle == "Select"){
            self.view.makeToast("Please Select Destination", duration: 2.0, position: .top)
        }
        else if(txtHowMany.text == ""){
            self.view.makeToast("Please Enter How many People", duration: 2.0, position: .top)
        }
        else if(txtNoOfDay.text == ""){
            self.view.makeToast("Please Enter No. of Days", duration: 2.0, position: .top)
        }
        else if(foodRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Food", duration: 2.0, position: .top)
        }
        
        else{
        
            var foodData = String()
            if(foodRadioButton?.selectedButton()?.currentTitle == ""){
                foodData = ""
            }else{
                foodData = (foodRadioButton?.selectedButton()?.currentTitle)!
            }
            
            var destinationselectId : String = "0"
            if( btnDestination.currentTitle == "Select"){
            }else{
                let indexofdesName = destinationList.index(of: btnDestination.currentTitle!)
                    destinationselectId  = destinationId[indexofdesName!]
            }
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let second = calendar.component(.second, from: date)
            let finalTime =  String(hour)  + ":" + String(minute) + ":" +  String(second)
            
            let parameters = "destination_id=\(destinationselectId)&member_id=\(UserDefaults.standard.getUserID())&when=\(dateToString(dateString: GlobalVariables.selectedHolidayDateFrom, fromFormat: "dd-MM-yyyy", toFormat: "YYYY-MM-dd")+" "+finalTime)&how_many_people=\(txtHowMany.text!)&no_of_days=\(txtNoOfDay.text!)&food_preference=\(foodData)&member_name=\(UserDefaults.standard.getMemberName())"
                print("sending inter",parameters)
            
                    let url = URL(string:ServerUrl.post_holiday_url)!
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
    
    func getDestination(){
        let parameters = "lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_holiday_destination)!
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
                        self.destinationId.append((jsonObject?.object(forKey: "destination_id") as? String)!)
                        self.destinationList.append((jsonObject?.object(forKey: "destination") as? String)!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseArticleDropDown.dataSource = self.destinationList
                        
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
    func didSelectButton(selectedButton: UIButton?) {
        print(selectedButton)
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
