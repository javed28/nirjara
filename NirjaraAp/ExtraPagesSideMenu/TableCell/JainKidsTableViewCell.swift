//
//  JainKidsTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class JainKidsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblMeaning: UILabel!
    @IBOutlet weak var lblKidsName: UILabel!
    @IBOutlet weak var imgKidsIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
