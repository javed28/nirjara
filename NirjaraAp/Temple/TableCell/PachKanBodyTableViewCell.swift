//
//  PachKanBodyTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class PachKanBodyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnRead: UIButton!
    @IBOutlet weak var btnPlay1: UIButton!
    
    @IBOutlet weak var lblFooterText: UILabel!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var btnPlay2: UIButton!
    
    @IBOutlet weak var btnReadView: UIView!
    @IBOutlet weak var btnPlay1View: UIView!
    @IBOutlet weak var lblTitleView: UIView!
    @IBOutlet weak var btnPlay2View: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
