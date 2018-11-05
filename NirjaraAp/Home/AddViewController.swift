//
//  AddViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var btnActiveSamajSeva: UIButton!
    @IBOutlet weak var btnAddViharStay: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var btnAddTemple: UIButton!
    
    @IBOutlet weak var btnAddTap: UIButton!
    @IBOutlet weak var btnAddBusiness: UIButton!
    @IBOutlet weak var btnAddEvents: UIButton!
    @IBOutlet weak var btnAddSecurity: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopMenu()
        
        btnAddViharStay.frame = CGRect(x:30,y:100,width:self.view.frame.width-60,height:50)
        btnActiveSamajSeva.frame = CGRect(x:30,y:btnAddViharStay.frame.origin.y+btnAddViharStay.frame.height+15,width:self.view.frame.width-60,height:50)
        btnAddTemple.frame = CGRect(x:30,y:btnActiveSamajSeva.frame.origin.y+btnActiveSamajSeva.frame.height+15,width:self.view.frame.width-60,height:50)
        btnAddSecurity.frame = CGRect(x:30,y:btnAddTemple.frame.origin.y+btnAddTemple.frame.height+15,width:self.view.frame.width-60,height:50)
        btnAddEvents.frame = CGRect(x:30,y:btnAddSecurity.frame.origin.y+btnAddSecurity.frame.height+15,width:self.view.frame.width-60,height:50)
        btnAddBusiness.frame = CGRect(x:30,y:btnAddEvents.frame.origin.y+btnAddEvents.frame.height+15,width:self.view.frame.width-60,height:50)
        btnAddTap.frame = CGRect(x:30,y:btnAddBusiness.frame.origin.y+btnAddBusiness.frame.height+15,width:self.view.frame.width-60,height:50)
      
        btnAddViharStay.setTitle("AddViharStayMember".localized1, for: .normal)
        btnActiveSamajSeva.setTitle("Active".localized1+" "+"Samaj".localized1, for: .normal)
        btnAddTemple.setTitle("AddTemple".localized1, for: .normal)
        btnAddSecurity.setTitle("AddSecurityAlert".localized1+" "+"Number".localized1, for: .normal)
        btnAddEvents.setTitle("Add".localized1+" "+"Events".localized1, for: .normal)
        btnAddBusiness.setTitle("AddBusiness".localized1, for: .normal)
        btnAddTap.setTitle("Addtapoftheday".localized1, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    func setTopMenu(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        if(UserDefaults.standard.getLanguage() == "en"){
           
            var myString:NSString = "  Add"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:5))
            
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
            
        }else if(UserDefaults.standard.getLanguage() == "hi"){
            var myString:NSString = "  जोड़े"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:4))
           
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            var myString:NSString = "  ઉમેરો"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:5))
            
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points".localized1, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        sideMenu()
    }
    
    func sideMenu(){
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            // menuButton.image  = UIImage(named:"hamburger")?.withRenderingMode(.alwaysOriginal);
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 180
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
