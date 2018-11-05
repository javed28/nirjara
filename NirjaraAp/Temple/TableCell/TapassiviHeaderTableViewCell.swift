//
//  TapassiviHeaderTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/24/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class TapassiviHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var lblNote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
