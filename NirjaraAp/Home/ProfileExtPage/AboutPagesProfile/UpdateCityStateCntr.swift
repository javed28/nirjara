

//
//  UpdateCityStateCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/18/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import DropDown
class UpdateCityStateCntr: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblPersonal: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var btnState: UIButton!
    
    @IBOutlet weak var btnCity: UIButton!
    
    
    var stateName = [String]()
    var stateId = [String]()
    
    var cityId = [String]()
    var cityName = [String]()
    
    
    let chooseState = DropDown()
    let chooseCity = DropDown()
    
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
        
        
        
        topView.frame = CGRect(x:10,y:topbarHeight+10,width:self.view.frame.width-20,height:50)
        imgLogo.frame = CGRect(x:10,y:10,width:30,height:30)
        lblPersonal.frame = CGRect(x:70,y:10,width:self.topView.frame.width-140,height:30)
        topView.addSubview(imgLogo)
        topView.layer.cornerRadius = 5
        topView.addSubview(lblPersonal)
        
        lblState.frame = CGRect(x:10,y:topView.frame.origin.y+topView.frame.height+10,width:self.view.frame.width-20,height:25)
        btnState.frame = CGRect(x:10,y:lblState.frame.origin.y+lblState.frame.height+5,width:self.view.frame.width-20,height:40)
        lblCity.frame = CGRect(x:10,y:btnState.frame.origin.y+btnState.frame.height+10,width:self.view.frame.width-20,height:25)
        btnCity.frame = CGRect(x:10,y:lblCity.frame.origin.y+lblCity.frame.height+5,width:self.view.frame.width-20,height:40)
        btnSubmit.frame = CGRect(x:10,y:btnCity.frame.origin.y+btnCity.frame.height+25,width:self.view.frame.width-20,height:50)
        
        btnSubmit.layer.cornerRadius = 5
        btnState.layer.cornerRadius = 5
        btnCity.layer.cornerRadius = 5
        
        topView.alpha = 0
        lblState.alpha = 0
        btnState.alpha = 0
        lblCity.alpha = 0
        btnCity.alpha = 0
        btnSubmit.alpha = 0
        
        lblState.text = "State".localized1
        lblCity.text = "City".localized1
        btnSubmit.setTitle("Submit".localized1, for: .normal)
       // btnSubmit.addTarget(self, action: #selector(updateReligion(_:)), for: .touchUpInside)
        btnState.setTitle("State".localized1, for: .normal)
        btnCity.setTitle("City".localized1, for: .normal)
        
        setupChooseState()
        setupChoosecity()
        //getState()
        
//        DropDown.appearance().textColor = UIColor.black
//        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
//        DropDown.appearance().backgroundColor = UIColor.white
//        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
//        DropDown.appearance().cellHeight = 60
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnStateClicked(_ sender: Any) {
        print("statename--",stateName[0])
        chooseState.show()
    }
    
    
    @IBAction func btnCityClicked(_ sender: Any) {
        chooseCity.show()
    }
    
    func setupChooseState() {
        chooseState.dataSource = stateName
        chooseState.anchorView = btnState
        chooseState.selectionAction = { [weak self] (index, item) in
            self?.btnState.setTitle(item, for: .normal)
            
            self?.cityId.removeAll()
            self?.cityName.removeAll()
            self?.getCity(stateId: (self?.stateId[index])!)
        }
    }
    
   
    
    func setupChoosecity() {
        chooseCity.dataSource = cityName
        chooseCity.anchorView = btnCity
        chooseCity.selectionAction = { [weak self] (index, item) in
            self?.btnCity.setTitle(item, for: .normal)
  
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
                        self.stateId.append(stateId!)
                        self.stateName.append(stateName!)
                        
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
