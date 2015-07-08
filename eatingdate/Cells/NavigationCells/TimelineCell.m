//
//  TimelineCell.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "TimelineCell.h"
#import "MegaTheme.h"

@implementation TimelineCell

- (void)awakeFromNib {
    // Initialization code
    self.dateImageView.image = [UIImage imageNamed:@"clock"];
    self.dateImageView.alpha = 0.20;
    self.profileImageView.layer.cornerRadius = 30;
    
    self.nameLabel.font = [UIFont fontWithName: MegaTheme.fontName size: 16];
    self.nameLabel.textColor = MegaTheme.darkColor;
    
    self.postLabel.font = [UIFont fontWithName: MegaTheme.fontName size: 14];
    self.postLabel.textColor = MegaTheme.lightColor;
    
    self.dateLabel.font = [UIFont fontWithName: MegaTheme.fontName size: 14];
    self.dateLabel.textColor = MegaTheme.lightColor;
    
    self.photoImageView.layer.borderWidth = 0.4;
    self.photoImageView.layer.borderColor = [UIColor colorWithWhite:0.92 alpha:1.0].CGColor;
    
    
}

-(void)layoutSubviews
{
    
    if (self.postLabel != nil) {
        UILabel* label = self.postLabel;
        label.preferredMaxLayoutWidth = CGRectGetWidth(label.frame);
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
