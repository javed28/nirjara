//
//  MyPostsTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPostName: UILabel!
    @IBOutlet weak var lblAtPost: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var viewLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
