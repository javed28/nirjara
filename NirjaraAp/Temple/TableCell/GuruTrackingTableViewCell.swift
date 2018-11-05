//
//  GuruTrackingTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/8/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class GuruTrackingTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var switchOnOff: UISwitch!
    @IBOutlet weak var lblGuruName: UILabel!
    @IBOutlet weak var imgNamaskar: UIImageView!
    @IBOutlet weak var bottomBorder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        
        
    }
    

}
