//
//  AdvertiseTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class AdvertiseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblAdvertiseName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgWhoPost: UIImageView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var imgWhatpost: UIImageView!
   
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblViews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
