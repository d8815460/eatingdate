//
//  ChoseTaCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/17.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class ChoseTaCell: PFTableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var yearsoldLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var choseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoView.layer.cornerRadius = 42.5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
