//
//  EventHeaderTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/16/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class EventHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHeaderText: UILabel!
    @IBOutlet weak var mainBackGround: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
