//
//  KnowledgeHeaderViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class KnowledgeHeaderViewCell: UITableViewCell {
    @IBOutlet weak var headerMainView: UIView!
    
    @IBOutlet weak var txtKnowledge: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
