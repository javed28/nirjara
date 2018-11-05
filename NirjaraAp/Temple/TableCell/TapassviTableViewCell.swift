//
//  TapassviTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/24/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class TapassviTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tapasvi_image: UIImageView!
    @IBOutlet weak var tapassya_name: UILabel!
    
    @IBOutlet weak var btnAnumodhnaLike: UIButton!
    @IBOutlet weak var tapasvi_name: UILabel!
    @IBOutlet weak var imgMainGroup: UIImageView!
    @IBOutlet weak var tapasvi_age: UILabel!
    @IBOutlet weak var total_likes: UIButton!
    
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var total_comment: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
