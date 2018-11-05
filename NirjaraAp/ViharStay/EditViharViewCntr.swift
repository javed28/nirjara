//
//  EditViharViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import IQKeyboardManagerSwift
class EditViharViewCntr: UIViewController {

    
    var myViharStayData = viharStayModel()
    @IBOutlet weak var lblAddPlace: UILabel!
    @IBOutlet weak var txtAddPlace: UITextField!
    
    @IBOutlet weak var lblContactNo: UILabel!
    
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var lblPlace: UILabel!
    
    @IBOutlet weak var txtPlace: UITextField!
    
    @IBOutlet weak var lblFamily: UILabel!
    
    @IBOutlet weak var txtFamily: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
      var containerController: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Edit Vihar Stay"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:13))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:13,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        self.addShadowToBarMap()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        lblAddPlace.frame = CGRect(x:10,y:25,width:self.view.frame.width-20,height:25)
        txtAddPlace.frame = CGRect(x:10,y:lblAddPlace.frame.origin.y+lblAddPlace.frame.height,width:self.view.frame.width-20,height:45)
        lblContactNo.frame = CGRect(x:10,y:txtAddPlace.frame.origin.y+txtAddPlace.frame.height+10,width:self.view.frame.width-20,height:25)
        txtContactNo.frame = CGRect(x:10,y:lblContactNo.frame.origin.y+lblContactNo.frame.height,width:self.view.frame.width-20,height:45)
        
        lblPlace.frame = CGRect(x:10,y:txtContactNo.frame.origin.y+txtContactNo.frame.height+10,width:self.view.frame.width-20,height:25)
        txtPlace.frame = CGRect(x:10,y:lblPlace.frame.origin.y+lblPlace.frame.height,width:self.view.frame.width-20,height:45)
        
        lblFamily.frame = CGRect(x:10,y:txtPlace.frame.origin.y+txtPlace.frame.height+10,width:self.view.frame.width-20,height:25)
        txtFamily.frame = CGRect(x:10,y:lblFamily.frame.origin.y+lblFamily.frame.height,width:self.view.frame.width-20,height:45)
        
        btnSubmit.frame = CGRect(x:10,y:txtFamily.frame.origin.y+txtFamily.frame.height+18,width:self.view.frame.width-20,height:50)
        
        
        border(textname: txtAddPlace,placholderText:"Add Place")
        border(textname: txtContactNo,placholderText:"98xxxxxxxx")
        border(textname: txtPlace,placholderText:"Place Name")
        border(textname: txtFamily,placholderText:"how many jain families are around you?")

        let data = myViharStayData
        txtAddPlace.text = data.name
        txtContactNo.text = data.contact
        txtPlace.text = data.vihar_address
        txtFamily.text = data.jain_family_around
        
        containerController = revealViewController().frontViewController as? ContainerViewController
        btnSubmit.addTarget(self, action: #selector(updateVihar(_:)), for: UIControlEvents.touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func updateVihar(_ sender : UIButton){
        
        if isConnectedToNetwork() {
        let data = myViharStayData
        if(txtAddPlace.text == ""){
            self.view.makeToast("Add Place", duration: 2.0, position: .top)
        }else if(!txtContactNo.text!.isPhone()){
            self.view.makeToast("Wrong Mobile No", duration: 2.0, position: .top)
        }else if(!(txtFamily.text?.isNumber)!){
            self.view.makeToast("Jain Family Add count", duration: 2.0, position: .top)
        }
        else{
            
            let parameters = "name=\(UserDefaults.standard.getMemberName())&member_id=\(UserDefaults.standard.getUserID())&contact=\(txtContactNo.text!)&jain_family_around=\(txtFamily.text!)&vihar_address=\(txtPlace.text!)&vihar_latitude=\(GlobalVariables.currentLat)&vihar_longitude=\(GlobalVariables.currentLong)&city=\(GlobalVariables.TempleState)&vihar_stay_id=\(data.vihar_stay_id!)"
            print("pararmettt---",parameters)
            let url = URL(string:ServerUrl.post_vihar_stay_edit)!
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
                    print("Edit Vihar Reponse",json)
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "Success")
                    {
                        
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            
                            
                            // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                            
                            let alertController = JHTAlertController(title: "Success", message:"Vihar Say Updated Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
//                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
//                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[1])
//                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                           
                            self.showAlert(title: "Error", message: "Something Went Wrong")
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
