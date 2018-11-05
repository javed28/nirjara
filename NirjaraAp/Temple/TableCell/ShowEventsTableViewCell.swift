//
//  ShowEventsTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/6/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ShowEventsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgEvents: UIImageView!
    
    @IBOutlet weak var lblEventsName: UILabel!
    @IBOutlet weak var lblEventsFrom: UILabel!
    @IBOutlet weak var lblEventsVenue: UILabel!
    @IBOutlet weak var lblEventsTo: UILabel!
    
    @IBOutlet weak var lblContactName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
