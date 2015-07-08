//
//  MapCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/9.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class MapCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
