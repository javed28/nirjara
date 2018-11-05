//
//  PachKanHeaderTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class PachKanHeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTodayPachText: UILabel!
    @IBOutlet weak var mainTitleView: UIView!
    
    @IBOutlet weak var lblTemple: UILabel!
    @IBOutlet weak var lblRead: UILabel!
    @IBOutlet weak var lblSthanak: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var viewlblPachkan: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
