//
//  RestaurantCategoryCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/10.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit
import Foundation

class RestaurantCategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.layer.masksToBounds = true;
    }
}