//
//  SpecialOfferCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 6/21/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class SpecialOfferCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblOfferName: UILabel!
    @IBOutlet weak var lblOfferDesc: UILabel!
    @IBOutlet weak var lblOfferTarget: UILabel!
    @IBOutlet weak var lblOfferAchieved: UILabel!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnSendEnquiry: UIButton!
    
    @IBOutlet weak var lblActualPrice: UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
