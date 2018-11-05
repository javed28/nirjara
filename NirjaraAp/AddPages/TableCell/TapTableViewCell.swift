//
//  TapTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class TapTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTapName: UILabel!
    @IBOutlet weak var btnTapAdd: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
