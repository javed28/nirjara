//
//  AboutViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/3/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class AboutViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblAbout: UILabel!
    
    @IBOutlet weak var imgNext: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
