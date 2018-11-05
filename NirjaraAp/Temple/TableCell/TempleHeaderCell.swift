//
//  TempleHeaderCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class TempleHeaderCell: UITableViewCell {

    @IBOutlet weak var btnAddTemple: UIButton!
    @IBOutlet weak var btnMyTemple: UIButton!
    @IBOutlet weak var headerMainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
