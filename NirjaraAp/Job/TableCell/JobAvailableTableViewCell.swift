//
//  JobAvailableTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class JobAvailableTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPost: UILabel!
    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCountPos: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblContactPerson: UILabel!
    
    @IBOutlet weak var lblContactMob: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
