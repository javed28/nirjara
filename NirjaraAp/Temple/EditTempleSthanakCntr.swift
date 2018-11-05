//
//  EditTempleSthanakCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import ImageSlideshow
import JHTAlertController
import IQKeyboardManagerSwift
class EditTempleSthanakCntr: UIViewController,SSRadioButtonControllerDelegate {
    var typeRadioButton: SSRadioButtonsController?
    var foodFacilityRadioButton: SSRadioButtonsController?
    var stayAvailableRadioButton: SSRadioButtonsController?
    @IBOutlet weak var btnTemple: SSRadioButton!
    
    @IBOutlet weak var btnFoodNo: SSRadioButton!
    @IBOutlet weak var btnFoodYes: SSRadioButton!
    @IBOutlet weak var btnStayYes: SSRadioButton!
    @IBOutlet weak var btnStayNo: SSRadioButton!
    
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblPlaceInformation: UILabel!
    
    @IBOutlet weak var txtPlaceName: UITextField!
    
    @IBOutlet weak var lblStayAvailabel: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblFoodFacility: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var txtPlaceInformation: UITextView!
  
    @IBOutlet weak var btnSthanak: SSRadioButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnEditViewBack: UIView!
    
    
    var templeData = templeSthanakModel()
    
    @IBOutlet weak var templeImage: ImageSlideshow!
    

    @IBOutlet weak var btnEdit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Edit Temple's"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:7,length:8))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        typeRadioButton = SSRadioButtonsController(buttons: btnSthanak, btnTemple)
        typeRadioButton!.delegate = self
        typeRadioButton!.shouldLetDeSelect = true
        
        foodFacilityRadioButton = SSRadioButtonsController(buttons: btnFoodYes, btnFoodNo)
        foodFacilityRadioButton!.delegate = self
        foodFacilityRadioButton!.shouldLetDeSelect = true
        
        stayAvailableRadioButton = SSRadioButtonsController(buttons: btnStayYes, btnStayNo)
        stayAvailableRadioButton!.delegate = self
        stayAvailableRadioButton!.shouldLetDeSelect = true
        
        
        templeImage.frame = CGRect(x:10,y:18,width:self.view.frame.width-20,height:200)
        btnEditViewBack.frame = CGRect(x:self.view.frame.width-80,y:160,width:50,height:50)
        btnEdit.frame = CGRect(x:12.5,y:12.5,width:25,height:25)
        btnEdit.addTarget(self, action: #selector(imageUpdate(_:)), for: UIControlEvents.touchUpInside)
        btnEditViewBack.addSubview(btnEdit)
        btnEditViewBack.layer.cornerRadius = 25
        
        
        
        
        self.templeImage.backgroundColor = UIColor.white
        self.templeImage.slideshowInterval = 4.0
        self.templeImage.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
        self.templeImage.pageControl.pageIndicatorTintColor = UIColor.white
        self.templeImage.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        
        
        lblPlaceName.frame = CGRect(x:10,y:templeImage.frame.origin.y+templeImage.frame.height+10,width:self.view.frame.width-20,height:25)
        txtPlaceName.frame = CGRect(x:10,y:lblPlaceName.frame.origin.y+lblPlaceName.frame.height+5,width:self.view.frame.width-20,height:45)
        
        txtPlaceName.text = templeData.temple_name
        txtPlaceInformation.text = templeData.temple_info
        txtLocation.text = templeData.location
        txtContactNo.text = templeData.contact
        
        if(templeData.type == "Temple"){
            btnTemple.isSelected = true
        }else{
             btnSthanak.isSelected = true
        }
        if(templeData.food_available == "Yes"){
            btnFoodYes.isSelected = true
        }else{
            btnFoodNo.isSelected = true
        }
        if(templeData.stay_available == "Yes"){
            btnStayYes.isSelected = true
        }else{
            btnStayNo.isSelected = true
        }
        
        
        
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
        
        btnSubmit.addTarget(self, action: #selector(editTempleSthanak(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        border(textname: txtPlaceName,placholderText:"Place Name")
        border(textname: txtContactNo,placholderText:"98xxxxxxxx")
        border(textname: txtLocation,placholderText:"Current Location")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        var images = [InputSource]()
        
        if(GlobalVariables.editTempleImage == nil || GlobalVariables.editTempleImage==""){
            images.append(ImageSource(image: UIImage(named: "default-img")!))
        }else{
            
            let alamofireSource = AlamofireSource(urlString: GlobalVariables.editTempleImage)!
            images.append(alamofireSource)
        }
        images.append(ImageSource(image: UIImage(named: "default-img")!))
        images.append(ImageSource(image: UIImage(named: "default-img")!))
        self.templeImage.setImageInputs(images)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didSelectButton(selectedButton: UIButton?) {
        
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
    
    
    @objc func imageUpdate(_ sender : UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as? OtherImageUploadCntr
        
        gotoOtherUpload?.whatToUpload = "templeEditImage"
        gotoOtherUpload?.templeImageId =  templeData.temple_id
        self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
    }
    
    
    @objc func editTempleSthanak(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtPlaceName.text == ""){
            self.view.makeToast("Please Add Place Name", duration: 2.0, position: .top)
        }
//        else if(!txtContactNo.text!.isPhone()){
//            self.view.makeToast("Please Enter Correct Mobile No", duration: 2.0, position: .top)
//        }
        else if(typeRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Type", duration: 2.0, position: .top)
        }else if(foodFacilityRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Food Facility", duration: 2.0, position: .top)
        }else if(stayAvailableRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Stay Available", duration: 2.0, position: .top)
        }
        else{
            
            
            
            var typeData = String()
            var stayData = String()
            var foodData = String()
            
           
                typeData = (typeRadioButton?.selectedButton()?.currentTitle)!

                stayData = (foodFacilityRadioButton?.selectedButton()?.currentTitle)!

                foodData = (stayAvailableRadioButton?.selectedButton()?.currentTitle)!
        
            var contat = String()
            if(txtContactNo.text == ""){
                contat = ""
            }else{
                contat = txtContactNo.text!
            }
            
            
            let parameters = "temple_id=\(templeData.temple_id!)&temple_name=\(txtPlaceName.text!)&member_id=\(UserDefaults.standard.getUserID())&contact_number=\(contat)&location=\(GlobalVariables.currentAddres)&latitude=\(templeData.latitude!)&longitude=\(templeData.longitude!)&temple_info=\(txtPlaceInformation.text!)&type=\(typeData)&is_food_available=\(foodData)&is_stay_available=\(stayData)"
            
            
            
            let url = URL(string:ServerUrl.edit_temple)!
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
                    print("Edit Temple Reponse",json)
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "Success")
                    {
                        
            
                        
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            
                            
                            let alertController = JHTAlertController(title: "Nirjara Ap", message:"Temple Edited Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
//                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                                let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as? OtherImageUploadCntr
//
//                                gotoOtherUpload?.whatToUpload = "Temples"
//                                gotoOtherUpload?.templeId = String(describing: last_inserted_id)
//
//                                self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
                                
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
