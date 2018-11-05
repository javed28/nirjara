//
//  KnowledgeFooterTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class KnowledgeFooterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txtKnowledge: UITextField!
    
    @IBOutlet weak var btnAdded: UIButton!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
