//
//  MyTableListCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
class MyTableListCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var lblNoRecord: UILabel!
    
     var myBusiness : NSMutableArray = NSMutableArray()
    @IBOutlet weak var tblList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         tblList.separatorStyle = .none
        self.tblList.alpha = 1
        self.lblNoRecord.alpha = 0
         getBusinessData()
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBusiness.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblList.dequeueReusableCell(withIdentifier: "mylistIdentifier", for: indexPath) as! MyListTableViewCell
         cell.selectionStyle = .none
         let businessData = myBusiness[indexPath.row] as! MyPostModel
        cell.mainBackground.frame = CGRect(x:10,y:10,width:view.frame.width-20,height:205)
      
        cell.lblName.frame = CGRect(x:10,y:10,width:cell.mainBackground.frame.width-20,height:25)
        
        cell.viewLine.frame = CGRect(x:20,y:40,width:cell.mainBackground.frame.width-20,height:1)
        cell.lblAtPost.frame = CGRect(x:10,y:45,width:cell.mainBackground.frame.width-20,height:25)
        cell.lblContactNo.frame = CGRect(x:10,y:85,width:cell.mainBackground.frame.width-20,height:25)
        cell.lblProductName.frame = CGRect(x:10,y:125,width:cell.mainBackground.frame.width-20,height:25)
        cell.btnDetails.frame = CGRect(x:10,y:175,width:cell.mainBackground.frame.width-110,height:35)
        cell.btnEdit.frame = CGRect(x:cell.mainBackground.frame.width-100,y:165,width:40,height:40)
        cell.btnDelete.frame = CGRect(x:cell.mainBackground.frame.width-50,y:165,width:40,height:40)
        
        
        var businesDesctext = String(describing: businessData.business_description!)
        businesDesctext = businesDesctext.replacingOccurrences(of: "Optional", with: "")
        businesDesctext = businesDesctext.replacingOccurrences(of: "(", with: "")
        businesDesctext = businesDesctext.replacingOccurrences(of: ")", with: "")
        
        cell.lblName.setFAText(prefixText: "", icon: .FAUsers, postfixText:" "+businessData.business_owner_name, size: 18)
        cell.lblAtPost.setFAText(prefixText: "", icon: .FALocationArrow, postfixText:" "+businesDesctext, size: 18)
        cell.lblContactNo.setFAText(prefixText: "", icon: .FAMobile, postfixText:" "+businessData.contact_no, size: 18)
        cell.lblProductName.text = businessData.product1
        cell.btnEdit.setFAIcon(icon: .FAPencil, iconSize: 30, forState: .normal)
        cell.btnDelete.setFAIcon(icon: .FATrash, iconSize: 30, forState: .normal)
        cell.btnEdit.setFATitleColor(color: .black, forState: .normal)
        cell.btnDelete.setFATitleColor(color: .black, forState: .normal)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(deleteSecuirty(_:)), for: UIControlEvents.touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(editBusiness(_:)), for: UIControlEvents.touchUpInside)
        
        
        cell.mainBackground.addSubview(cell.lblName)
        cell.mainBackground.addSubview(cell.viewLine)
        cell.mainBackground.addSubview(cell.lblAtPost)
        cell.mainBackground.addSubview(cell.lblProductName)
        cell.mainBackground.addSubview(cell.lblContactNo)
        cell.mainBackground.addSubview(cell.btnDetails)
        cell.mainBackground.addSubview(cell.btnEdit)
        cell.mainBackground.addSubview(cell.btnDelete)
        
        
        
        return cell
    }
    
    @objc func editBusiness(_ sender : UIButton){
        
        let editBusiness = storyboard?.instantiateViewController(withIdentifier: "editBusinessStory") as! EditBusinessViewCntr
        editBusiness.businessData = myBusiness[sender.tag] as! MyPostModel
        self.navigationController?.pushViewController(editBusiness, animated: true)
        
    }
    
    @objc func deleteSecuirty(_ sender : UIButton){
        
        let alertController = JHTAlertController(title: "Delete Business", message:"Are you sure you want to delete this Business?", preferredStyle: .alert)
        alertController.titleTextColor = .black
        alertController.titleFont = .systemFont(ofSize: 18)
        alertController.titleViewBackgroundColor = .white
        alertController.messageTextColor = .black
        alertController.alertBackgroundColor = .white
        
        
        let cancelAction = JHTAlertAction(title: "cancel", style: .cancel,  handler: nil)
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonBackgroundColorFor(.cancel, to: .white)
        
        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
            self.deleteBusiness(indexID: sender.tag)
        }
        alertController.setButtonTextColorFor(.default, to: .white)
        alertController.setButtonBackgroundColorFor(.default, to: UIColor.rgb(hexcolor: "#387ef5"))
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func deleteBusiness(indexID : Int){
        var data = myBusiness[indexID] as! MyPostModel
        let parameters = "business_id=\(data.business_id!)&member_id=\(UserDefaults.standard.getUserID())"
        
        let url = URL(string:ServerUrl.delete_my_business)!
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
                print("Business Response",json)
                let Success = json?.object(forKey: "message") as? String;
                if (Success == "success")
                {
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        self.myBusiness.removeObject(at: indexID)
                        self.tblList.reloadData()
                        
                        self.showAlert(title: "Nirjara Ap", message: "Business Deleted Succesfully")
                        
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
    
    func getBusinessData(){
        let parameters = "member_id="+UserDefaults.standard.getUserID()
        let url = URL(string:ServerUrl.get_business_by_id)!
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
                
                let message = json?.object(forKey: "message") as? String;
                if (message == "success")
                {
                    
                    
                    let  mybusinessData = json?.object(forKey: "result") as? [NSDictionary]
                    for j in 0..<mybusinessData!.count{
                        let jsonObject = mybusinessData?[j]
                        var myPostMModel = MyPostModel()
                        
                        myPostMModel.business_id = jsonObject?.object(forKey: "business_id") as? String
                        myPostMModel.business_cat_id = jsonObject?.object(forKey: "business_cat_id") as? String
                        myPostMModel.business_cat_name = jsonObject?.object(forKey: "business_cat_name") as? String
                         myPostMModel.package_id = jsonObject?.object(forKey: "package_id") as? String
                        myPostMModel.payment_id = jsonObject?.object(forKey: "payment_id") as? String
                        myPostMModel.payment_status = jsonObject?.object(forKey: "payment_status") as? String
                        myPostMModel.package_name = jsonObject?.object(forKey: "package_name") as? String
                        myPostMModel.package_cost = jsonObject?.object(forKey: "package_cost") as? String
                        myPostMModel.business_owner_name = jsonObject?.object(forKey: "business_owner_name") as? String
                        myPostMModel.business_title = jsonObject?.object(forKey: "business_title") as? String
                        myPostMModel.business_description = jsonObject?.object(forKey: "business_description") as? String
                        myPostMModel.address = jsonObject?.object(forKey: "address") as? String
                        myPostMModel.contact_no = jsonObject?.object(forKey: "contact_no") as? String
                        myPostMModel.email_id = jsonObject?.object(forKey: "email_id") as? String
                        myPostMModel.product1 = jsonObject?.object(forKey: "product1") as? String
                        self.myBusiness.add(myPostMModel)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tblList.reloadData()
                        self.tblList.alpha = 1
                        self.lblNoRecord.alpha = 0
                    }
                }else if (message == "fail"){
                     DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.tblList.alpha = 0
                    self.lblNoRecord.alpha = 1
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
