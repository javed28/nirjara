//
//  ShowTempleViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ShowTempleViewCell: UITableViewCell {

    @IBOutlet weak var lblTempleName: UILabel!
    @IBOutlet weak var lblTempleAddress: UILabel!
    @IBOutlet weak var lblTempleDistance: UILabel!
    @IBOutlet weak var btnEditTemple: UIButton!
    @IBOutlet weak var imgTemple: UIImageView!
    @IBOutlet weak var templeMainView: UIView!
    
   
    @IBOutlet weak var imgStay: UIImageView!
    
    @IBOutlet weak var imgFood: UIImageView!
    
    @IBOutlet weak var locationIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
