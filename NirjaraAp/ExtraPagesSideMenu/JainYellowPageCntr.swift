//
//  JainYellowPageCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class JainYellowPageCntr: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var btnAddBusiness: UIButton!
    @IBOutlet weak var btnMyListing: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            sideMenu()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jain Yellow Pages"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:14))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:14,length:5))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.addShadowToBarMap()
        //topBackground.frame = CGRect(x:0,y:95,width:self.view.frame.width,height:90)
        btnAddBusiness.frame = CGRect(x:10,y:10,width:topBackground.frame.width/2,height:50)
        btnMyListing.frame = CGRect(x:topBackground.frame.width/2+20,y:10,width:topBackground.frame.width/2,height:50)
        btnAddBusiness.setTitle("AddBusiness".localized1, for: .normal)
        btnMyListing.setTitle("MyListing".localized1, for: .normal)
        topBackground.addSubview(btnMyListing)
        topBackground.addSubview(btnMyListing)
        // Do any additional setup after loading the view.
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
