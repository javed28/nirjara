//
//  DonationTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgDonation: UIImageView!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblFundReq: UILabel!
    @IBOutlet weak var lblBalanceReq: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var lblPatientName: UILabel!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblFundRec: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
