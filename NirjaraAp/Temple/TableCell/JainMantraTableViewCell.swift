//
//  JainMantraTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/8/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class JainMantraTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnImp: UIButton!
    @IBOutlet weak var btnLabh: UIButton!
    @IBOutlet weak var btnListen: UIButton!
    @IBOutlet weak var btnRead: UIButton!
    @IBOutlet weak var btnVidhi: UIButton!
    
   
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var viewListen: UIView!
    @IBOutlet weak var viewImp: UIView!
    @IBOutlet weak var viewRead: UIView!
    @IBOutlet weak var viewVidhi: UIView!
    @IBOutlet weak var viewLabh: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
