//
//  ShowChaturmasTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ShowChaturmasTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var imgMobile: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblChaturDetail: UILabel!
    @IBOutlet weak var lblChaturName: UILabel!
    @IBOutlet weak var lblChaturMobile: UILabel!
    @IBOutlet weak var lblChaturAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
