//
//  AddTempleStahnakCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
class AddTempleStahnakCntr: UIViewController,SSRadioButtonControllerDelegate {
    

    
    var typeRadioButton: SSRadioButtonsController?
    var foodFacilityRadioButton: SSRadioButtonsController?
    var stayAvailableRadioButton: SSRadioButtonsController?
    
    @IBOutlet weak var btnSthanak: SSRadioButton!
    @IBOutlet weak var btnTemple: SSRadioButton!
    
    
    @IBOutlet weak var btnFoodYes: SSRadioButton!
    @IBOutlet weak var btnFoodNo: SSRadioButton!
    
    @IBOutlet weak var btnStayYes: SSRadioButton!
    @IBOutlet weak var btnStayNo: SSRadioButton!
    
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var txtPlaceName: UITextField!
    
    @IBOutlet weak var lblPlaceInformation: UILabel!
    @IBOutlet weak var txtPlaceInformation: UITextView!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblFoodFacility: UILabel!
    
    @IBOutlet weak var lblStayAvailabel: UILabel!
    
    @IBOutlet weak var lblContactNo: UILabel!
    
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Add Temple Sthanak"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:6,length:14))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        
        self.updateBackButton()
        typeRadioButton = SSRadioButtonsController(buttons: btnSthanak, btnTemple)
        typeRadioButton!.delegate = self
        typeRadioButton!.shouldLetDeSelect = true
        
        btnSthanak.setTitle("Sthanak".localized1, for: .normal)
        btnTemple.setTitle("TempleMantr".localized1, for: .normal)
        
        foodFacilityRadioButton = SSRadioButtonsController(buttons: btnFoodYes, btnFoodNo)
        foodFacilityRadioButton!.delegate = self
        foodFacilityRadioButton!.shouldLetDeSelect = true
        
