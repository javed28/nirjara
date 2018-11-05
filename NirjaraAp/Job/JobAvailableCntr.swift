//
//  JobAvailableCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class JobAvailableCntr: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    

//    var Post = ["Need CA","Need Need Android Developer","Need Gujarati and hindi Witer","Need Gujarati and hindi Witer"]
//    var Qualification = ["Neps","Cbsc","default-icon","Nine Elements Production","Nine Elements Production"]
//    var noOfRequired = ["2","3","6","10"]
//    var date = ["29-Sep 2017","19-Aug 2017","29-Sep 2017","29-Sep 2017"]
    @IBOutlet weak var jobAvailable: UITableView!
    var jobAvailabel : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Job Available"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:6,length:9))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        //jobAvailable.separatorStyle = .none
     //getJobAvailable()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
        jobAvailabel.removeAllObjects()
        getJobAvailable()
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
    }
    
    
    
    func getJobAvailable(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(GlobalVariables.selectedLanguage)"
        let url = URL(string:ServerUrl.get_job_available)!
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
                        var jobmodel = JobModel()
                        
                        jobmodel.jobId = jsonObject?.object(forKey: "job_id") as? String
                        jobmodel.jobName = jsonObject?.object(forKey: "job_position") as? String
                        jobmodel.jobCompanyName = jsonObject?.object(forKey: "company_name") as? String
                        jobmodel.mobile_number = jsonObject?.object(forKey: "mobile_number") as? String
                        jobmodel.jobContactPerson = jsonObject?.object(forKey: "contact_person") as? String
                        jobmodel.mobile_number = jsonObject?.object(forKey: "mobile_number") as? String
                        jobmodel.jobDetails = jsonObject?.object(forKey: "job_details") as? String
                        jobmodel.jobExp = jsonObject?.object(forKey: "experiance_required") as? String
                        jobmodel.jobLocation = jsonObject?.object(forKey: "job_location") as? String
                        jobmodel.job_status = jsonObject?.object(forKey: "job_status") as? String
                        self.jobAvailabel.add(jobmodel)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.jobAvailable.reloadData()
  
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
    
    @objc func jobApply(_ sender : UIButton){
            let parameters = "member_id=\(UserDefaults.standard.getUserID())&job_id=\(sender.accessibilityLabel!)&lang=\(GlobalVariables.selectedLanguage)"
        
            let url = URL(string:ServerUrl.post_apply_job)!
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
                    if (Success == "Success")
                    {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.showAlert(title: "Well Done", message: "Applied For Job Successfully")
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "editTempleIdentifier", sender: self)
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "jobavilableHeaderIdentifier") as! JobAvailableHeaderCell
        headerCell.topBack.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:70)
        headerCell.btnAddJob.frame = CGRect(x:20,y:10,width:130,height:50)
        
        headerCell.btnAddJob.setFAText(prefixText: "", icon: .FAPlusSquare, postfixText: " "+"Add".localized1+" "+"AddJob".localized1, size: 20, forState: .normal)
        headerCell.btnAddJob.setFATitleColor(color: .white, forState: .normal)
        headerCell.btnAddJob.addTarget(self, action: #selector(self.gotoAddPage), for: UIControlEvents.touchUpInside)
        headerCell.topBack.addSubview((headerCell.btnAddJob)!)
        return headerCell
    }
    
    @objc func gotoAddPage(){
        self.performSegue(withIdentifier: "AddJobIdentifier", sender: self)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var jobData = self.jobAvailabel[indexPath.row] as? JobModel
        showAlert(title: ("Position : "+(jobData?.jobName)!), message: ("Description : "+(jobData?.jobDetails)!))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobAvailabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = jobAvailable.dequeueReusableCell(withIdentifier: "jobavilableIdentifier", for: indexPath) as? JobAvailableTableViewCell
        cell?.selectionStyle = .none
        
        
        let jobData = jobAvailabel[indexPath.row] as! JobModel
        
        cell?.mainBackground.frame = CGRect(x:10,y:0,width:self.view.frame.width-20,height:180)
        
        cell?.lblPost.text = "Position : "+jobData.jobName
        cell?.lblCompanyName.text = "Company Name : "+jobData.jobCompanyName
        
        cell?.lblContactPerson.text = "Contact Person Name : "+jobData.jobContactPerson
        cell?.lblContactMob.text = "Contact No : "+jobData.mobile_number

        
        cell?.lblCountPos.setFAText(prefixText: "", icon: .FACalendarO, postfixText: " Expericence required (months) : "+jobData.jobExp, size: 15)
        cell?.lblDate.setFAText(prefixText: "", icon: .FALocationArrow, postfixText: " Date : "+jobData.jobLocation, size: 15)
        
        cell?.lblCountPos.setFAColor(color: UIColor.rgb(hexcolor : GlobalVariables.titleColor))
        
        
        cell?.lblPost.frame = CGRect(x:10,y:10,width:(cell?.mainBackground.frame.width)!-20,height:30)
        cell?.lblCompanyName.frame = CGRect(x:10,y:(cell?.lblPost.frame.height)!+(cell?.lblPost.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:25)
        
        cell?.lblDesc.text = "Desc : "+jobData.jobDetails
        cell?.lblDesc.lineBreakMode = .byWordWrapping;
        if((cell?.lblDesc.text?.count)! < 33){
            cell?.lblDesc.numberOfLines = 1
            cell?.lblDesc.frame = CGRect(x:10,y:(cell?.lblCompanyName.frame.height)!+(cell?.lblCompanyName.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:25)
        }else{
        cell?.lblDesc.numberOfLines = 2
        cell?.lblDesc.frame = CGRect(x:10,y:(cell?.lblCompanyName.frame.height)!+(cell?.lblCompanyName.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:40)
        }
        
        cell?.lblCountPos.frame = CGRect(x:10,y:(cell?.lblDesc.frame.height)!+(cell?.lblDesc.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:25)
        cell?.lblContactPerson.frame = CGRect(x:10,y:(cell?.lblCountPos.frame.height)!+(cell?.lblCountPos.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:25)
        cell?.lblContactMob.frame = CGRect(x:10,y:(cell?.lblContactPerson.frame.height)!+(cell?.lblContactPerson.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:25)
        
        

        
        cell?.lblDate.frame = CGRect(x:10,y:(cell?.lblContactMob.frame.height)!+(cell?.lblContactMob.frame.origin.y)!+5,width:(cell?.mainBackground.frame.width)!-20,height:25)
        cell?.btnApply.frame = CGRect(x:10,y:(cell?.lblDate.frame.height)!+(cell?.lblDate.frame.origin.y)!+15,width:130,height:50)
        
        
        //cell?.btnApply.setTitleColor(UIColor.rgb(hexcolor: GlobalVariables.orangeColor), for: .normal)
        cell?.btnApply.accessibilityLabel = jobData.jobId
        cell?.btnApply.addTarget(self, action: #selector(jobApply), for: UIControlEvents.touchUpInside)
        cell?.mainBackground.addSubview((cell?.lblPost)!)
        cell?.mainBackground.addSubview((cell?.btnApply)!)
        cell?.mainBackground.addSubview((cell?.lblDate)!)
        cell?.mainBackground.addSubview((cell?.lblCountPos)!)
        cell?.mainBackground.addSubview((cell?.lblCompanyName)!)
        cell?.mainBackground.addSubview((cell?.lblContactPerson)!)
        cell?.mainBackground.addSubview((cell?.lblContactMob)!)
        cell?.mainBackground.addSubview((cell?.lblDesc)!)
        
        return cell!
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
