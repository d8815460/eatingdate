//
//  AskCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/13.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class AskCell: UITableViewCell {

    var friends:NSArray!
    @IBOutlet weak var askCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var friendsLayout: UICollectionViewFlowLayout!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
