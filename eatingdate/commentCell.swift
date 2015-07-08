//
//  commentCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/21.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
