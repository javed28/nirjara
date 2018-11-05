



//
//  UpdateCityState1Cntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/19/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
import JHTAlertController
class UpdateCityState1Cntr: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var btnState: UIButton!
    
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    //var stateName = [String]()
    //var stateId = [String]()
    
    var cityId = [String]()
    var cityName = [String]()
    
    var stateIdSelected = String()
    var cityIdSelected = String()
    var stateNameSel = String()
    var cityNameSel = String()
    
    let chooseState = DropDown()
    let chooseCity = DropDown()
    var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Update State & city"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:15))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:15,length:6))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        updateBackButton()
         containerController = revealViewController().frontViewController as? ContainerViewController
        
        
        topView.frame = CGRect(x:10,y:topbarHeight+10,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblText.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView.addSubview(imgLogo)
        topView.layer.cornerRadius = 5
        topView.addSubview(lblText)
        
        lblState.frame = CGRect(x:10,y:topView.frame.origin.y+topView.frame.height+10,width:self.view.frame.width-20,height:25)
        btnState.frame = CGRect(x:10,y:lblState.frame.origin.y+lblState.frame.height+5,width:self.view.frame.width-20,height:40)
        lblCity.frame = CGRect(x:10,y:btnState.frame.origin.y+btnState.frame.height+10,width:self.view.frame.width-20,height:25)
        btnCity.frame = CGRect(x:10,y:lblCity.frame.origin.y+lblCity.frame.height+5,width:self.view.frame.width-20,height:40)
        btnSubmit.frame = CGRect(x:10,y:btnCity.frame.origin.y+btnCity.frame.height+25,width:self.view.frame.width-20,height:50)
        
        btnSubmit.layer.cornerRadius = 5
        btnState.layer.cornerRadius = 5
        btnCity.layer.cornerRadius = 5
        
        
        if(GlobalVariables.member_city == ""){
             btnState.setTitle("State".localized1, for: .normal)
        }else{
            btnCity.setTitle(GlobalVariables.member_city, for: .normal)
        }
        if(GlobalVariables.state == ""){
            btnCity.setTitle("City".localized1, for: .normal)
        }else{
            btnState.setTitle(GlobalVariables.state, for: .normal)
        }
        
        lblState.text = "State".localized1
        lblCity.text = "City".localized1
        btnSubmit.setTitle("Submit".localized1, for: .normal)
        btnSubmit.addTarget(self, action: #selector(updateState(_:)), for: .touchUpInside)
       
        
        setupChooseState()
        setupChoosecity()
        
        if isConnectedToNetwork() {
            
            if(GlobalVariables.stateId.count > 0){
                self.chooseState.dataSource = GlobalVariables.stateName
            }else{
                getState()
                
            }
        }else{
            
        }
        // Do any additional setup after loading the view.
    }
    func setupChooseState() {
        
        chooseState.anchorView = btnState
        chooseState.selectionAction = { [weak self] (index, item) in
            self?.btnState.setTitle(item, for: .normal)
            self?.stateIdSelected = (GlobalVariables.stateId[index].description)
            self?.stateNameSel = (GlobalVariables.stateName[index])
            self?.btnCity.setTitle("City".localized1, for: .normal)
            self?.cityId.removeAll()
            self?.cityName.removeAll()
            self?.getCity(stateId: (GlobalVariables.stateId[index]))
        }
    }
    
    
    
    func setupChoosecity() {
        chooseCity.anchorView = btnCity
        chooseCity.selectionAction = { [weak self] (index, item) in
            self?.btnCity.setTitle(item, for: .normal)
            self?.cityNameSel = (self?.cityName[index])!
            self?.cityIdSelected = (self?.cityId[index].description)!
            
        }
    }
    
    @IBAction func btnStateClicked(_ sender: Any) {
        chooseState.show()
    }
    
    
    @IBAction func btnCityClicked(_ sender: Any) {
        chooseCity.show()
    }
    @objc func updateState(_ sender : UIButton){
        
        if isConnectedToNetwork() {
        if(btnState.currentTitle == "State".localized1){
            self.view.makeToast("Please Select state", duration: 2.0, position: .top)
        }else if(btnCity.currentTitle == "City".localized1){
            self.view.makeToast("Please Select City", duration: 2.0, position: .top)
        }
        else{
        
            let parameters = "member_city=\(cityIdSelected)&member_id=\(UserDefaults.standard.getUserID())&state=\(stateIdSelected)"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.get_user_city_state_update)!
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
                            GlobalVariables.state  = self.stateNameSel
                            GlobalVariables.member_city = self.cityNameSel
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:"State City data Updated", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                self.navigationController?.popViewController(animated: true)
                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
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
    
    func getState(){
        let parameters = "key=state&country_id="
        let url = URL(string:ServerUrl.commen_function)!
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
                
                print("satet idd--",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        
                        let stateId = jsonObject?.object(forKey: "sid") as? String
                        let stateName = jsonObject?.object(forKey: "state") as? String
                        GlobalVariables.stateName.append(stateName!)
                        GlobalVariables.stateId.append(stateId!)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseState.dataSource = GlobalVariables.stateName
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
    
    func getCity(stateId : String){
        let parameters = "key=city&state_id=\(stateId)"
        print("getting city--",parameters)
        let url = URL(string:ServerUrl.commen_function)!
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
                        let city_id = jsonObject?.object(forKey: "city_id") as? String
                        let city_name = jsonObject?.object(forKey: "city_name") as? String
                        self.cityId.append(city_id!)
                        self.cityName.append(city_name!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.chooseCity.dataSource = self.cityName
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
