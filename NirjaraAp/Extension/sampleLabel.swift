//
//  sampleLabel.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation

class sampleLabel: UILabel {
    
    let topInset = CGFloat(5.0), bottomInset = CGFloat(5.0), leftInset = CGFloat(8.0), rightInset = CGFloat(8.0)
    
    override func drawText(in rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        
    }
     func intrinsicContentSize() -> CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
