//
//  PostDateCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/24.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class PostDateCell: PFTableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexImageView: UIImageView!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var eyeIconImageView: UIImageView!
    @IBOutlet weak var beenLookedLabel: UILabel!
    @IBOutlet weak var askLabel: UILabel!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var whoTreatLabel: UILabel!
    @IBOutlet weak var sinceritygoodLabel: UILabel!
    
    @IBOutlet weak var whoTreatButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImageView.layer.cornerRadius = 33
        self.progressView.hidden = true
        self.bgImageView.image = UIImage(named: "img_ctn_box")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func whoTreatButtonPressed(sender: AnyObject) {
        
    }
    
}
