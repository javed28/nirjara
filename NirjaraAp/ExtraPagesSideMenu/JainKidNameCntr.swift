//
//  JainKidNameCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class JainKidNameCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentCntr: UISegmentedControl!
    @IBOutlet weak var kidsTableView: UITableView!


    var kidsNameData : NSMutableArray = NSMutableArray()
    var BoysNameData : NSMutableArray = NSMutableArray()
    var GirlsNameData : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jain Kids Name"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:12))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:12,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        segmentCntr.setTitle("All".localized1, forSegmentAt: 0)
        segmentCntr.setTitle("Girls".localized1, forSegmentAt: 1)
        segmentCntr.setTitle("Boy".localized1, forSegmentAt: 2)
        kidsTableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
            kidsNameData.removeAllObjects()
            BoysNameData.removeAllObjects()
            BoysNameData.removeAllObjects()
        getKidsData()
    }else{
   // showAlert(title: "OOp's", message: "No Internet Connection")
    }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnvalue = 0
        switch (segmentCntr.selectedSegmentIndex) {
        case 0:
            returnvalue = kidsNameData.count
            break
        case 1:
            returnvalue = GirlsNameData.count
            break
        case 2:
            returnvalue = BoysNameData.count
            break
        default:
            break
        }
        return returnvalue
    }
    
    @IBAction func MySegmentClick(_ sender: Any) {
        switch (segmentCntr.selectedSegmentIndex) {
        case 0:
            
            if(kidsNameData.count == 0){
            }else{
        
                self.kidsTableView.reloadData()
            }
            
            break
        case 1:
            
            if(GirlsNameData.count == 0){
                
            }
            else{
                self.kidsTableView.reloadData()
            }
            break
        case 2:
            if(BoysNameData.count == 0){
            }
            else{
                self.kidsTableView.reloadData()
            }
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = kidsTableView.dequeueReusableCell(withIdentifier: "kidsIdentifier", for: indexPath) as! JainKidsTableViewCell
        
        cell.selectionStyle = .none
        switch (segmentCntr.selectedSegmentIndex) {
        case 0:
            
            let kidData = kidsNameData[indexPath.row] as? kidsModel
            cell.lblKidsName.text = kidData?.baby_name
            cell.lblKidsName.frame = CGRect(x:85,y:15,width:self.view.frame.width-85,height:30)
            cell.lblMeaning.frame = CGRect(x:85,y:40,width:self.view.frame.width-85,height:30)
            cell.lblMeaning.text = kidData?.meaning
            cell.imgKidsIcon.frame = CGRect(x:15,y:15,width:50,height:50)
            break
        case 1:
            let kidData = GirlsNameData[indexPath.row] as? kidsModel
            cell.lblKidsName.text = kidData?.baby_name
            cell.lblMeaning.text = kidData?.meaning
            cell.lblKidsName.frame = CGRect(x:85,y:15,width:self.view.frame.width-85,height:30)
            cell.lblMeaning.frame = CGRect(x:85,y:40,width:self.view.frame.width-85,height:30)
            cell.imgKidsIcon.frame = CGRect(x:15,y:15,width:50,height:50)
            break
        case 2:
            let kidData = BoysNameData[indexPath.row] as? kidsModel
            cell.lblKidsName.text = kidData?.baby_name
            cell.lblMeaning.text = kidData?.meaning
            cell.lblKidsName.frame = CGRect(x:85,y:15,width:self.view.frame.width-85,height:30)
            cell.lblMeaning.frame = CGRect(x:85,y:40,width:self.view.frame.width-85,height:30)
            cell.imgKidsIcon.frame = CGRect(x:15,y:15,width:50,height:50)
            break
        default:
            break
        }
        return cell
    }
    
    
    func getKidsData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_kids)!
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
                    let nameData = json?.object(forKey: "result") as? [NSDictionary]

                    for i in 0..<nameData!.count{
                        let jsonObject = nameData?[i]
                        
                        var kidsMModel = kidsModel()
                        kidsMModel.baby_id = jsonObject?.object(forKey: "baby_id") as? String
                        kidsMModel.baby_type = jsonObject?.object(forKey: "baby_type") as? String
                        kidsMModel.baby_name = jsonObject?.object(forKey: "baby_name") as? String
                        kidsMModel.meaning = jsonObject?.object(forKey: "meaning") as? String
                        self.kidsNameData.add(kidsMModel)
                        if(jsonObject?.object(forKey: "baby_type") as? String == "boy"){
                            self.BoysNameData.add(kidsMModel)
                        }else if(jsonObject?.object(forKey: "baby_type") as? String == "girl"){
                            self.GirlsNameData.add(kidsMModel)
                        }
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.kidsTableView.reloadData()
                        
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
    
    func sideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
