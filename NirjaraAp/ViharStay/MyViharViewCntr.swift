//
//  MyViharViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
class MyViharViewCntr: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myViharCollection: UICollectionView!
    
         var viharStayData : NSMutableArray = NSMutableArray()
   
    
    
    @IBOutlet weak var lblNoRecord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  My Vihar Stay"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        self.addShadowToBarMap()
        self.lblNoRecord.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viharStayData.removeAllObjects()
        getViharStayData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viharStayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width
        
        return CGSize(width: collectionViewSize/2-5, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myViharCollection.dequeueReusableCell(withReuseIdentifier: "myViharIdentifier", for: indexPath) as! MyViharCollectionViewCell
        cell.mainView.frame=CGRect(x:10,y:0,width:self.view.frame.width/2-40,height:100)
        
        
        let viharData = viharStayData[indexPath.row] as! viharStayModel
        
        cell.lblViharstayName.text = viharData.name
        cell.lblViharstayName?.frame = CGRect(x:15,y:10,width:cell.mainView.frame.width-30,height:28)

        cell.locationImg.frame = CGRect(x:15,y:(cell.lblViharstayName.frame.origin.y)+(cell.lblViharstayName.frame.height)+2,width:12,height:15)
        cell.lblRegion?.text = viharData.vihar_address
        
        cell.lblRegion?.frame = CGRect(x:28,y:(cell.lblViharstayName.frame.origin.y)+(cell.lblViharstayName.frame.height),width:cell.mainView.frame.width-45,height:25)
        
        cell.btnEdit?.frame = CGRect(x:15,y:(cell.lblRegion.frame.origin.y)+(cell.lblRegion.frame.height),width:25,height:25)
        
        cell.btnDelete?.frame = CGRect(x:self.myViharCollection.frame.width/2-60,y:(cell.lblRegion.frame.origin.y)+(cell.lblRegion.frame.height),width:25,height:25)
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        cell.btnEdit.setFAIcon(icon: .FAEdit, iconSize: 18, forState: .normal)
        cell.btnDelete.setFAIcon(icon: .FATrash, iconSize: 18, forState: .normal)
        cell.btnEdit.setFATitleColor(color: UIColor.black, forState: .normal)
        cell.btnDelete.setFATitleColor(color: UIColor.black, forState: .normal)
        cell.btnEdit.addTarget(self, action: #selector(editSecuirty(_:)), for: UIControlEvents.touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(deleteViharAlert(_:)), for: UIControlEvents.touchUpInside)
        
        cell.mainView.addSubview(cell.lblViharstayName)
        cell.mainView.addSubview(cell.locationImg)
        cell.mainView.addSubview(cell.btnEdit)
        cell.mainView.addSubview(cell.btnDelete)
        cell.mainView.addSubview(cell.lblRegion)
        
        
        cell.mainView.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.lightgray), opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 4, scale: true)
        return cell
    }
    
    @objc func editSecuirty(_ sender : UIButton){
        let editVihar = storyboard?.instantiateViewController(withIdentifier: "myViharEditIdentifier") as! EditViharViewCntr
        editVihar.myViharStayData = viharStayData[sender.tag] as! viharStayModel
        self.navigationController?.pushViewController(editVihar, animated: true)
   
    }
    @objc func deleteViharAlert(_ sender : UIButton){
        
        
        let alertController = JHTAlertController(title: "Delete Vihar Stay", message:"Are you sure you want to delete this Vihar Stay?", preferredStyle: .alert)
        
        alertController.titleTextColor = .black
        alertController.titleFont = .systemFont(ofSize: 18)
        alertController.titleViewBackgroundColor = .white
        alertController.messageTextColor = .black
        alertController.alertBackgroundColor = .white
        
        
        let cancelAction = JHTAlertAction(title: "cancel", style: .cancel,  handler: nil)
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonBackgroundColorFor(.cancel, to: .white)
        
        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
            self.deleteVihar(indexID: sender.tag)
        }
        alertController.setButtonTextColorFor(.default, to: .white)
        alertController.setButtonBackgroundColorFor(.default, to: UIColor.rgb(hexcolor: "#387ef5"))
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func deleteVihar(indexID : Int){
        var data = viharStayData[indexID] as! viharStayModel
        let parameters = "vihar_stay_id=\(data.vihar_stay_id!)&member_id=\(UserDefaults.standard.getUserID())"
        print("secuityr params",parameters)
        let url = URL(string:ServerUrl.delete_vihar_stay)!
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
                print("security Response",json)
                let Success = json?.object(forKey: "message") as? String;
                if (Success == "success")
                {
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        self.viharStayData.removeObject(at: indexID)
                        self.myViharCollection.reloadData()
                        if(self.viharStayData.count == 0){
                            self.lblNoRecord.alpha = 1
                            self.myViharCollection.alpha = 0
                        }else{
                            self.lblNoRecord.alpha = 0
                            self.myViharCollection.alpha = 1
                        }
                        
                        self.showAlert(title: "Success", message: "Vihar Stay Deleted Succesfully")
                        
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
    
    
    
    func getViharStayData(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang="+GlobalVariables.selectedLanguage
        let url = URL(string:ServerUrl.get_vihar_stay_member_wise)!
        print("parameters---",parameters)
        
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
                
                
                let message : String =  json!.value(forKey: "message") as! String
                if (message == "success")
                {
                    
                    DispatchQueue.main.async {
                       
                        let viharData = json!.value(forKey: "result") as? [NSDictionary]
                        for j in 0..<viharData!.count{
                            let jsonObject = viharData?[j]
                            var viharStayMModel = viharStayModel()
                            
                            viharStayMModel.vihar_stay_id = jsonObject?.object(forKey: "vihar_stay_id") as? String
                            viharStayMModel.contact = jsonObject?.object(forKey: "contact") as? String
                            
                            viharStayMModel.member_id = jsonObject?.object(forKey: "member_id") as? String
                            
                            viharStayMModel.vihar_address = jsonObject?.object(forKey: "vihar_address") as? String
                            viharStayMModel.name = jsonObject?.object(forKey: "name") as? String
                            viharStayMModel.jain_family_around = jsonObject?.object(forKey: "jain_family_around") as? String
                            
                            
                            
                            self.viharStayData.add(viharStayMModel)
                        }
                        
                        self.hideActivityIndicator()
                        self.myViharCollection.reloadData()
                        self.lblNoRecord.alpha = 0
                        self.myViharCollection.alpha = 1
                        
                        
                        
                    }
                }else if(message == "fail"){
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                       self.lblNoRecord.alpha = 1
                        self.myViharCollection.alpha = 0
                        self.myViharCollection.reloadData()
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
