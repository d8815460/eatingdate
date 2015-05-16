//
//  ChoseRestaurantCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/12.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class ChoseRestaurantCell: PFTableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var iconLocal: UIImageView!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var minCostLabel: UILabel!
    @IBOutlet weak var choseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
