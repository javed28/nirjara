//
//  UITextField+LeftMargin.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
extension UITextField {
    func setTextLeftPadding(left:CGFloat) {
        var leftView:UIView = UIView(frame: CGRect(x:0,y:0,width:left,height:1))
        leftView.backgroundColor = UIColor.clear
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewMode.always;
    }
    
    func border(textname : UITextField,placholderText : String){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 4, y : textname.frame.height-1,width:textname.frame.width-28, height : 1.0)
        let color = UIColor.rgb(hexcolor:"#DCDCDC").cgColor
        bottomLine.backgroundColor = color
        textname.setTextLeftPadding(left: 10)
        
        textname.attributedPlaceholder = NSAttributedString(string:placholderText, attributes:[NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "DCDCDC"),NSAttributedStringKey.font :UIFont(name: "Arial", size: 18)!])
        textname.borderStyle = UITextBorderStyle.none
        textname.layer.addSublayer(bottomLine)
    }
}
