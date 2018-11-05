//
//  MyGalleryPostsTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyGalleryPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGalleryName: UILabel!
    
    
    @IBOutlet weak var imgWhoPost: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var btnAnumodha: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var imgWhatpost: UIImageView!
    @IBOutlet weak var btnDarshan: UIButton!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var btnAnumodhaText: UIButton!
    @IBOutlet weak var btnDarshanText: UIButton!
    @IBOutlet weak var btnCommentText: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
