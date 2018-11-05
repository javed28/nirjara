//
//  UIFont+Label.swift
//  cibogenie
//
//  Created by gadgetzone on 8/22/17.
//  Copyright © 2017 gadgetzone. All rights reserved.
//

import UIKit
extension UILabel {
    
    public var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
            var fontName = newValue;
           // print("newValuefont",fontNameToTest)
            if fontNameToTest.range(of: "bold") != nil {
                //print("newValuefont111",fontNameToTest)
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                //print("newValuefon2222",fontNameToTest)
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
               // print("newValuefont333",fontNameToTest)
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                //print("newValuefont4444",fontNameToTest)
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
    
    @IBDesignable class PaddingLabel: UILabel {
        
        @IBInspectable var topInset: CGFloat = 20.0
        @IBInspectable var bottomInset: CGFloat = 20.0
        @IBInspectable var leftInset: CGFloat = 20.0
        @IBInspectable var rightInset: CGFloat = 20.0
        
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        }
        
        func intrinsicContentSize() -> CGSize {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += topInset + bottomInset
            intrinsicSuperViewContentSize.width += leftInset + rightInset
            return intrinsicSuperViewContentSize
        }
    }
}
