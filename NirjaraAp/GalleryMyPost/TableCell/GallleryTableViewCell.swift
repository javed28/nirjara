//
//  GallleryTableViewCell.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/12/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class GallleryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWhoPostName: UILabel!
    @IBOutlet weak var btnAnumodha: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnDarshan: UIButton!
    @IBOutlet weak var imgWhatpost: UIImageView!
    @IBOutlet weak var imgWhoPost: UIImageView!
    @IBOutlet weak var btnBlock: UIButton!
    
    @IBOutlet weak var btnTextDarshan: UIButton!
    @IBOutlet weak var btnTextAnumodha: UIButton!
    @IBOutlet weak var btnTextComment: UIButton!
    
    @IBOutlet weak var lblCaption: UILabel!
    
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   /* internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                imgWhatpost.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                imgWhatpost.addConstraint(aspectConstraint!)
            }
        }
    }*/
    
    override func prepareForReuse() {
        super.prepareForReuse()
       // aspectConstraint = nil
    }
    
   /* func setCustomImage(image : UIImage) {
        
        let aspect = image.size.width / image.size.height
        
        let constraint = NSLayoutConstraint(item: imgWhatpost, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: imgWhatpost, attribute: NSLayoutAttribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        
        aspectConstraint = constraint
        imgWhatpost.image = image
        //let placeholderImage = UIImage(named: "default_icon_new")!
       // imgWhatpost.af_setImage(withURL: postUrl!,placeholderImage: placeholderImage)
    }*/

}
