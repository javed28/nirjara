//
//  ChooseLangTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/3/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ChooseLangTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txtLanguage: UILabel!
    
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var imgCheck: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
