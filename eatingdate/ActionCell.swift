//
//  ActionCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/9.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var askOrModifyButton: UIButton!
    
    @IBOutlet weak var sendToFriendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
