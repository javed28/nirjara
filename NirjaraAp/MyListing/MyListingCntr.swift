//
//  MyListingCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyListingCntr: UIViewController {

    @IBOutlet weak var myListingView: UIView!
    @IBOutlet weak var reportView: UIView!
    
    @IBOutlet weak var segmentCntr: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  My Listing"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:5))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:5,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        reportView.isHidden = true
        // Do any additional setup after loading the view.
    }

    
    @IBAction func segmentClicked(_ sender: Any) {
        
        switch (segmentCntr.selectedSegmentIndex) {
        case 0:
            myListingView.isHidden = false
            reportView.isHidden = true
            break
        case 1:
            myListingView.isHidden = true
            reportView.isHidden = false
        break
        default:
            break
        }
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