        btnFoodYes.setTitle("Yes".localized1, for: .normal)
        btnFoodNo.setTitle("No".localized1, for: .normal)
        
        
        stayAvailableRadioButton = SSRadioButtonsController(buttons: btnStayYes, btnStayNo)
        stayAvailableRadioButton!.delegate = self
        stayAvailableRadioButton!.shouldLetDeSelect = true
        btnStayYes.setTitle("Yes".localized1, for: .normal)
        btnStayNo.setTitle("No".localized1, for: .normal)

        
        lblPlaceName.frame = CGRect(x:10,y:18,width:self.view.frame.width-20,height:25)
        txtPlaceName.frame = CGRect(x:10,y:lblPlaceName.frame.origin.y+lblPlaceName.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        lblPlaceInformation.frame = CGRect(x:10,y:txtPlaceName.frame.origin.y+txtPlaceName.frame.height+15,width:self.view.frame.width-20,height:25)
        txtPlaceInformation.frame = CGRect(x:10,y:lblPlaceInformation.frame.origin.y+lblPlaceInformation.frame.height+10,width:self.view.frame.width-20,height:100)
        
        lblType.frame = CGRect(x:10,y:txtPlaceInformation.frame.origin.y+txtPlaceInformation.frame.height+15,width:self.view.frame.width-20,height:25)
        btnSthanak.frame = CGRect(x:10,y:lblType.frame.origin.y+lblType.frame.height,width:self.view.frame.width/2-20,height:50)
        btnTemple.frame = CGRect(x:self.view.frame.width/2-20,y:lblType.frame.origin.y+lblType.frame.height,width:self.view.frame.width/2-20,height:50)
        
       
        lblFoodFacility.frame = CGRect(x:10,y:btnSthanak.frame.origin.y+btnSthanak.frame.height+15,width:self.view.frame.width-20,height:25)
        btnFoodYes.frame = CGRect(x:10,y:lblFoodFacility.frame.origin.y+lblFoodFacility.frame.height,width:self.view.frame.width/2-20,height:50)
        btnFoodNo.frame = CGRect(x:self.view.frame.width/2-20,y:lblFoodFacility.frame.origin.y+lblFoodFacility.frame.height,width:self.view.frame.width/2-20,height:50)
        
        lblStayAvailabel.frame = CGRect(x:10,y:btnFoodYes.frame.origin.y+btnFoodYes.frame.height+15,width:self.view.frame.width-20,height:25)
        btnStayYes.frame = CGRect(x:10,y:lblStayAvailabel.frame.origin.y+lblStayAvailabel.frame.height,width:self.view.frame.width/2-20,height:50)
        btnStayNo.frame = CGRect(x:self.view.frame.width/2-20,y:lblStayAvailabel.frame.origin.y+lblStayAvailabel.frame.height,width:self.view.frame.width/2-20,height:50)
        
        
        lblContactNo.frame = CGRect(x:10,y:btnStayNo.frame.origin.y+btnStayNo.frame.height+15,width:self.view.frame.width-20,height:25)
        txtContactNo.frame = CGRect(x:10,y:lblContactNo.frame.origin.y+lblContactNo.frame.height+5,width:self.view.frame.width-20,height:45)
        
        lblLocation.frame = CGRect(x:10,y:txtContactNo.frame.origin.y+txtContactNo.frame.height+15,width:self.view.frame.width-20,height:25)
        txtLocation.frame = CGRect(x:10,y:lblLocation.frame.origin.y+lblLocation.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        btnSubmit.frame = CGRect(x:10,y:txtLocation.frame.origin.y+txtLocation.frame.height+25,width:self.view.frame.width-20,height:55)
        // Do any additional setup after loading the view.
        
        lblPlaceName.text = "Place".localized1+" "+"Name".localized1
        lblContactNo.text = "ContactNumber".localized1
        lblPlaceInformation.text = "PlaceInformation".localized1
        lblType.text = "TempleType".localized1
        lblFoodFacility.text = "FoodFacility".localized1
        lblStayAvailabel.text = "StayAvailable".localized1
        lblLocation.text = "Location".localized1
        
      
        
        
        border(textname: txtPlaceName,placholderText:"Place".localized1+" "+"Name".localized1)
        border(textname: txtContactNo,placholderText:"ContactNumber".localized1)
        border(textname: txtLocation,placholderText:"EnterLocation".localized1)
        btnSubmit.addTarget(self, action: #selector(AddTempleStahnakCntr.AddTempleSthanak(_:)), for: UIControlEvents.touchUpInside)
        btnSubmit.setTitle("Add".localized1, for: .normal)
        txtLocation.text = GlobalVariables.currentAddres
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func AddTempleSthanak(_ sender : UIButton){
       if isConnectedToNetwork() {
        if(txtPlaceName.text == ""){
            self.view.makeToast("Please Add Place Name", duration: 2.0, position: .top)
        }
        /*else if(!txtContactNo.text!.isPhone()){
            self.view.makeToast("Please Enter Correct Mobile No", duration: 2.0, position: .top)
        }*/
        
        else if(typeRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Type", duration: 2.0, position: .top)
        }else if(foodFacilityRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Food Facility", duration: 2.0, position: .top)
        }else if(stayAvailableRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Stay Available", duration: 2.0, position: .top)
        }
        else{
            
            var isFood = ""
            if(foodFacilityRadioButton?.selectedButton()?.currentTitle == "Yes".localized1){
                isFood = "Yes".localized1
               
            }else {
                isFood = "No".localized1
            }
            
            var isStay = ""
            if(stayAvailableRadioButton?.selectedButton()?.currentTitle == "Yes".localized1){
                isStay = "Yes".localized1
                
            }else {
                isStay = "No".localized1
            }
            
            var isType = ""
            if(typeRadioButton?.selectedButton()?.currentTitle == "Sthanak".localized1){
                isType = "Sthanak".localized1
                
            }else {
                isType = "TempleMantr".localized1
            }
            var contactNo = ""
            if(txtContactNo.text == ""){
                contactNo = ""
            }else{
                contactNo = txtContactNo.text!
            }
            
            
            let parameters = "temple_name=\(txtPlaceName.text!)&member_id=\(UserDefaults.standard.getUserID())&contact_number=\(contactNo)&location=\(GlobalVariables.currentAddres)&latitude=\(GlobalVariables.currentLat)&longitude=\(GlobalVariables.currentLong)&temple_info=\(txtPlaceInformation.text!)&type=\(isType)&is_food_available=\(isFood)&is_stay_available=\(isStay)"
            
            print("Temnple dat--",parameters)
            
            let url = URL(string:ServerUrl.post_add_temple_url)!
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
                    print("Add Temple Reponse",json)
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "Success")
                    {
                    
                        
                        let last_inserted_id = json?.object(forKey: "data") as! Int
                        
                        print("Events Repsonse---finally",last_inserted_id)
                        
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            
                            
                            let alertController = JHTAlertController(title: "Nirjara Ap", message:"Temple Added Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as? OtherImageUploadCntr
                                
                                gotoOtherUpload?.whatToUpload = "Temples"
                                gotoOtherUpload?.templeId = String(describing: last_inserted_id)
                                
                                self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.alert(message: "Nirjara Ap", title: "Something Went Wrong")
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        NSLog(" \(selectedButton)" )
    }
    
    func border(textname : UITextField,placholderText : String){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 4, y : textname.frame.height-1,width:self.view.frame.width-28, height : 1.0)
        let color = UIColor.rgb(hexcolor:"#DCDCDC").cgColor
        bottomLine.backgroundColor = color
        textname.setTextLeftPadding(left: 10)
        
        textname.attributedPlaceholder = NSAttributedString(string:placholderText, attributes:[NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "DCDCDC"),NSAttributedStringKey.font :UIFont(name: "Helvetica", size: 18)!])
        textname.borderStyle = UITextBorderStyle.none
        textname.layer.addSublayer(bottomLine)
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
