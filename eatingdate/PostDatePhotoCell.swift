//
//  PostDatePhotoCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/9.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class PostDatePhotoCell: UITableViewCell {

    @IBOutlet weak var uploadPhotoView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var addLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
