//
//  SearchBusinessCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/19/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class SearchBusinessCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUserIcon: UIImageView!
    @IBOutlet weak var imgPackageIcon: UIImageView!
    @IBOutlet weak var imgMobileIcon: UIImageView!
    @IBOutlet weak var imgLocationIcon: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var separaterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
