//
//  CommentTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/23/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var member_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
