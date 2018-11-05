//
//  SignUpViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class SignUpViewCntr: UIViewController,SSRadioButtonControllerDelegate {
    
   
    

    @IBOutlet weak var btnShravak: SSRadioButton!
    @IBOutlet weak var btnSadhu: SSRadioButton!
    
    
    
    @IBOutlet weak var btnEnglish: SSRadioButton!
    @IBOutlet weak var btnHindi: SSRadioButton!
    @IBOutlet weak var btnGujarati: SSRadioButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var imgTopLogo: UIImageView!
    @IBOutlet weak var lblMemberType: UILabel!
    @IBOutlet weak var lblChooseLanguage: UILabel!
    var userRadioButton: SSRadioButtonsController?
    var languageRadioButton: SSRadioButtonsController?
    
    @IBOutlet weak var shravakView: UIView!
    @IBOutlet weak var guruView: UIView!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var hindiView: UIView!
    @IBOutlet weak var gujaratiView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        userRadioButton = SSRadioButtonsController(buttons: btnShravak, btnSadhu)
        userRadioButton!.delegate = self
        userRadioButton!.shouldLetDeSelect = true
        btnShravak.isSelected = true
        
        
        languageRadioButton = SSRadioButtonsController(buttons: btnEnglish, btnHindi,btnGujarati)
        languageRadioButton!.delegate = self
        languageRadioButton!.shouldLetDeSelect = true
        btnEnglish.isSelected = true
        
        imgTopLogo.frame = CGRect(x:70,y:40,width:self.view.frame.width-140,height:150)
        
        lblMemberType.frame = CGRect(x:20,y:imgTopLogo.frame.origin.y+self.imgTopLogo.frame.height,width:self.view.frame.width-40,height:45)
        
        
        
        shravakView.frame = CGRect(x:20,y:lblMemberType.frame.origin.y+self.lblMemberType.frame.height+10,width:self.view.frame.width-40,height:70)
        btnShravak.frame = CGRect(x:20,y:15,width:self.view.frame.width-40,height:40)
        shravakView.addSubview(btnShravak)
        
        
        
        
        guruView.frame = CGRect(x:20,y:shravakView.frame.origin.y+self.shravakView.frame.height+10,width:self.view.frame.width-40,height:70)
        btnSadhu.frame = CGRect(x:20,y:15,width:self.view.frame.width-40,height:40)
        guruView.addSubview(btnSadhu)
        
        lblChooseLanguage.frame = CGRect(x:20,y:guruView.frame.origin.y+self.guruView.frame.height+10,width:self.view.frame.width-40,height:45)
        
        
         englishView.frame = CGRect(x:20,y:lblChooseLanguage.frame.origin.y+self.lblChooseLanguage.frame.height+10,width:self.view.frame.width-40,height:70)
        btnEnglish.frame = CGRect(x:20,y:15,width:self.view.frame.width-40,height:40)
        englishView.addSubview(btnEnglish)
        
        
       hindiView.frame = CGRect(x:20,y:englishView.frame.origin.y+self.englishView.frame.height+10,width:self.view.frame.width-40,height:70)
        btnHindi.frame = CGRect(x:20,y:15,width:self.view.frame.width-40,height:40)
        hindiView.addSubview(btnHindi)
        
        gujaratiView.frame = CGRect(x:20,y:hindiView.frame.origin.y+self.hindiView.frame.height+10,width:self.view.frame.width-40,height:70)
        btnGujarati.frame = CGRect(x:20,y:15,width:self.view.frame.width-40,height:40)
        gujaratiView.addSubview(btnGujarati)
        
        btnNext.frame = CGRect(x:20,y:gujaratiView.frame.origin.y+self.gujaratiView.frame.height+25,width:self.view.frame.width-40,height:55)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func BtnNextClicked(_ sender: Any) {
        if(userRadioButton?.selectedButton() == nil){
            self.view.makeToast("Please Select Member type", duration: 2.0, position: .center)
            
        }else if(languageRadioButton?.selectedButton() == nil){
        self.view.makeToast("Please Select Language", duration: 2.0, position: .center)
        }
        else{
            if(userRadioButton?.selectedButton()!.currentTitle == "Jain Sadhu / Sadhavi" ){
                self.performSegue(withIdentifier: "registerToGuruRegisterDetails", sender: self)
            }else{
                print("slecte Buttno ",userRadioButton?.selectedButton()?.currentTitle)
                self.performSegue(withIdentifier: "registerToRegisterDetails", sender: self)
            }
            
           
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "registerToRegisterDetails"){
            let fullData = segue.destination as? FullRegistrationCntrl
            var langua = String()
            var memberType = String()
            if(languageRadioButton?.selectedButton()?.currentTitle == "English"){
                langua = "en"
                GlobalVariables.selectedLanguage = "en"
                UserDefaults.standard.setLanguage(value: "en")
            }else if(languageRadioButton?.selectedButton()?.currentTitle == "Hindi"){
                langua = "hi"
                GlobalVariables.selectedLanguage = "hi"
                UserDefaults.standard.setLanguage(value: "hi")
            }
            else{
                langua = "gu"
                GlobalVariables.selectedLanguage = "gu"
                UserDefaults.standard.setLanguage(value: "gu")
            }
            if(userRadioButton?.selectedButton()?.currentTitle == "Shravak / Shravika"){
                memberType = "Shravak"
            }else{
                memberType = "guru"
            }
            fullData?.language = langua
            fullData?.memberType = memberType
        }else if(segue.identifier == "registerToGuruRegisterDetails"){
            let fullData = segue.destination as? GuruRegisterCntr
            var langua = String()
            var memberType = String()
            if(languageRadioButton?.selectedButton()?.currentTitle == "English"){
                langua = "en"
                GlobalVariables.selectedLanguage = "en"
                UserDefaults.standard.setLanguage(value: "en")
            }else if(languageRadioButton?.selectedButton()?.currentTitle == "Hindi"){
                langua = "hi"
                GlobalVariables.selectedLanguage = "hi"
                UserDefaults.standard.setLanguage(value: "hi")
            }
            else{
                langua = "gu"
                GlobalVariables.selectedLanguage = "gu"
                UserDefaults.standard.setLanguage(value: "gu")
            }
            if(userRadioButton?.selectedButton()?.currentTitle == "Shravak / Shravika"){
                memberType = "Shravak"
            }else{
                memberType = "guru"
            }
            
            fullData?.language = langua
            fullData?.memberType = memberType
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func didSelectButton(selectedButton: UIButton?) {
        print("select Button",(selectedButton?.titleLabel?.text)!)
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
