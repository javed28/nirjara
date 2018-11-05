//
//  BusinessTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblAgainTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
