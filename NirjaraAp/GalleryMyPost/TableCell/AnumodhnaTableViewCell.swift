//
//  AnumodhnaTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class AnumodhnaTableViewCell: UITableViewCell {

    @IBOutlet weak var member_name: UILabel!
    @IBOutlet weak var member_photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
