//
//  PostDateHeaderView.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/24.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class PostDateHeaderView: PFTableViewCell {

    @IBOutlet weak var myChoseLabel: UILabel!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var chineseDayLabel: UILabel!
    @IBOutlet weak var englishDayLabel: UILabel!
    @IBOutlet weak var postDateNumber: UILabel!
    @IBOutlet weak var checkDateNumber: UILabel!
    
    @IBOutlet weak var postContentView: UIView!
    @IBOutlet weak var checkContentView: UIView!
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        self.postContentView.layer.cornerRadius = 10
        self.checkContentView.layer.cornerRadius = 10
        
    }
    

}
