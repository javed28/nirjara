//
//  MakePaymentCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import InstaMojoiOS

class MakePaymentCntr: UIViewController {

    @IBOutlet weak var btnMakePayment: UIButton!
    var businessId = String()
    
    @IBOutlet weak var btnSkipPayment: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Business Information"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:11))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        
        self.updateBackButton()
        btnSkipPayment.frame = CGRect(x:self.view.frame.width-150,y:100,width:140,height:50)
        btnMakePayment.frame = CGRect(x:10,y:160,width:self.view.frame.width-20,height:50)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMakePaymentClicked(_ sender: Any) {
        //self.view.makeToast("We are Working on it")
       /* let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "paymentStoryIdentifier") as? PaymentViewCntr
        gotoOtherUpload?.businessId = String(describing: businessId)
        self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)*/

        
        IMConfiguration.sharedInstance.setupOrder(purpose: "Buying", buyerName: "Javed", emailId: "javed@beeonline.co.in", mobile: "8652309010", amount: "40", environment: .Production, on: self, completion: {
            (success, message) in
            DispatchQueue.main.async{
                print("message----",success)
                print("message----",message)
                if success {
                    print("message----",message)
                    
                } else {
                    print("message----",message)
                    
                }
        }
        })
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
